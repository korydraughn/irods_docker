FROM centos:7

ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME ["/sys/fs/cgroup"]

RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y wget sudo vim less rsyslog logrotate netcat \
                   python python-psutil python-requests python-jsonschema postgresql-upgrade \
                   openssl openssl-devel super lsof postgresql-server unixODBC-devel libjson-perl

RUN rpm --import https://packages.irods.org/irods-signing-key.asc && \
    wget -qO - https://packages.irods.org/renci-irods.yum.repo | tee /etc/yum.repos.d/renci-irods.yum.repo

RUN rpm --import https://core-dev.irods.org/irods-core-dev-signing-key.asc && \
    wget -qO - https://core-dev.irods.org/renci-irods-core-dev.yum.repo | tee /etc/yum.repos.d/renci-irods-core-dev.yum.repo

ARG irods_version
ENV IRODS_VERSION ${irods_version}

ARG irods_zone_name
ENV IRODS_ZONE_NAME ${irods_zone_name}

RUN yum update -y && \
    yum install -y irods-runtime-${irods_version} \
                   irods-icommands-${irods_version} \
                   irods-server-${irods_version} \
                   irods-database-plugin-postgres-${irods_version}

COPY provider.input start.sh /
ENTRYPOINT ["bash", "./start.sh"]
