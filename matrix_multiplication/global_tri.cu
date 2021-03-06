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

// Matrices are stored in row-major order:
// M(row, col) = *(M.elements + row * M.width + col)
typedef struct {
	int width;
	int height;
	float* elements;
} Matrix;

// Thread block size
#ifndef BLOCK_SIZE
#define BLOCK_SIZE 16
#endif

// Forward declaration of the matrix multiplication kernel
__global__ void MatMulKernel(const Matrix, const Matrix, Matrix);

void print(Matrix X) {
//	std::cout << X.height << "\n"; std::cout << X.width << "\n";
	for (int i = 0; i < X.height; i++) {
		for (int j = 0; j < X.width; j++) {
			std::cout << X.elements[i * X.width + j] << " ";
		}
		std::cout << "\n";
	}
}

// Matrix multiplication - Host code
// Matrix dimensions are assumed to be multiples of BLOCK_SIZE
void MatMul(const Matrix A, const Matrix B, Matrix C) {
// Load A and B to device memory
	Matrix d_A;
	d_A.width = A.width;
	d_A.height = A.height;
	size_t size = A.width * A.height * sizeof(float);
	cudaMalloc(&d_A.elements, size);
	cudaMemcpy(d_A.elements, A.elements, size, cudaMemcpyHostToDevice);
	Matrix d_B;
	d_B.width = B.width;
	d_B.height = B.height;
	size = B.width * B.height * sizeof(float);
	cudaMalloc(&d_B.elements, size);
	cudaMemcpy(d_B.elements, B.elements, size, cudaMemcpyHostToDevice);
// Allocate C in device memory
	Matrix d_C;
	d_C.width = C.width;
	d_C.height = C.height;
	size = C.width * C.height * sizeof(float);
	cudaMalloc(&d_C.elements, size);
// Invoke kernel
	dim3 dimBlock(BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);
	dim3 dimGrid((B.width - 1) / dimBlock.x + 1, (A.height - 1) / dimBlock.y + 1, (B.width - 1) / dimBlock.z + 1);

	cudaEvent_t start, stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);

	cudaEventRecord(start);
	MatMulKernel<<<dimGrid, dimBlock>>>(d_A, d_B, d_C);
	cudaEventRecord(stop);

	cudaError_t errSync = cudaGetLastError();
	cudaError_t errAsync = cudaDeviceSynchronize();
	if (errSync != cudaSuccess)
		printf("4: Sync kernel error: %s\n", cudaGetErrorString(errSync));
	if (errAsync != cudaSuccess)
		printf("4: Async kernel error: %s\n", cudaGetErrorString(errAsync));

	// Read C from device memory
	cudaMemcpy(C.elements, d_C.elements, size, cudaMemcpyDeviceToHost);

	if (ELAPSED_TIME == 1) {
		cudaEventSynchronize (stop);
		float milliseconds = 0;
		cudaEventElapsedTime(&milliseconds, start, stop);
		std::cout << milliseconds << "\n";
	}
	else {
		print(C);
	}

// Free device memory
	cudaFree(d_A.elements);
	cudaFree(d_B.elements);
	cudaFree(d_C.elements);
}

int main() {

	int n, m, q;

	scanf("%d", &n);
	m = n;
	q = n;
	//printf("n=%d,m=%d,q=%d\n", n, m, q);

	Matrix A;
	Matrix B;
	Matrix C;

	int sizeA = n * m * sizeof(float);
	A.height = n;
	A.width = m;
	A.elements = new float[sizeA];

	int sizeB = m * q * sizeof(float);
	B.height = m;
	B.width = q;
	B.elements = new float[sizeB];

	int sizeC = n * q * sizeof(float);
	C.height = n;
	C.width = q;
	C.elements = new float[sizeC];

	srand(time(NULL));
	for (int i = 0; i < n*m; i++)
		scanf("%f", &A.elements[i]);

	for (int i = 0; i < m*q; i++)
		scanf("%f", &B.elements[i]);

	//print(A);
	//printf("\n");
	//print(B);
	//printf("\n");

	MatMul(A, B, C);

	free(A.elements);
	free(B.elements);
	free(C.elements);

	return 0;
}

// Matrix multiplication kernel called by MatMul()
__global__ void MatMulKernel(Matrix A, Matrix B, Matrix C) {
// Each thread computes one element of C
// by accumulating results into Cvalue
	int row = blockIdx.y * blockDim.y + threadIdx.y;
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	//int depth = blockIdx.z * blockDim.z + threadIdx.z;
	int depth = threadIdx.z;

	__shared__ float Cs[BLOCK_SIZE][BLOCK_SIZE][BLOCK_SIZE];

	Cs[threadIdx.y][threadIdx.x][threadIdx.z] = 0;
	for (int e = 0; e < A.width/BLOCK_SIZE; ++e) {
		Cs[threadIdx.y][threadIdx.x][threadIdx.z] += A.elements[row * A.width + depth * (A.width/BLOCK_SIZE) + e] *
														B.elements[e * B.width + depth * (A.width/BLOCK_SIZE) * B.width + col];
	}
	__syncthreads();

	int e = BLOCK_SIZE/2;
	while (threadIdx.z < e) {
		Cs[threadIdx.y][threadIdx.x][threadIdx.z] += Cs[threadIdx.y][threadIdx.x][threadIdx.z+e];
		__syncthreads();
		e /= 2;
	}

	if(threadIdx.z == 0)
		C.elements[row * C.width + col] = Cs[threadIdx.y][threadIdx.x][0];
}
