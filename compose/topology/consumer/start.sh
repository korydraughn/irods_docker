#! /bin/bash

# Wait for the iRODS provider to start.
#python /wait_for_remote_host.py provider 1247
until nc -z provider 1247; do
    sleep 1
done

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /consumer.input

# Install the hosts_config.json file and restart the server.
cp /hosts_config.json /etc/irods
su - irods -c './irodsctl restart'

# Keep container running.
sleep 2147483647d
