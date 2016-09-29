libs=-I"../../lib"
#caching global memory
caching=-Xptxas -dlcm=ca
params=-std=c++11 --expt-extended-lambda -lcuda
gen=-gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=sm_35 -gencode arch=compute_37,code=sm_37 -gencode arch=compute_50,code=sm_50 -gencode arch=compute_52,code=sm_52 -gencode arch=compute_52,code=compute_52


all: shared global generate parser

shared: shared.cu
	nvcc $(gen) shared.cu -o shared2.exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=2
	nvcc $(gen) shared.cu -o shared4.exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=4
	nvcc $(gen) shared.cu -o shared8.exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=8
	nvcc $(gen) shared.cu -o shared16.exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=16
	nvcc $(gen) shared.cu -o shared32.exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=32

global: global.cu
	nvcc $(gen) global.cu -o global2.exe $(libs) $(params) $(caching) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=2
	nvcc $(gen) global.cu -o global4.exe $(libs) $(params) $(caching) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=4
	nvcc $(gen) global.cu -o global8.exe $(libs) $(params) $(caching) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=8
	nvcc $(gen) global.cu -o global16.exe $(libs) $(params) $(caching) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=16
	nvcc $(gen) global.cu -o global32.exe $(libs) $(params) $(caching) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS) -DBLOCK_SIZE=32

generate: gen_equal.cpp
	g++ -O3 gen_equal.cpp -o equal.exe -DEXP_BITS_SIZE=$(BITS) -DRAND

parser: parser.cpp
	g++ -O3 parser.cpp -o parser.exe -std=c++11

