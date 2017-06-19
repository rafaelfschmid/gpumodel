#!/bin/bash
input=$1 #arquivos de entrada
time=$2  #caminho dos tempos

for block in 2 4 8 ; do
	./scripts/exec.sh global_tri$block.exe $input > $time/global_tri$block.out 
done

