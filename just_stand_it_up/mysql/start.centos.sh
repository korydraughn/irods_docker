#! /bin/bash

mysql_db_hostname="$1"
mysql_db_port="${2:-3306}"

# Start the database.
#systemctl mysql start
python wait_for_database.py $mysql_db_hostname

# Do last minute MySQL setup.
ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock

# Set up iRODS.
sed -i "5s/.*/$mysql_db_hostname/" /var/lib/irods/packaging/localhost_setup_mysql.input
sed -i "6s/.*/$mysql_db_port/" /var/lib/irods/packaging/localhost_setup_mysql.input
python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_mysql.input

# Keep container running if the test fails.
exec /usr/sbin/init

