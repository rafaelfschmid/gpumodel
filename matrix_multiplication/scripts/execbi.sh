#!/bin/bash
input=$1 #arquivos de entrada
time=$2  #caminho dos tempos

for block in 2 4 8 16 32 ; do
#	./scripts/exec.sh global_bi$block.exe $input > $time/global_bi$block.out
 	./scripts/exec.sh global_block$block.exe $input > $time/global_block$block.out 
#	./scripts/exec.sh shared$block.exe $input > $time/shared$block.out 
done

