dir=$1

#./scripts/exec.sh shared2.exe ~/workspace/files/gpumodel/inputs > $dir/shared2.out 
./scripts/exec.sh global2.exe ~/workspace/files/gpumodel/inputs > $dir/global2.out
#./scripts/exec.sh shared4.exe ~/workspace/files/gpumodel/inputs > $dir/shared4.out 
./scripts/exec.sh global4.exe ~/workspace/files/gpumodel/inputs > $dir/global4.out
#./scripts/exec.sh shared8.exe ~/workspace/files/gpumodel/inputs > $dir/shared8.out 
./scripts/exec.sh global8.exe ~/workspace/files/gpumodel/inputs > $dir/global8.out
#./scripts/exec.sh shared16.exe ~/workspace/files/gpumodel/inputs > $dir/shared16.out 
./scripts/exec.sh global16.exe ~/workspace/files/gpumodel/inputs > $dir/global16.out
#./scripts/exec.sh shared32.exe ~/workspace/files/gpumodel/inputs > $dir/shared32.out 
./scripts/exec.sh global32.exe ~/workspace/files/gpumodel/inputs > $dir/global32.out


#./scripts/exec.sh shared64.exe ~/workspace/files/gpumodel/inputs > times-lmcad/shared64.out 
#./scripts/exec.sh global64.exe ~/workspace/files/gpumodel/inputs > times-lmcad/global64.out
