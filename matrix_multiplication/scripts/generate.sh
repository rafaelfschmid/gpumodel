#!/bin/bash
dir=$1

c=2
while [ $c -le 8192 ]
do
#	echo $c
	for b in `seq 1 10`; do
		./equal.exe $c > $dir/$c".in"
	done
	((c=$c*2))
	sleep 1.0
#	echo " "
done
