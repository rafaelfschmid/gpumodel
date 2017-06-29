#!/bin/bash
input=$1 #arquivos de entrada
profdir=$2 # dir to save

for block in 2 4 8 ; do
	./scripts/nvprof.sh global_tri$block.exe $input $profdir 
done

