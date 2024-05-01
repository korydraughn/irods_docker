#! /bin/bash

apt update -y
dpkg -i /icommands_packages/irods-*.deb
apt install -fy
