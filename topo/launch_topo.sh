#! /bin/bash

prefix=
consumers=3
image_provider='irods_topo:provider'
image_consumer='irods_topo:consumer'

while [ -n "$1" ]; do
    case "$1" in
        --prefix)           shift; prefix=${1}_;;
        --consumers)        shift; consumers=$1;;
        --image_provider)   shift; image_provider=$1;;
        --image_consumer)   shift; image_consumer=$1;;
    esac
    shift
done

# /etc/host is automatically handled by Docker.
# All containers know about each other because they are on the same network.
# They can also resolve each other's IP using the container name.

docker run -d --rm --name ${prefix}topo_provider -h topo_provider --network topo_net $image_provider
docker network connect bridge ${prefix}topo_provider

for ((i=0; i < consumers; i++)); do
    name=topo_consumer_$i
    prefixed_name=${prefix}$name
    docker run -d --rm --name $prefixed_name -h $name --network topo_net $image_consumer
    docker network connect bridge $prefixed_name
done

