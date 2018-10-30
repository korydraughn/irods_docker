#! /bin/bash

test_name=$1

# Start the Postgres database.
service postgresql start
until pg_isready -q
do
    echo waiting for database ...
    sleep 1
done

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_postgres.input

if [ -f /test_hooks/pre_test.sh ]; then
    chmod +x ./test_hooks/pre_test.sh
    ./test_hooks/pre_test.sh
fi

# Run test.
test_output=/var/lib/irods/log/test_output.txt
su - irods -c "python scripts/run_tests.py -xml_output --run_specific_test $test_name > $test_output 2>&1"
ec=$?

if [ -f /test_hooks/post_test.sh ]; then
    chmod +x ./test_hooks/post_test.sh
    ./test_hooks/post_test.sh
fi

# Make test results available to docker host.
mkdir /irods_test_env/$test_name
cd /var/lib/irods
#cp log/rodsLog* log/rodsServerLog* log/test_log.txt test-reports/* /irods_test_env/$test_name
cp log/rodsLog* log/rodsServerLog* log/test_log.txt test/test_output.txt /irods_test_env/$test_name

# Keep container running if the test fails.
if [[ $ec != 0 ]]; then
    tail -f /dev/null
    # Is this better? sleep 2147483647d
fi

