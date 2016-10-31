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
//#ifndef BLOCK_SIZE
//#define BLOCK_SIZE 32
//#endif

__global__ void vec_sum(float *g_odata, float *g_idata, int n) {

	extern __shared__ float temp[]; // allocated on invocation

	int globalIndex = blockIdx.x * blockDim.x + threadIdx.x;
	int localIndex = threadIdx.x;

	temp[localIndex] = g_idata[globalIndex];
	__syncthreads();
	printf("temp[%d]=%f | global[%d]=%f\n", localIndex, temp[localIndex], globalIndex, temp[globalIndex]);

	for (int offset = BLOCK_SIZE/2; offset >= 1; offset /= 2) {
		if ( (localIndex < offset) && (globalIndex + offset < n) ) {
			//printf("block=%d | offset=%d | temp[%d]=%f | temp[%d]=%f\n", blockIdx.x, offset, localIndex, temp[localIndex], localIndex+offset, temp[localIndex+offset]);
			temp[localIndex] += temp[localIndex + offset];
		}
		__syncthreads();
	}

	if (localIndex == 0) {
		g_odata[blockIdx.x] = temp[localIndex]; // write output
		//printf("block=%d | temp[%d]=%f\n", blockIdx.x, localIndex, temp[localIndex]);
	}
}

void print(float* x, const int n) {
	for (int i = 0; i < n; i++) {
		std::cout << x[i]; // << " ";
	}
	std::cout << "\n";
}

// Matrix multiplication - Host code
// Matrix dimensions are assumed to be multiples of BLOCK_SIZE
void VectorSum(float* odata, float* idata, const int n) {
	// Load A and B to device memory
	float* g_idata;
	float* g_odata;

	// Invoke kernel
	//dim3 dimBlock(BLOCK_SIZE);
	//dim3 dimGrid(n / BLOCK_SIZE, 1);
	int block = BLOCK_SIZE;
	int grid = (n-1) / block +1;
	//printf("grid=%d\n", grid);

	size_t size = n * sizeof(float);
	size_t block_size = grid * sizeof(float);
	cudaMalloc(&g_idata, size);
	cudaMalloc(&g_odata, block_size);

	cudaMemcpy(g_idata, idata, size, cudaMemcpyHostToDevice);

	cudaEvent_t start, stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);

	cudaEventRecord(start);
	vec_sum<<<grid, block, block>>>(g_odata, g_idata, n);
	for(int i = grid; i > 1; i/= block) {
		grid = (i-1)/block+1;
		cudaDeviceSynchronize();
		//printf("i=%d\n", i);
		vec_sum<<<grid, block, block>>>(g_odata, g_odata, i);
	}
	cudaEventRecord(stop);

	cudaError_t errSync = cudaGetLastError();
	cudaError_t errAsync = cudaDeviceSynchronize();
	if (errSync != cudaSuccess)
		printf("4: Sync kernel error: %s\n", cudaGetErrorString(errSync));
	if (errAsync != cudaSuccess)
		printf("4: Async kernel error: %s\n", cudaGetErrorString(errAsync));

	// Read C from device memory
	cudaMemcpy(odata, g_odata, sizeof(float), cudaMemcpyDeviceToHost);

	if (ELAPSED_TIME == 1) {
		cudaEventSynchronize(stop);
		float milliseconds = 0;
		cudaEventElapsedTime(&milliseconds, start, stop);
		std::cout << milliseconds << "\n";
	} else {
		//print(idata, n);
		print(odata, 1);
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

	for (int i = 0; i < n; i++)
		scanf("%f", &idata[i]);

	VectorSum(odata, idata, n);

	//printf("result=%f\n", odata[n - 1]);

	free(odata);
	free(idata);

	return 0;
}
