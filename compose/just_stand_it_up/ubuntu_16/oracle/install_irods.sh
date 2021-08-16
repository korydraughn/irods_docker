#! /bin/bash

su - irods -c './irodsctl -v stop'
dpkg -i /irods_server_packages/irods-{dev,runtime,database-plugin-oracle}*.deb \
        /icommands_packages/irods-icommands*.deb \
        /irods_server_packages/irods-server*.deb
apt install -fy
su - irods -c './irodsctl -v start'
