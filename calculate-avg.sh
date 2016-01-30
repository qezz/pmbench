#!/bin/bash

# Yes, this file generates another one.
# And then another-one passes to clisp repl :)
# and then output saves to another file

avg_results="avg-results.txt"
avg_lisp="avg.lisp"

is_clisp=`which clisp`;
if [ $? -ne 0 ]
then
    echo "You should install `clisp` to calculate avg value :)"
    exit
fi   

if [ -f $avg_results ]
then
    rm $avg_results
else
    touch $avg_results
fi

if [ -f $avg_lisp ]
then
    rm $avg_lisp
else
    touch $avg_lisp
fi

ls */* | grep -i filtered | while read filename
                            do
                                values=`cat $filename | sed -r "s/[0-7]\.([0-9]{3})/0\.\1/g" | tr '\n' ' '`
                                test_type=`echo $filename | sed -r "s/-filtered//g"`
                                echo "(format t \"$test_type\")" >> $avg_lisp
                                echo "(/ (+ $values) 60.0)" >> $avg_lisp
                                echo " " >> $avg_lisp
                            done

clisp -q < $avg_lisp | sed -r "s/NIL//g" | tr -s '\n' > $avg_results

#cat $avg_results

rm $avg_lisp

echo ""
echo "Default comparisions:"

for test_name in "get-param" "get-param-cli" "set-param" "set-param-cli"
do
    echo "" >> $avg_results
    echo $test_name >> $avg_results
    difference_str=`cat $avg_results | grep -A 1 -E "$test_name($)" | grep -Eio "0.[0-9]+"| tr '\n' ' ' | sed -r "s/([0-9]) (0)/\1 - \2/g"`
    diff=`echo "$difference_str = "; echo "$difference_str" | bc | tr '\n' ' '`
    echo $diff >> $avg_results
done

cat $avg_results
