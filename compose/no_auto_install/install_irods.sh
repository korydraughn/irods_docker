#! /bin/bash

cd irods_server_packages
dpkg -i irods-{runtime,server,database-plugin-postgres}*.deb ../icommands_packages/*.deb
apt-get install -fy
python /var/lib/irods/scripts/setup_irods.py < /provider.input

