libs=-I"../../lib"
#caching global memory
#caching=-Xptxas -dlcm=ca
params=-std=c++11 --expt-extended-lambda -lcuda
gen=-gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=sm_35 -gencode arch=compute_37,code=sm_37 -gencode arch=compute_50,code=sm_50 -gencode arch=compute_52,code=sm_52 -gencode arch=compute_52,code=compute_52


all: cpu shared global_uni global_bi global_tri global_block generate parser

cpu: cpu.cpp
	g++ cpu.cpp -o cpu.exe -std=c++11 -DELAPSED_TIME=$(TIME)

shared: shared.cu
	for block in 2 4 8 16 32 ; do \
		nvcc $(gen) shared.cu -o shared$$block.exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=$$block ; \
	done

global_uni: global_uni.cu
	for block in 2 4 8 16 32 64 128 256 512 1024 ; do \
		nvcc $(gen) global_uni.cu -o global_uni$$block.exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=$$block ; \
	done

global_bi: global_bi.cu
	for block in 2 4 8 16 32 ; do \
		nvcc $(gen) global_bi.cu -o global_bi$$block.exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=$$block ; \
	done

global_tri: global_tri.cu
	for block in 2 4 8 ; do \
		nvcc $(gen) global_tri.cu -o global_tri$$block.exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=$$block ; \
	done

global_block: global_block_bi.cu
	for block in 2 4 8 16 32 ; do \
		nvcc $(gen) global_block_bi.cu -o global_block$$block.exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=$$block ; \
	done

generate: gen_equal.cpp
	g++ -O3 gen_equal.cpp -o equal.exe -DEXP_BITS_SIZE=$(BITS) -DRAND

parser: parser.cpp
	g++ -O3 parser.cpp -o parser.exe -std=c++11

