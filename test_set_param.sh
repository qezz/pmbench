#!/bin/bash

if [[ $# -ne 0 ]]
then
    target_folder="$1"
else
    target_folder="results"
fi

for i in `seq 1 60`;
do
    time ( sleep 4; crm_resource --resource apache_server --set-parameter test --parameter-value $i) 2>>./$target_folder/set-param
done
