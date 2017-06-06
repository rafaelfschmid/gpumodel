
input=$1 #arquivos de entrada
time=$2 #arquivos de tempo

./scripts/exec.sh shared2.exe $input > $time/shared2.out 
./scripts/exec.sh global2.exe $input > $time/global2.out
./scripts/exec.sh unrolled2.exe $input > $time/unrolled2.out
./scripts/exec.sh prefetching2.exe $input > $time/prefetching2.out

./scripts/exec.sh shared4.exe $input > $time/shared4.out 
./scripts/exec.sh global4.exe $input > $time/global4.out
./scripts/exec.sh unrolled4.exe $input > $time/unrolled4.out
./scripts/exec.sh prefetching4.exe $input > $time/prefetching4.out

./scripts/exec.sh shared8.exe $input > $time/shared8.out 
./scripts/exec.sh global8.exe $input > $time/global8.out
./scripts/exec.sh unrolled8.exe $input > $time/unrolled8.out
./scripts/exec.sh prefetching8.exe $input > $time/prefetching8.out

./scripts/exec.sh shared16.exe $input > $time/shared16.out 
./scripts/exec.sh global16.exe $input > $time/global16.out
./scripts/exec.sh unrolled16.exe $input > $time/unrolled16.out
./scripts/exec.sh prefetching16.exe $input > $time/prefetching16.out

./scripts/exec.sh shared32.exe $input > $time/shared32.out 
./scripts/exec.sh global32.exe $input > $time/global32.out
./scripts/exec.sh unrolled32.exe $input > $time/unrolled32.out
./scripts/exec.sh prefetching32.exe $input > $time/prefetching32.out


#./scripts/exec.sh shared64.exe ~/workspace/files/gpumodel/inputs > times-lmcad/shared64.out 
#./scripts/exec.sh global64.exe ~/workspace/files/gpumodel/inputs > times-lmcad/global64.out
