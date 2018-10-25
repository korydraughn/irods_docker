#! /bin/bash

# Start the Postgres database.
service postgresql start

# Clone iRODS repo and initialize.
git clone $IRODS_BUILD_IRODS_REPO
cd irods
git checkout $IRODS_BUILD_IRODS_COMMIT
git submodule update --init
cd /

# Build iRODS.
mkdir irods_build
cd irods_build
cmake -GNinja /irods
ninja package

# Install new irods-dev package.
dpkg -i irods-{runtime,dev}*.deb

# Clone iCommands repo.
cd /
git clone $IRODS_BUILD_ICOMMANDS_REPO
cd irods_client_icommands
git checkout $IRODS_BUILD_ICOMMANDS_COMMIT
cd /

# Build and install iCommands.
mkdir icommands_build
cd icommands_build
cmake -GNinja /irods_client_icommands
ninja package
dpkg -i *.deb

# Install remaining iRODS packages.
cd /irods_build
dpkg -i irods-{server,database-plugin-postgres}*.deb

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_postgres.input

# Run test.
cp /run_test.sh /var/lib/irods/
cd /var/lib/irods
./run_test.sh $1

# Keep container running.
tail -f /dev/null
