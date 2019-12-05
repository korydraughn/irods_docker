#! /bin/bash

if [ ! -d /run/postgresql ]; then
    mkdir /run/postgresql
    chown postgres:postgres /run/postgresql
fi

# Start the Postgres database.
su - postgres -c 'pg_ctl start'
counter=0
until su - postgres -c "psql ICAT -c '\d'"
do
    sleep 1
    ((counter += 1))
done
echo Postgres took approximately $counter seconds to fully start ...

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_postgres.input

# Keep container running if the test fails.
# Is this better? sleep 2147483647d
exec /usr/sbin/init
#tail -f /dev/null

