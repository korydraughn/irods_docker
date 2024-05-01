#! /bin/bash

# Wait for the Postgres database to start.
counter=0
until pg_isready -h catalog -d ICAT -U irods -q
do
    sleep 1
    ((counter += 1))
done
echo Postgres took approximately $counter seconds to fully start ...

# Update the zone name.
sed -i "12s/.*/$IRODS_ZONE_NAME/" /provider.input

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /provider.input

# Start the iRODS server (this is required for 4.2.9 and later).
# This will generate an error for previous versions, which is totally harmless.
su - irods -c './irodsctl -v start'

# Create an additional rodsadmin user.
su - irods -c 'iadmin mkuser otherrods rodsadmin && iadmin moduser otherrods password rods'

# Keep container running.
sleep 2147483647d
