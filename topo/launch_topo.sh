#! /bin/bash

# The total number of consumers to launch.
consumers=${1:-3}

# /etc/host is automatically handled by Docker.
# All containers know about each other because they are on the same network.
# They can also resolve each other's IP using the container name.

docker run -d --rm --name topo_provider -h topo_provider --network topo_net irods_topo:provider
docker network connect bridge topo_provider

for ((i=0; i < consumers; i++)); do
    name=topo_consumer_$i
    docker run -d --rm --name $name -h $name --network topo_net irods_topo:consumer
    docker network connect bridge $name
done
