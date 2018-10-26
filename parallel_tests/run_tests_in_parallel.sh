#! /bin/bash

test_logs_home=${1:-"$HOME/irods_test_env"}
[ ! -d $test_logs_home ] && mkdir $test_logs_home

for name in test_all_rules \
            test_auth \
            test_catalog \
            test_chunkydevtest \
            test_client_hints \
            test_compatibility \
            test_control_plane \
            test_faulty_filesystem \
            test_federation \
            test_iadmin \
            test_ichksum \
            test_ichmod \
            test_icommands_file_operations \
            test_igroupadmin \
            test_ils \
            test_imeta_help \
            test_imeta_set \
            test_ipasswd \
            test_iphymv \
            test_iput_options \
            test_iquest \
            test_ireg \
            test_irepl \
            test_irm \
            test_irmdir \
            test_irodsctl \
            test_irsync \
            test_iscan \
            test_iticket \
            test_itrim \
            test_load_balanced_suite \
            test_log_levels \
            test_native_rule_engine_plugin \
            test_quotas \
            test_resource_configuration \
            test_resource_tree \
            test_resource_types \
            test_rule_engine_plugin_framework \
            test_rulebase \
            test_ssl \
            test_symlink_operations \
            test_util \
            test_xmsg
do
    docker run -d --rm --name $name -v $test_logs_home:/irods_test_env irods_test_env $name
done

