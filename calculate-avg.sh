#!/bin/bash

# Yes, this file generates another one.
# And then it passes to clisp repl :)

avg_results="avg-results.md"
avg_lisp="avg.lisp"

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

cat $avg_results

rm $avg_lisp
