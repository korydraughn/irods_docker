FROM ubuntu:16.04

ARG icommands_repo="https://github.com/irods/irods_client_icommands"
ENV IRODS_BUILD_ICOMMANDS_REPO ${icommands_repo}

ARG icommands_branch="master"
ENV IRODS_BUILD_ICOMMANDS_BRANCH ${icommands_branch}

ADD build.sh /
RUN chmod u+x /build.sh

CMD ["/bin/bash", "-c", "/build.sh"]
