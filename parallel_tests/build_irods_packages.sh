#! /bin/bash

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
ninja package || ninja-build package

# Install packages for building iCommands.
dpkg -i irods-{runtime,dev}*.deb || rpm -i irods-{runtime,dev}*.rpm

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
ninja package || ninja-build package
