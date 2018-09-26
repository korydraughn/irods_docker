#! /bin/bash

#service krb5-kdc start
#service krb5-admin-server start
service postgresql start
#service rpcbind start

seconds=10
echo "Sleeping for $seconds seconds to let the database complete start up ..."
sleep $seconds

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_postgres.input

# Create new directory for mounting NFSRODS and
# authenticate the user with the Kerberos server.
#mkdir /mnt/nfsrods
#echo rods | kinit -f rods

# Compile NFSRODS.
git clone https://github.com/irods/irods_client_nfsrods
cd irods_client_nfsrods
git checkout dev && mvn clean install -Dmaven.test.skip=true
mv /server.json /log4j.properties /irods_client_nfsrods/irods-vfs-impl/config

# Move Kerberos files into the correct location.
mv /krb5.conf /krb5.keytab /etc/

# Run the NFSRODS server in the background.
rpcbind
export NFSRODS_HOME=/irods_client_nfsrods/irods-vfs-impl
java -jar $NFSRODS_HOME/target/irods-vfs-impl-1.0.0-SNAPSHOT-jar-with-dependencies.jar
