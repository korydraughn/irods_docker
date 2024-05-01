#! /bin/bash

# Generate some REI files.
su - irods -c 'irule -F /test_rule.r'
su - irods -c 'irule -F /test_rule.r'
su - irods -c 'irule -F /test_rule.r'
su - irods -c 'irule -F /test_rule.r'
su - irods -c 'iqstat'
su - irods -c './irodsctl stop'
ls -l /var/lib/irods/config/packedRei

# Install new packages.
cd irods_server_packages
dpkg -i irods-{dev,runtime,server,database-plugin-post}*.deb ../icommands_packages/*.deb
apt-get update -y --fix-missing
apt-get install -fy

# Start the server (trigger the upgrade process).
su - irods -c './irodsctl start'
ls -l /var/lib/irods/config/packedRei #/var/lib/irods/config/packedRei/migrated_to_catalog_by_upgrade
