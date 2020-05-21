#! /bin/bash

image_name=$1
github_acct_irods=$2
irods_sha=$3
github_acct_icommands=$4
icommands_sha=$5

./build_image.unbuntu.sh --image-name ${image_name} \
                         --irods-repo https://github.com/${github_acct_irods}/irods \
                         --irods-branch ${irods_sha} \
                         --icommands-repo https://github.com/${github_acct_icommands}/irods_client_icommands \
                         --icommands-branch ${icommands_sha}
