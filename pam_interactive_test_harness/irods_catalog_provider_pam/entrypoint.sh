#! /bin/bash -e

set -x

tls_certs_dir=/tls_certs
key_file=${tls_certs_dir}/irods_server.key
if [ ! -f "${key_file}" ]; then
    echo "Generating self-signed certificate"
    mkdir -p ${tls_certs_dir}
    openssl genrsa -out ${key_file} 2048
    openssl req -batch -new -x509 -key ${key_file} -out ${tls_certs_dir}/irods_server.crt -days 1
    openssl dhparam -2 -out ${tls_certs_dir}/irods_dhparams.pem 2048
fi
ls -l ${tls_certs_dir}

pam_module=pam_clear_token.so
if [ ! -f "${pam_module}" ]; then
    echo "Building PAM module for clearing auth tokens"
    gcc -fPIC -fno-stack-protector -o pam_clear_token.o -c /pam_auth_support/pam_clear_token.c
    gcc -shared -o ${pam_module} pam_clear_token.o
fi
ls -l ${pam_module}

pam_userdb_file=/pam_userdb.db
if [ ! -f "${pam_userdb_file}" ]; then
    echo "Building user database file - ${pam_userdb_file}"
    bash /pam_auth_support/make_user_database.sh
fi
ls -l ${pam_userdb_file}

echo "Waiting for iRODS catalog database to be ready"
catalog_db_hostname=irods-catalog
until pg_isready -h ${catalog_db_hostname} -d ICAT -U irods -q; do
    sleep 1
done
echo "iRODS catalog database is ready"

unattended_install_file=/unattended_install.json
if [ -f "${unattended_install_file}" ]; then
    echo "Running iRODS setup"

    # Configure the server with secure communication (TLS) disabled. This
    # avoids issues with setup (e.g. the post install test).

    # Add generated hostname as a recognizable alias.
    sed -i "s/CONTAINER_HOSTNAME_ALIAS/${HOSTNAME}/g" ${unattended_install_file}
    python3 /var/lib/irods/scripts/setup_irods.py --json_configuration_file ${unattended_install_file}

    # Move the input file used to configure the server out of the way so
    # the container is restartable.
    mv ${unattended_install_file} ${unattended_install_file}.processed

    # Give the iRODS service account ownership of the TLS certificates.
    chown -R irods:irods ${tls_certs_dir}

    # Update the server's configuration for secure communication.
    sed -i 's/="CS_NEG_REFUSE"/="CS_NEG_REQUIRE"/g' /etc/irods/core.re
    sed -i 's/CS_NEG_REFUSE/CS_NEG_REQUIRE/g' /etc/irods/server_config.json /var/lib/irods/.irods/irods_environment.json

    # Put PAM configuration files into the correct location.
    ln -s /pam_auth_support/pam_password /etc/pam.d/irods
    ln -s /pam_auth_support/pam_interactive /etc/pam.d/pam_interactive

    # Create the Linux user. The password matches the one used in the irods4j tests.
    test_username=john
    useradd -m ${test_username}
    echo "${test_username}:=i;r@o\\d&s" | chpasswd
fi
cat /etc/irods/server_config.json
echo
cat /var/lib/irods/.irods/irods_environment.json
echo

echo "Temporarily starting iRODS server and creating PAM-enabled user"
su - irods -c 'irodsServer -d'
sleep 3 # Give the server a little time to start.
su - irods -c 'iadmin mkuser john rodsuser'

echo "Restarting iRODS server in foreground"
kill $(cat /var/run/irods/irods-server.pid)
sleep 3 # Give the server a little time to stop.
su - irods -c 'irodsServer --stdout'
