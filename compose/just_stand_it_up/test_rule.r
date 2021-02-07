test_rule
{
    for (*j = 0; *j < 2; *j = *j + 1) {
        for (*i = 0; *i < 250; *i = *i + 1) {
            delay('<INST_NAME>irods_rule_engine_plugin-irods_rule_language-instance</INST_NAME><EF>1s</EF>') {
                writeLine('serverLog', 'printed by delay rule.')
            }
        }

        #delay('<INST_NAME>irods_rule_engine_plugin-irods_rule_language-instance</INST_NAME><EF>3s</EF>') {
            #writeLine('serverLog', 'User name=$userNameClient')
            #writeLine('serverLog', 'User name= $userNameClient')
        #}

        #delay('<INST_NAME>irods_rule_engine_plugin-irods_rule_language-instance</INST_NAME><EF>1s</EF>') {
            #writeLine('serverLog', 'IP:$clientAddr')
            #writeLine('serverLog', 'IP: $clientAddr')
        #}
    }
}

INPUT null
OUTPUT ruleExecOut
