libs=-I"../../lib"
params=-std=c++11 --expt-extended-lambda -lcuda
gen=-gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=sm_35 -gencode arch=compute_37,code=sm_37 -gencode arch=compute_50,code=sm_50 -gencode arch=compute_52,code=sm_52 -gencode arch=compute_52,code=compute_52


all: mulwith mulwithout

mulwith: mult_matrix_with_shared_memory.cu
	nvcc $(gen) mult_matrix_with_shared_memory.cu -o multshare.exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS)

mulwithout: mult_matrix_without_shared_memory.cu
	nvcc $(gen) mult_matrix_without_shared_memory.cu -o multglobal.exe $(libs) $(params) -DELAPSED_TIME=$(TIME) -DEXECUTIONS=$(EXECS)

