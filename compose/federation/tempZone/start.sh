#! /bin/bash

# Wait for the Postgres database to start.
counter=0
until pg_isready -h tempzone_catalog -d ICAT -U irods -q
do
    sleep 1
    ((counter += 1))
done
echo Postgres took approximately $counter seconds to fully start ...

# Update the zone name.
#sed -i "12s/.*/$IRODS_ZONE_NAME/" /provider.input

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /provider.input

# Inject the Federation configuration.
cat /etc/irods/server_config.json | \
    jq --argjson config "$(cat /federation.json)" '.federation = $config + .federation' > /server_config.json && \
    mv /server_config.json /etc/irods/server_config.json

# Finish setting up the remote zone.
su - irods -c 'iadmin mkzone otherZone remote otherzone_provider:1247'

# Create an additional rodsuser for federation.
su - irods -c 'iadmin mkuser alice rodsuser && iadmin moduser alice password rods'
su - irods -c 'iadmin mkuser bobby#otherZone rodsuser && iadmin moduser bobby#otherZone password rods'

# Keep container running.
sleep 2147483647d
