
input=$1 #arquivos de entrada
time=$2 #arquivos de tempo

#./scripts/exec_unidimensional.sh $input $time
#./scripts/exec_tridimensional.sh $input $time

#./scripts/exec.sh shared2.exe $input > $time/shared2.out 
#./scripts/exec.sh global_bi2.exe $input > $time/global_bi2.out
./scripts/exec.sh global_block2.exe $input > $time/global_block2.out

#./scripts/exec.sh shared4.exe $input > $time/shared4.out 
#./scripts/exec.sh global_bi4.exe $input > $time/global_bi4.out
./scripts/exec.sh global_block4.exe $input > $time/global_block4.out

#./scripts/exec.sh shared8.exe $input > $time/shared8.out 
#./scripts/exec.sh global_bi8.exe $input > $time/global_bi8.out
./scripts/exec.sh global_block8.exe $input > $time/global_block8.out

#./scripts/exec.sh shared16.exe $input > $time/shared16.out 
#./scripts/exec.sh global_bi16.exe $input > $time/global_bi16.out
./scripts/exec.sh global_block16.exe $input > $time/global_block16.out

#./scripts/exec.sh shared32.exe $input > $time/shared32.out 
#./scripts/exec.sh global_bi32.exe $input > $time/global_bi32.out
./scripts/exec.sh global_block32.exe $input > $time/global_block32.out


