#! /bin/bash

openssl genrsa -out irods.key 2048
chmod 600 irods.key

openssl req -batch -new -x509 -key irods.key -out irods.crt -days 365
openssl dhparam -2 -out dhparams.pem 2048
