#! /bin/bash

# Start the database.
service mysql start
python wait_for_database.py
#counter=0
#until pg_isready -q
#do
#    sleep 1
#    ((counter += 1))
#done
#echo Postgres took approximately $counter seconds to fully start ...

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_mysql.input

# Keep container running if the test fails.
# Is this better? sleep 2147483647d
tail -f /dev/null

