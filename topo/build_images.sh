#! /bin/bash

docker build -t irods_topo:provider -f Dockerfile.provider .
docker build -t irods_topo:consumer -f Dockerfile.consumer .
