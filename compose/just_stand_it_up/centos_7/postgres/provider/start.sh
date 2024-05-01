#! /bin/bash

# Wait for the Postgres database to start.
su - postgres -c 'pg_ctl start'
counter=0
until nc -z catalog 5432
do
    sleep 1
    ((counter += 1))
done
echo Postgres took approximately $counter seconds to fully start ...

# Update the zone name.
sed -i "12s/.*/$IRODS_ZONE_NAME/" /provider.input

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /provider.input

# Keep container running.
exec /usr/sbin/init
