FROM postgres:latest

ARG postgres_password
ENV POSTGRES_PASSWORD ${postgres_password}

COPY configure_icat.sh /docker-entrypoint-initdb.d/
