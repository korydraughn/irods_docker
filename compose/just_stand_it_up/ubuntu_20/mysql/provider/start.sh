#! /bin/bash

# Wait for the MySQL database to accept connections.
python wait_for_database.py catalog

# Download and setup the MySQL v8 ODBC Driver.
wget https://dev.mysql.com/get/Downloads/Connector-ODBC/8.0/mysql-connector-odbc-8.0.29-linux-glibc2.12-x86-64bit.tar.gz
mysql_odbc_driver_root=/opt/odbc-driver/mysql
mkdir -p ${mysql_odbc_driver_root}
tar -C ${mysql_odbc_driver_root} -xzf mysql-connector-odbc-8.0.29-linux-glibc2.12-x86-64bit.tar.gz

# Update the zone name.
sed -i "15s/.*/$IRODS_ZONE_NAME/" /provider.input

# Make sure the apt repository is up to date.
apt-get update

# Install the iRODS packages.
pushd /irods_packages
dpkg -i irods-{runtime,icommands,server,database-plugin-mysql}*deb || true
apt-get install -fy
popd

# Set up iRODS.
#python /var/lib/irods/scripts/setup_irods.py < /provider.input

# Start iRODS (4.2.9+).
#su - irods -c './irodsctl -v start'

# Keep container running.
sleep 2147483647d
