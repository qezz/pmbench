#!/bin/bash

for i in `seq 1 60`;
do
    time ( sleep 4; crm resource param apache_server set test $i) 2>>./results/set-param-cli
done
