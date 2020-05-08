#! /bin/bash

# Start the Postgres database.
service postgresql start
counter=0
until pg_isready -q
do
    sleep 1
    ((counter += 1))
done
echo Postgres took approximately $counter seconds to fully start ...

# Update the zone name if requested.
zone_name="$1"
[ ! -z "$zone_name" ] && sed -i "12s/.*/$zone_name/" /var/lib/irods/packaging/localhost_setup_postgres.input

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_postgres.input

# Keep container running if the test fails.
# Is this better? sleep 2147483647d
tail -f /dev/null

