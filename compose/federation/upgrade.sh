#! /bin/bash

apt-get update -y
dpkg -i /irods_packages/irods-{runtime,icommands,database-plugin-postgres,server}*.deb
apt-get install -fy
