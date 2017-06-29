#!/bin/bash
input=$1 #arquivos de entrada
profdir=$2  #caminho dos tempos

for block in 2 4 8 16 32 64 128 256 512 1024; do
	./scripts/nvprof.sh global_uni$block.exe $input $profdir
done

