#!/bin/bash

# $1 amount of cycles
# $2 sleep
# $everythingelse command

#amount=$1
#shift;
#delay=$1
#shift;

result_str="results"
date_str="`date +%Y%m%d_%H%M%S`" #year/mo/day_h/m/s
output_folder="${result_str}_${date_str}"

count_online_nodes="`crm_mon --as-xml | xpath '//node_attributes' 2>/dev/null | grep node\ name | sed -r \"s/.*<node name=\\"(.+)\\">/\1/g\" | wc -w`"

output_folder="${result_str}_for_${count_online_nodes}_nodes_${date_str}"

mkdir $output_folder

./test_get_param.sh $output_folder
./test_get_param_cli.sh $output_folder
./test_set_param.sh $output_folder
./test_set_param_cli.sh $output_folder
./test_set_diffparam.sh $output_folder
./test_set_diffparam_cli.sh $output_folder

for file in $( ls $output_folder ); do
    cat "${output_folder}/${file}" | grep -i real | grep -Eio "[0-9].[0-9]{3}" > "${output_folder}/${file}-filtered"
done

#command=$@

#for i in `seq 1 4`;
#do
 #   /usr/bin/time --format=%e 2>>./results/get-param $get_param
 #   time ( sleep $delay; $command ) 2>>./results/$output
    

#done
