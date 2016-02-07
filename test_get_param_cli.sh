#!/bin/bash

if [[ $# -ne 0 ]]
then
    target_folder="$1"
else
    target_folder="results"
fi

for i in `seq 1 60`;
do
 #   /usr/bin/time --format=%e 2>>./results/get-param $get_param
    time ( sleep 1; crm resource param apache_server show test) 2>>./$target_folder/get-param-cli

done
