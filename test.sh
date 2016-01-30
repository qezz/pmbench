#!/bin/bash

# $1 amount of cycles
# $2 sleep
# $everythingelse command

amount=$1
shift;
delay=$1
shift;

output="$1_$2_$3_$4_$5"

command=$@

for i in `seq 1 $amount`;
do
 #   /usr/bin/time --format=%e 2>>./results/get-param $get_param
    time ( sleep $delay; $command ) 2>>./results/$output

done
