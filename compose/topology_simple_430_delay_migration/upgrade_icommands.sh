#! /bin/bash

apt update -y
dpkg -i /irods_packages/irods-icommands*.deb
apt install -fy
