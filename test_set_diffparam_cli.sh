#!/bin/bash

if [[ $# -ne 0 ]]
then
    target_folder="$1"
else
    target_folder="results"
fi

for i in `seq 1 60`;
do
    time ( sleep 4; crm resource param apache_server set test$i $i) 2>>./$target_folder/set-diffparam-cli
done

# cleanup params

for i in `seq 1 60`
do
    crm resource param apache_server delete test$i
done
