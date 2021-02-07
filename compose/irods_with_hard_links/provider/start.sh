#! /bin/bash

# Wait for the Postgres database to start.
counter=0
until pg_isready -h catalog -d ICAT -U irods -q
do
    sleep 1
    ((counter += 1))
done
echo Postgres took approximately $counter seconds to fully start ...

# Update the zone name.
sed -i "12s/.*/$IRODS_ZONE_NAME/" /provider.input

# Set up iRODS.
python /var/lib/irods/scripts/setup_irods.py < /provider.input

# Inject the Rule Engine Plugin configuration.
cat /etc/irods/server_config.json | \
    jq --argjson config "$(cat /rep_config.json)" '.plugin_configuration.rule_engines = $config + .plugin_configuration.rule_engines' > /server_config.json && \
    mv /server_config.json /etc/irods/server_config.json

# Keep container running.
sleep 2147483647d
