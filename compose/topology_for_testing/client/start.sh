#! /bin/bash

# Wait for the consumers to start.
for n in {1..2}; do
    until nc -z consumer_${n} 1247; do
        sleep 1
    done
done

until iinit < /input.client; do
    sleep 1
done

# Keep container running.
sleep 2147483647d
