#! /bin/bash

usage() {
cat <<_EOF_
Usage: ./build_image.sh [OPTIONS]...

Builds a new docker image.

Example:

    ./build_image.sh --image-name <arg> --irods-repo <arg> --irods-branch <arg> ...

Available options:

    -f                      The path of the docker build file (defaults to Dockerfile.ubuntu)
    --image-name            The name of the new docker image
    --base-image            The base OS docker image (e.g. ubuntu:16.04, etc.)
    --irods-repo            URL to iRODS github repository
    --irods-branch          iRODS branch to build
    --icommands-repo        URL to the iRODS icommands repository
    --icommands-branch      iRODS icommands branch to build
    --cmake-path            Full path to the CMake binary (e.g. /opt/irods-externals/cmakeX.X.X/bin)
    -h, --help              This message
_EOF_
    exit
}

docker_file=Dockerfile.ubuntu
image_name=irods_test_env
build_args=

while [ -n "$1" ]; do
    case "$1" in
        -f)                     shift; docker_file=${1};;
        --image-name)           shift; image_name=${1};;
        --base-image)           shift; build_args="$build_args --build-arg base_image=${1}";;
        --irods-repo)           shift; build_args="$build_args --build-arg irods_repo=${1}";;
        --irods-branch)         shift; build_args="$build_args --build-arg irods_branch=${1}";;
        --icommands-repo)       shift; build_args="$build_args --build-arg icommands_repo=${1}";;
        --icommands-branch)     shift; build_args="$build_args --build-arg icommands_branch=${1}";;
        --cmake-path)           shift; build_args="$build_args --build-arg cmake_path=${1}";;
        -h|--help)              usage;;
    esac
    shift
done

docker build -f $docker_file -t $image_name $build_args .
