
BLOCK=64
libs=-I"../../lib"
params=-std=c++11 --expt-extended-lambda -lcuda
gen=-gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=sm_35 -gencode arch=compute_37,code=sm_37 -gencode arch=compute_50,code=sm_50 -gencode arch=compute_52,code=sm_52 -gencode arch=compute_52,code=compute_52


all: noncoalescingshared generate parser treeshared coalescingshared cpu

noncoalescingshared: shared_noncoalescing.cu
	nvcc $(gen) shared_noncoalescing.cu -o noncoalescingshared$(BLOCK).exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=$(BLOCK)

coalescingshared: shared_coalescing.cu
	nvcc $(gen) shared_coalescing.cu -o coalescingshared$(BLOCK).exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=$(BLOCK)

treeshared: shared_tree.cu
	nvcc $(gen) shared_tree.cu -o treeshared$(BLOCK).exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=$(BLOCK)

generate: generate.cpp
	g++ -O3 generate.cpp -o generate.exe -DEXP_BITS_SIZE=$(BITS) -DRAND

parser: parser.cpp
	g++ -O3 parser.cpp -o parser.exe -std=c++11

cpu: cpu.cpp
	g++ -O3 cpu.cpp -o cpu.exe -std=c++11

