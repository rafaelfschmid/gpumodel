
times=$1

for i in 2 4 8 16 32 ; do
	./parser.exe $times/global$i.out $times/00global$i.out
	./parser.exe $times/shared$i.out $times/00shared$i.out 
	./parser.exe $times/unrolled$i.out $times/00unrolled$i.out 
	./parser.exe $times/prefetching$i.out $times/00prefetching$i.out 
done

for i in 2 4 8 16 32 64 128 256 512 1024; do
	./parser.exe $times/unidimensional$i.out $times/00unidimensional$i.out
done

