#! /bin/bash

apt update -y
dpkg -i /irods_server_packages/irods-{dev,runtime}*.deb \
        /icommands_packages/irods-*.deb \
        /irods_server_packages/irods-{database-plugin-postgres,server}*.deb
apt install -fy
