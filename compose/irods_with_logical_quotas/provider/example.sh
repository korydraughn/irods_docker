#! /bin/bash

# This script demonstrates how to invoke the operations provided by the
# Rule Engine Plugin.
# 
# In particular, this script demonstrates the following:
#  - How to start monitoring a collection
#  - How to set a quota on a collection
# 
# See the Logical Quotas README for more information.

# 1. Start monitoring a collection.
#
# This causes the plugin to start tracking the total number of bytes and
# total number of data objects under the collection.
irule -r irods_rule_engine_plugin-logical_quotas-instance '{"operation": "logical_quotas_start_monitoring_collection", "collection": "/tempZone/home/rods"}' null ruleExecOut

# 2. Add a quota to the collection.
# 
# This sets a maximum limit on the number of data objects that can exist
# under the collection.
irule -r irods_rule_engine_plugin-logical_quotas-instance '{"operation": "logical_quotas_set_maximum_number_of_data_objects", "collection": "/tempZone/home/rods", "value": "100"}' null ruleExecOut

