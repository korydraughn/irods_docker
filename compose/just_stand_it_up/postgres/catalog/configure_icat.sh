#! /bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE "ICAT";
    CREATE USER irods WITH PASSWORD 'testpassword';
    GRANT ALL PRIVILEGES ON DATABASE "ICAT" TO irods;
EOSQL
