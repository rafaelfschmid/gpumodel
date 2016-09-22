#!/bin/bash
prog=$1
c=32
while [ $c -le 8192 ]
#while [ $c -le 8192 ]
do
	echo $c
	for b in `seq 1 20`; do
		echo $c | ./$prog
	done
	((c=$c*2))
	echo " "
done
