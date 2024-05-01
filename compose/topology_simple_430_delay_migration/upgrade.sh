#! /bin/bash

apt update -y
dpkg -i /irods_packages/irods-{dev,runtime,icommands,server,database-plugin-postgres}*.deb
apt install -fy
python3 /var/lib/irods/scripts/setup_rsyslog_and_logrotate.py
