#! /bin/bash

# Start the Postgres database.
service postgresql start
sleep ${2:-60}

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_postgres.input

# Run test.
cp /run_test.sh /var/lib/irods/
chown irods:irods /var/lib/irods/run_test.sh
su - irods -c "./run_test.sh $1"

# Keep container running.
tail -f /dev/null
