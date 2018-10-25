#! /bin/bash

test_name=$1
sleep_time=${2:-60}

# Start the Postgres database.
service postgresql start
sleep $sleep_time

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_postgres.input

# Run test.
cp /run_test.sh /var/lib/irods/
chown irods:irods /var/lib/irods/run_test.sh
su - irods -c "./run_test.sh $test_name"

# Keep container running if the test fails.
if [[ $? != 0 ]]; then
    tail -f /dev/null
fi
