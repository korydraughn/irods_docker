#! /bin/bash

test_name=$1

# Start the Postgres database.
service postgresql start
until pg_isready -q
do
    echo waiting for database ...
    sleep 3
done

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_postgres.input

# Run test.
cp /run_test.sh /var/lib/irods/
chown irods:irods /var/lib/irods/run_test.sh
su - irods -c "./run_test.sh $test_name"
ec=$?

# Make test results available to docker host.
cd /var/lib/irods/log
mkdir /irods_test_env/$test_name
cp rodsLog* rodsServerLog* test_log.txt /irods_test_env/$test_name

# Keep container running if the test fails.
if [[ $ec != 0 ]]; then
    tail -f /dev/null
fi
