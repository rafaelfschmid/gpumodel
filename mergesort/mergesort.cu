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
#define BLOCK_SIZE 16

// Matrix multiplication kernel called by MatMul()
__global__ void mergesort_kernel(int n, int* v) {
	int p, r;
	int b = 1;
	while (b < n) {
		p = 0;
		while (p + b < n) {
			r = p + 2 * b;
			if (r > n)
				r = n;
			intercala(p, p + b, r, v);
			p = p + 2 * b;
		}
		b = 2 * b;
	}
}

void print(Matrix X) {
	for (int i = 0; i < X.height; i++) {
		for (int j = 0; j < X.width; j++) {
			std::cout << X.elements[i * X.width + j] << " ";
		}
		std::cout << "\n";
	}
}

// Matrix multiplication - Host code
// Matrix dimensions are assumed to be multiples of BLOCK_SIZE
void mergesort(int n, int* v) {
// Load A and B to device memory
	Matrix d_A;
	d_A.width = d_A.stride = A.width;
	d_A.height = A.height;
	size_t size = A.width * A.height * sizeof(float);
	cudaMalloc(&d_A.elements, size);
	cudaMemcpy(d_A.elements, A.elements, size, cudaMemcpyHostToDevice);
	Matrix d_B;
	d_B.width = d_B.stride = B.width;
	d_B.height = B.height;
	size = B.width * B.height * sizeof(float);

	cudaMalloc(&d_B.elements, size);
	cudaMemcpy(d_B.elements, B.elements, size, cudaMemcpyHostToDevice);
// Allocate C in device memory
	Matrix d_C;
	d_C.width = d_C.stride = C.width;
	d_C.height = C.height;
	size = C.width * C.height * sizeof(float);
	cudaMalloc(&d_C.elements, size);
// Invoke kernel
	dim3 dimBlock(BLOCK_SIZE, BLOCK_SIZE);
	dim3 dimGrid(B.width / dimBlock.x, A.height / dimBlock.y);

	cudaEvent_t start, stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);

	cudaEventRecord(start);
	MatMulKernel<<<dimGrid, dimBlock>>>(d_A, d_B, d_C);
	cudaEventRecord(stop);

	if (ELAPSED_TIME == 1) {
		cudaEventSynchronize(stop);
		float milliseconds = 0;
		cudaEventElapsedTime(&milliseconds, start, stop);
		std::cout << milliseconds << "\n";
	} else {
		print(C);
	}

// Read C from device memory
	cudaMemcpy(C.elements, d_C.elements, size, cudaMemcpyDeviceToHost);

// Free device memory
	cudaFree(d_A.elements);
	cudaFree(d_B.elements);
	cudaFree(d_C.elements);
}

int main() {

	int n, m, q;
	n = m = q = 32;

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
	for (int i = 0; i < A.height * A.width; i++) {
		A.elements[i] = rand() % 10;
	}

	for (int i = 0; i < B.height * B.width; i++) {
		B.elements[i] = rand() % 10;
	}

	//print(A);
	//printf("\n");
	//print(B);
	//printf("\n");

	mergesort(A, B, C);

	return 0;
}

