#! /bin/bash

unzip instantclient-basic-linux.x64-21.1.0.0.0.zip
unzip instantclient-odbc-linux.x64-21.1.0.0.0.zip

export LD_LIBRARY_PATH=/instantclient_21_1:$LD_LIBRARY_PATH
export PATH=/instantclient_21_1:$PATH

cd instantclient_21_1 && ./odbc_update_ini.sh /

# Wait for the Oracle database to accept connections.
python wait_for_database.py catalog

# Update the zone name.
sed -i "12s/.*/$IRODS_ZONE_NAME/" /provider.input

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /provider.input

# Keep container running.
sleep 2147483647d
