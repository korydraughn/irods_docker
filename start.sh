#! /bin/bash

service krb5-kdc start
service krb5-admin-server start
service postgresql start

seconds=10
echo "Sleeping for $seconds seconds to let the database complete start up ..."
sleep $seconds

python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_postgres.input

# TODO Compile and run NFSRODS tests.
#git clone https://github.com/irods/irods_client_nfsrods
#cd irods_client_nfsrods
#git checkout dev && mvn clean install -Dmaven.test.skip=true

# Keep container alive so admin can view test results,
# or write them to a shared location outside of the container.
# This should be removed in the future.
tail -f /dev/null
