#! /bin/bash

usage() {
cat <<_EOF_
Usage: ./build_image.sh [OPTIONS]...

You can instruct which repo and branch to build by setting different build arguments.

Example:

    ./build_image.sh --image-name my_image --build-arg irods-repo=... --build-arg irods-branch=... <etc.>

Available options:

    --irods-repo            URL to iRODS github repository
    --irods-branch          iRODS branch to build
    --icommands-repo        URL to the iRODS icommands repository
    --icommands-branch      iRODS icommands branch to build
    --cmake-path            Full path to the CMake binary (e.g. /opt/irods-externals/cmakeX.X.X/bin)
    -h, --help              This message
_EOF_
    exit
}

image_name=irods_ub16_postgres
build_args=

while [ -n "$1" ]; do
    case "$1" in
        --image_name)       shift; image_name=${1};;
        --irods_repo)       shift; build_args="$build_args --build-arg irods_repo=${1}";;
        --irods_branch)     shift; build_args="$build_args --build-arg irods_branch=${1}";;
        --icommands_repo)   shift; build_args="$build_args --build-arg icommands_repo=${1}";;
        --icommands_branch) shift; build_args="$build_args --build-arg icommands_branch=${1}";;
        --cmake_path)       shift; build_args="$build_args --build-arg cmake_path=${1}";;
        -h|--help)        usage;;
    esac
    shift
done

echo docker build -t $image_name $build_args .
