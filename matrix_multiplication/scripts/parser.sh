
times=$1

for i in 2 4 8 16 32 ; do
	./parser.exe $times/global$i.out $times/00global$i.out
	./parser.exe $times/shared$i.out $times/00shared$i.out 
	./parser.exe $times/unrolled$i.out $times/00unrolled$i.out 
	./parser.exe $times/prefetching$i.out $times/00prefetching$i.out 
	#./parser.exe $times/rectangular$i.out $times/00rectangular$i.out 
done
