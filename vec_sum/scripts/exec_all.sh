
./scripts/exec.sh coalescingshared32.exe $DIR/inputs > times/coalescing32.time
./scripts/exec.sh coalescingshared64.exe $DIR/inputs > times/coalescing64.time
./scripts/exec.sh coalescingshared128.exe $DIR/inputs > times/coalescing128.time
./scripts/exec.sh coalescingshared256.exe $DIR/inputs > times/coalescing256.time
./scripts/exec.sh coalescingshared512.exe $DIR/inputs > times/coalescing512.time
./scripts/exec.sh coalescingshared1024.exe $DIR/inputs > times/coalescing1024.time
