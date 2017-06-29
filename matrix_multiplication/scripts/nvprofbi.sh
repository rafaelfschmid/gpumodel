#!/bin/bash
input=$1 #arquivos de entrada
profdir=$2 # dir to save

for block in 2 4 8 16 32 ; do
#	./scripts/nvprof.sh global_bi$block.exe $input $profdir
 	./scripts/nvprof.sh global_block$block.exe $input $profdir 
#	./scripts/nvprof.sh shared$block.exe $input $profdir 
done

