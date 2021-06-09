#! /bin/bash

# Wait for the MySQL database to accept connections.
python wait_for_database.py catalog

# Do last minute MySQL setup.
#ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock

# Update the zone name.
sed -i "12s/.*/$IRODS_ZONE_NAME/" /provider.input

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /provider.input

# Keep container running.
sleep 2147483647d
