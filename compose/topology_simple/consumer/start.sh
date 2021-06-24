#! /bin/bash

# Wait for the iRODS provider to start.
until nc -z provider 1247; do
    sleep 1
done

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /consumer.input

# Start the iRODS server (this is required for 4.2.9 and later).
# This will generate an error for previous versions, which is totally harmless.
su - irods -c './irodsctl -v start'

# Keep container running.
sleep 2147483647d
