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

void print(float* x, const int n) {
	for (int i = 0; i < n; i++) {
		std::cout << x[i] << " ";
	}
	std::cout << "\n";
}

// Matrix multiplication - Host code
// Matrix dimensions are assumed to be multiples of BLOCK_SIZE
void VectorSum(float* idata, const int n) {
	int value = 0;
	for(int i = 0; i < n; i++){
		value += idata[i];
	}

	printf("%f\n", value);
}

int main() {

	int n;
	scanf("%d", &n);

	float* idata, *odata;
	int size = n * sizeof(float);
	idata = new float[size];

	for (int i = 0; i < n; i++)
		scanf("%f", &idata[i]);

	VectorSum(idata, n);

	//printf("result=%f\n", odata[n - 1]);

	free(idata);

	return 0;
}
