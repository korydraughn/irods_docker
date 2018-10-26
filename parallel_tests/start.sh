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

[ -f /test_hooks/pre_test.sh ] && ./test_hooks/pre_test.sh

# Run test.
su - irods -c "python scripts/run_tests.py --xml_output --run_specific_test $test_name"
ec=$?

[ -f /test_hooks/post_test.sh ] && ./test_hooks/post_test.sh

# Make test results available to docker host.
mkdir /irods_test_env/$test_name
cd /var/lib/irods
cp log/rodsLog* log/rodsServerLog* log/test_log.txt test-reports/* /irods_test_env/$test_name
#cp log/rodsLog* log/rodsServerLog* log/test_log.txt test/test_output.txt /irods_test_env/$test_name

# Keep container running if the test fails.
if [[ $ec != 0 ]]; then
    tail -f /dev/null
    # Is this better? sleep 2147483647d
fi

