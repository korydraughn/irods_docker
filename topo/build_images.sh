#! /bin/bash

suffix=
if [ -n "$1" ]; then
    suffix=_$1
fi

build_args="--build-arg irods_repo=https://github.com/korydraughn/irods"
build_args="$build_args --build-arg irods_branch=re_plugin_issue_4144_partial"
build_args="$build_args --build-arg icommands_repo=https://github.com/korydraughn/irods_client_icommands"
build_args="$build_args --build-arg icommands_branch=4-2-stable"
build_args="$build_args --build-arg cmake_path=/opt/irods-externals/cmake3.5.2-0/bin"
build_args="$build_args --build-arg clang_path=/opt/irods-externals/clang3.8-0/bin"

docker build -t irods_topo$suffix:provider -f Dockerfile.provider $build_args .
docker build -t irods_topo$suffix:consumer -f Dockerfile.consumer $build_args .
