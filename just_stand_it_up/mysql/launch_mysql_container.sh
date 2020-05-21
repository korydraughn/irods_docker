#! /bin/bash

db_name="$1"

docker run -d --rm --name "$db_name" --network irods_mysql_net \
           -e MYSQL_ROOT_PASSWORD=testpassword \
           -e MYSQL_DATABASE=ICAT \
           -e MYSQL_USER=irods \
           -e MYSQL_PASSWORD=testpassword \
           -p 3306:3306 \
           -v /home/kory/dev/prog/docker/irods_docker/just_stand_it_up/mysql/db_commands.txt:/db_commands.txt:ro \
           mysql:5.7

python wait_for_database.py localhost
#docker exec -it $db_name mysql --password=testpassword < /db_commands.txt
