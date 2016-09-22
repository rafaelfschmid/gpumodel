#!/bin/bash
prog=$1
c=2
while [ $c -le 512 ]
do
	echo $c
	for b in `seq 1 10`; do
		echo $c | ./$prog
	done
	((c=$c*2))
	echo " "
done
