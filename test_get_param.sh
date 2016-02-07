#!/bin/bash

if [[ $# -ne 0 ]]
then
    target_folder="$1"
else
    target_folder="results"
fi

function get_param {
    sleep 1; crm_resource --resource apache_server --get-parameter=test 1>/dev/null;
}

#cmnd="sleep 1; crm_resource --resource apache_server --get-parameter=test 1>/dev/null"

for i in `seq 1 60`;
do
    time ( sleep 1; crm_resource --resource apache_server --get-parameter=test ) 2>>./$target_folder/get-param
done
