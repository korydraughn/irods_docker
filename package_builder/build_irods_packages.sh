#! /bin/bash

# Requirements:
# -v <path/to/irods/src/on/host>:/irods:ro
# -v <path/to/irods_client_icommands/src/on/host>:/irods_client_icommands:ro
# -v <path/to/hold/output/on/host>:/build_output

if [ "$IRODS_BRANCH" == "master" ]; then
    export PATH=/opt/irods-externals/cmake3.11.4-0/bin:$PATH
elif [ "$IRODS_BRANCH" == "4-2-stable" ]; then
    export PATH=/opt/irods-externals/cmake3.5.2-0/bin:$PATH
else
    echo Invalid iRODS branch! Valid values are "master" or "4-2-stable".
    exit 1
fi

# Build iRODS.
mkdir /irods_build
cd /irods_build
cmake -GNinja /irods
ninja package
cp *.deb /build_output

# Install packages for building iCommands.
dpkg -i irods-{runtime,dev}*.deb

# Build and install iCommands.
mkdir /icommands_build
cd /icommands_build
cmake -GNinja /irods_client_icommands
ninja package
cp *.deb /build_output
