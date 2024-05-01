#! /bin/bash

apt-get update -y
dpkg -i /irods_packages/irods-icommands*.deb
apt-get install -fy
