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

topo_provider=${prefix}topo_provider

docker run -d --rm --name $topo_provider -h $topo_provider --network topo_net $image_provider
docker network connect bridge $topo_provider

for ((i=0; i < consumers; i++)); do
    name=${prefix}topo_consumer_$i
    docker run -d --rm --name $name -h $name --network topo_net $image_consumer $topo_provider
    docker network connect bridge $name
done

