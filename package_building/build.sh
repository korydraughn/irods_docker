#! /bin/bash

echo "icommands_repo  : $IRODS_BUILD_ICOMMANDS_REPO"
echo "icommands_branch: $IRODS_BUILD_ICOMMANDS_BRANCH"

apt-get update
apt-get install -y apt-transport-https git python vim sudo wget lsb-release

git clone https://github.com/irods/irods_python_ci_utilities
cd irods_python_ci_utilities
sed -ie "s/'sudo',//g" irods_python_ci_utilities/irods_python_ci_utilities.py
./setup.py build
./setup.py install

cd /
mkdir /irods_build
git clone https://github.com/irods/irods
cd /irods
git submodule update --init
sed -ie "s/'sudo',//g" irods_consortium_continuous_integration_build_hook.py

python irods_consortium_continuous_integration_build_hook.py \
    --icommands_git_repository $IRODS_BUILD_ICOMMANDS_REPO \
    --icommands_git_commitish $IRODS_BUILD_ICOMMANDS_BRANCH \
    --output_root_directory /irods_build

tail -f /dev/null
