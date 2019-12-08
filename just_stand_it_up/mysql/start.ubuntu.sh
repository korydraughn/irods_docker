#! /bin/bash

# Start the database.
service mysql start
python wait_for_database.py

# Do last minute MySQL setup.
#cp /mysql-connector-odbc-5.2.7-linux-glibc2.5-x86-64bit/lib/* /usr/lib
ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_mysql.input

# Keep container running if the test fails.
# Is this better? sleep 2147483647d
tail -f /dev/null

