
times=$1

for i in 2 4 8 16 32 ; do
	./parser.exe $times/global_bi$i.out $times/00global_bi$i.out
	./parser.exe $times/shared$i.out $times/00shared$i.out 
done

for i in 2 4 8 16 32 64 128 256 512 1024; do
	./parser.exe $times/global_uni$i.out $times/00global_uni$i.out
done

for i in 2 4 8 ; do
	./parser.exe $times/global_tri$i.out $times/00global_tri$i.out
done

