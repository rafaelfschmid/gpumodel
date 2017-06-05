dir=$1

./scripts/exec.sh shared2.exe ~/workspace/files/gpumodel/inputs > $dir/shared2.out 
./scripts/exec.sh global2.exe ~/workspace/files/gpumodel/inputs > $dir/global2.out
./scripts/exec.sh unrolled2.exe ~/workspace/files/gpumodel/inputs > $dir/unrolled2.out
./scripts/exec.sh prefetching2.exe ~/workspace/files/gpumodel/inputs > $dir/prefetching2.out

./scripts/exec.sh shared4.exe ~/workspace/files/gpumodel/inputs > $dir/shared4.out 
./scripts/exec.sh global4.exe ~/workspace/files/gpumodel/inputs > $dir/global4.out
./scripts/exec.sh unrolled4.exe ~/workspace/files/gpumodel/inputs > $dir/unrolled4.out
./scripts/exec.sh prefetching4.exe ~/workspace/files/gpumodel/inputs > $dir/prefetching4.out

./scripts/exec.sh shared8.exe ~/workspace/files/gpumodel/inputs > $dir/shared8.out 
./scripts/exec.sh global8.exe ~/workspace/files/gpumodel/inputs > $dir/global8.out
./scripts/exec.sh unrolled8.exe ~/workspace/files/gpumodel/inputs > $dir/unrolled8.out
./scripts/exec.sh prefetching8.exe ~/workspace/files/gpumodel/inputs > $dir/prefetching8.out

./scripts/exec.sh shared16.exe ~/workspace/files/gpumodel/inputs > $dir/shared16.out 
./scripts/exec.sh global16.exe ~/workspace/files/gpumodel/inputs > $dir/global16.out
./scripts/exec.sh unrolled16.exe ~/workspace/files/gpumodel/inputs > $dir/unrolled16.out
./scripts/exec.sh prefetching16.exe ~/workspace/files/gpumodel/inputs > $dir/prefetching16.out

./scripts/exec.sh shared32.exe ~/workspace/files/gpumodel/inputs > $dir/shared32.out 
./scripts/exec.sh global32.exe ~/workspace/files/gpumodel/inputs > $dir/global32.out
./scripts/exec.sh unrolled32.exe ~/workspace/files/gpumodel/inputs > $dir/unrolled32.out
./scripts/exec.sh prefetching32.exe ~/workspace/files/gpumodel/inputs > $dir/prefetching32.out


#./scripts/exec.sh shared64.exe ~/workspace/files/gpumodel/inputs > times-lmcad/shared64.out 
#./scripts/exec.sh global64.exe ~/workspace/files/gpumodel/inputs > times-lmcad/global64.out
