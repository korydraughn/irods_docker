#! /bin/bash

# Wait for the consumer to start.
until nc -z consumer 1247; do
    sleep 1
done

iinit < /input.client

# Keep container running.
sleep 2147483647d
