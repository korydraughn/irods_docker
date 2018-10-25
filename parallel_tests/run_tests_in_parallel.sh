#! /bin/bash

docker run -d --rm --name itrim irods_tests test_itrim.Test_Itrim
docker run -d --rm --name irm irods_tests test_irm.Test_Irm
