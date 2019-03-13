#! /bin/bash

test_name=$1

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

if [ -f /test_hooks/pre_test.sh ]; then
    echo pre-hook exists.
    #chmod +x ./test_hooks/pre_test.sh
    #./test_hooks/pre_test.sh
fi

# Run test.
tests=/var/lib/irods/test/test_output.txt
su - irods -c "cd scripts && python run_tests.py --xml_output --run_specific_test $test_name > $tests 2>&1"
ec=$?

if [ -f /test_hooks/post_test.sh ]; then
    echo post-hook exists.
    #chmod +x ./test_hooks/post_test.sh
    #./test_hooks/post_test.sh
fi

# Make test results available to docker host.
[ ! -d /irods_test_env/$test_name ] && mkdir /irods_test_env/$test_name
cd /var/lib/irods
#cp log/rodsLog* log/rodsServerLog* log/test_log.txt test/test_output.txt /irods_test_env/$test_name
cp log/test_log.txt test/test_output.txt /irods_test_env/$test_name
[ -f /var/log/irods/irods.log ] && cp /var/log/irods/irods.log /irods_test_env/$test_name

# Keep container running if the test fails.
if [[ $ec != 0 ]]; then
    tail -f /dev/null
    # Is this better? sleep 2147483647d
fi

