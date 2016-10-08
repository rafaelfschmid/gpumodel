#!/bin/bash
dir=$1

c=32
while [ $c -le 2097120 ]
do
#	echo $c
#	for b in `seq 1 10`; do
	./generate.exe $c > $dir/$c".in"
#	done
	((c=$c*2))
	sleep 1.0
#	echo " "
done
