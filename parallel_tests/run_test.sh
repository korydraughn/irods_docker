#! /bin/bash

cd scripts
python run_tests.py --run_specific_test "$1"
cd ~
