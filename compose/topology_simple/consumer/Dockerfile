FROM ubuntu:16.04

ARG irods_version
ENV IRODS_VERSION ${irods_version}

ARG irods_zone_name
ENV IRODS_ZONE_NAME ${irods_zone_name}

RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    apt-get install -y wget lsb-release odbc-postgresql rsyslog logrotate vim less inetutils-ping telnet netcat

RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add -; \
    echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/renci-irods.list;

RUN wget -qO - https://core-dev.irods.org/irods-core-dev-signing-key.asc | apt-key add -; \
    echo "deb [arch=amd64] https://core-dev.irods.org/apt/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/renci-irods-core-dev.list;

RUN apt-get update && \
    apt-get install -y irods-runtime=${irods_version} \
                       irods-icommands=${irods_version} \
                       irods-server=${irods_version} \
                       irods-database-plugin-postgres=${irods_version}

COPY consumer.input start.sh /
ENTRYPOINT ["bash", "./start.sh"]
