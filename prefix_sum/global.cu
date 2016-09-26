/**
 * Copyright 1993-2012 NVIDIA Corporation.  All rights reserved.
 *
 * Please refer to the NVIDIA end user license agreement (EULA) associated
 * with this source code for terms and conditions that govern your use of
 * this software. Any use, reproduction, disclosure, or distribution of
 * this software and related documentation outside the terms of the EULA
 * is strictly prohibited.
 */
#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#include <cuda.h>

// Thread block size
#ifndef BLOCK_SIZE
#define BLOCK_SIZE 512
#endif

__global__ void scan(float *g_odata, float *g_idata, int n) {

	extern __shared__ float temp[]; // allocated on invocation
	int thid = threadIdx.x;
	int pout = 0, pin = 1;
	// load input into shared memory.
	// This is exclusive scan, so shift right by one and set first elt to 0
	temp[pout * n + thid] = (thid > 0) ? g_idata[thid - 1] : 0;
	__syncthreads();
	for (int offset = 1; offset < n; offset *= 2) {
		pout = 1 - pout; // swap double buffer indices
		pin = 1 - pout;
		if (thid >= offset)
			temp[pout * n + thid] += temp[pin * n + thid - offset];
		else
			temp[pout * n + thid] = temp[pin * n + thid];
		__syncthreads();
	}
	g_odata[thid] = temp[pout * n + thid]; // write output
}

void print(float* x, const int n) {
	for (int i = 0; i < n; i++) {
		std::cout << x[i] << " ";
	}
	std::cout << "\n";
}

// Matrix multiplication - Host code
// Matrix dimensions are assumed to be multiples of BLOCK_SIZE
void PrefixSum(float* odata, float* idata, const int n) {
	// Load A and B to device memory
	float* g_idata;
	float* g_odata;

	size_t size = n * sizeof(float);
	cudaMalloc(&g_idata, size);
	cudaMalloc(&g_odata, size);

	cudaMemcpy(g_idata, idata, size, cudaMemcpyHostToDevice);

// Invoke kernel
	dim3 dimBlock(BLOCK_SIZE);
	//dim3 dimGrid(B.width / dimBlock.x, A.height / dimBlock.y);
	dim3 dimGrid(n/BLOCK_SIZE, 1);

	cudaEvent_t start, stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);

	cudaEventRecord(start);
	scan<<<dimGrid, dimBlock>>>(g_odata, g_idata, n);
	cudaEventRecord(stop);

	cudaError_t errSync = cudaGetLastError();
	cudaError_t errAsync = cudaDeviceSynchronize();
	if (errSync != cudaSuccess)
		printf("4: Sync kernel error: %s\n", cudaGetErrorString(errSync));
	if (errAsync != cudaSuccess)
		printf("4: Async kernel error: %s\n", cudaGetErrorString(errAsync));

	// Read C from device memory
	cudaMemcpy(odata, g_odata, size, cudaMemcpyDeviceToHost);

	if (ELAPSED_TIME == 1) {
		cudaEventSynchronize(stop);
		float milliseconds = 0;
		cudaEventElapsedTime(&milliseconds, start, stop);
		std::cout << milliseconds << "\n";
	} else {
		print(odata, n);
	}

// Free device memory
	cudaFree(g_odata);
	cudaFree(g_idata);
}

int main() {

	int n;
	scanf("%d", &n);

	float* idata, *odata;
	int size = n * sizeof(float);
	idata = new float[size];
	odata = new float[size];

	for(int i = 0; i < n; i++)
		scanf("%f", &idata[i]);

	PrefixSum(odata, idata, n);

	free(odata);
	free(idata);

	return 0;
}
