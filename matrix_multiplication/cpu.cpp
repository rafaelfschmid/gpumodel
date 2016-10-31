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

#include <time.h>
#include <chrono>

// Matrices are stored in row-major order:
// M(row, col) = *(M.elements + row * M.width + col)
typedef struct {
	int width;
	int height;
	float* elements;
} Matrix;

void print(Matrix X) {
//	std::cout << X.height << "\n"; std::cout << X.width << "\n";
	for (int i = 0; i < X.height; i++) {
		for (int j = 0; j < X.width; j++) {
			std::cout << X.elements[i * X.width + j] << " ";
		}
		std::cout << "\n";
	}
}

// Matrix multiplication kernel called by MatMul()
void MatMul(Matrix A, Matrix B, Matrix C) {

	std::chrono::high_resolution_clock::time_point start =
			std::chrono::high_resolution_clock::now();
	float Cvalue = 0;

	for (int i = 0; i < A.height; i++)
		for (int j = 0; j < B.width; j++)
			for (int e = 0; e < A.width; ++e)
				C.elements[i * C.width + j] += A.elements[i * A.width + e]
						* B.elements[e * B.width + j];

	//printf("C[%d][%d] = %f", row, col, Cvalue);
	std::chrono::high_resolution_clock::time_point stop =
			std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> time_span = std::chrono::duration_cast<
			std::chrono::duration<double>>(stop - start);

	if (ELAPSED_TIME == 1) {
		std::cout << time_span.count() * 1000 << "\n";

	} else {
		print(C);
	}
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

	srand (time(NULL));for
(	int i = 0; i < n*m; i++)
	scanf("%f", &A.elements[i]);

	for (int i = 0; i < m * q; i++)
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

