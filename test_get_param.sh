#!/bin/bash

function get_param {
    sleep 1; crm_resource --resource apache_server --get-parameter=test 1>/dev/null;
}

#cmnd="sleep 1; crm_resource --resource apache_server --get-parameter=test 1>/dev/null"

for i in `seq 1 60`;
do
 #   /usr/bin/time --format=%e 2>>./results/get-param $get_param
    time ( sleep 1; crm_resource --resource apache_server --get-parameter=test ) 2>>./results/get-param

done
