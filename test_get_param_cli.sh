#!/bin/bash

for i in `seq 1 60`;
do
 #   /usr/bin/time --format=%e 2>>./results/get-param $get_param
    time ( sleep 1; crm resource param apache_server show test) 2>>./results/get-param-cli

done
