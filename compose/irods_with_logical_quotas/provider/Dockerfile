FROM ubuntu:16.04

ARG irods_version
ENV IRODS_VERSION ${irods_version}

ARG irods_rep_version
ENV IRODS_REP_VERSION ${irods_rep_version}

ARG irods_zone_name
ENV IRODS_ZONE_NAME ${irods_zone_name}

RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    apt-get install -y wget lsb-release odbc-postgresql jq

RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add -; \
    echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/renci-irods.list;

RUN apt-get update && \
    apt-get install -y irods-runtime=${irods_version} \
                       irods-icommands=${irods_version} \
                       irods-server=${irods_version} \
                       irods-database-plugin-postgres=${irods_version} \
                       irods-rule-engine-plugin-logical-quotas=${irods_rep_version}

COPY rep_config.json provider.input start.sh /
ENTRYPOINT ["bash", "./start.sh"]
