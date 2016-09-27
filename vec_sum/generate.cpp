#include <time.h>
#include <algorithm>
#include <math.h>
#include <cstdlib>
#include <stdio.h>
#include <iostream>
#include <vector>

#ifndef EXP_BITS_SIZE
#define EXP_BITS_SIZE 4
#endif

void vectors_gen(int n, int bits_size_elements) {

	printf("%d\n", n);
	for (int i = 0; i < n; i++)
	{
		std::cout << rand() % bits_size_elements;
		std::cout << " ";
	}
}

int main(int argc, char** argv) {

	if (argc < 1) {
		printf(
				"Parameters needed: <number of elements>\n\n");
		return 0;
	}

	int n = atoi(argv[1]);

	srand(time(NULL));
	vectors_gen(n, pow(2, EXP_BITS_SIZE));
	printf("\n");

	return 0;
}

