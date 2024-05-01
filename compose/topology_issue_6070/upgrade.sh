#! /bin/bash

exit
apt update -y
dpkg -i /irods_packages/irods-{dev,runtime}*.deb \
        /irods_packages/irods-icommands*.deb \
        /irods_packages/irods-{server,database-plugin-postgres}*.deb
apt install -fy
