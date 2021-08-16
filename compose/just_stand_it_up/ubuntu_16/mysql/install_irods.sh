#! /bin/bash

su - irods -c './irodsctl -v stop'
dpkg -i /irods_server_packages/irods-{dev,runtime,database-plugin-mysql}*.deb \
        /icommands_packages/irods-icommands*.deb \
        /irods_server_packages/irods-server*.deb
apt install -fy
