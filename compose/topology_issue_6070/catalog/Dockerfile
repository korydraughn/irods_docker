FROM postgres:10

ARG postgres_password
ENV POSTGRES_PASSWORD ${postgres_password}

COPY configure_icat.sh /docker-entrypoint-initdb.d/
