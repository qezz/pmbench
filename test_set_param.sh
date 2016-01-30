#!/bin/bash

for i in `seq 1 60`;
do
    time ( sleep 4; crm_resource --resource apache_server --set-parameter test --parameter-value $i) 2>>./results/set-param
done
