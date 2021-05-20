#! /bin/bash

set -x

unzip instantclient-basic-linux.x64-21.1.0.0.0.zip
unzip instantclient-odbc-linux.x64-21.1.0.0.0.zip
unzip instantclient-sqlplus-linux.x64-21.1.0.0.0.zip

# Configure the linker so that the iRODS service account can load
# the Oracle ODBC driver.
echo /instantclient_21_1 > /etc/ld.so.conf.d/oracle-instantclient.conf
ldconfig

# Make the sqlplus binary available for use.
export PATH=/instantclient_21_1:$PATH

pushd instantclient_21_1 && ./odbc_update_ini.sh / && popd

# Wait for the Oracle database to accept connections.
until sqlplus /nolog @is_oracle_db_up.sql > /dev/null; do
    sleep 120
done

# Update the zone name.
sed -i "12s/.*/$IRODS_ZONE_NAME/" /provider.input

# Because we can't detect when the Oracle database will be ready,
# Let the user handle setting up iRODS.
echo When the Oracle database prints "DATABASE IS READY TO USE!",
echo run the following command as root to configure iRODS:
echo
echo    python /var/lib/irods/scripts/setup_irods.py < /provider.input
echo

# Keep container running.
sleep 2147483647d
