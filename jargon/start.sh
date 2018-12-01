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

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_postgres.input

# Disable SSL.
sed -i 's/CS_NEG_DONT_CARE/CS_NEG_REFUSE/g' /etc/irods/core.re

# Clone Jargon.
git clone https://github.com/DICE-UNC/jargon
#cd jargon
#mvn clean install -Dmaven.test.skip=true
#mvn install

# Keep container running if the test fails.
# Is this better? sleep 2147483647d
tail -f /dev/null

