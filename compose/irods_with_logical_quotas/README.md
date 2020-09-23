# Logical Quotas Test Environment
This projects stands up an iRODS provider (backed by a Postgres database) with the
Logical Quotas Rule Engine Plugin installed and ready for use.

This deployment does not set any quotas on any collections. Refer to the [plugin repo](https://github.com/irods/irods_rule_engine_plugin_logical_quotas)
for how to set quotas and invoke other operations using the plugin.

The iRODS server can be accessed on port 2247 (defined in docker-compose.yml).
