#! /bin/bash

# Wait for the consumer to start.
#python /wait_for_remote_host.py consumer 1247
until nc -z consumer 1247; do
    sleep 1
done

# Keep container running.
sleep 2147483647d
