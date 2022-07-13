#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "linkedList.h"

int comp(const void *a,const void *b) {
    int *x = (int *) a;
    int *y = (int *) b;
    return *x - *y;
}
int main(int argc, char* argv[]) {
	int length = atoi(argv[1]);
	if(argc < 3) {
		printf("Not enough arguments...\n");
		exit(1);
	}
	else if((argc - 2) != (length)) {
		printf("Arguments do not match list size...\n");
		exit(1);
	} else {
	int intArray[argc];
	int i;
	// Initialize intArray to 0
	 // printf("variable argv[1] is: %i\n", length);
	for (i = 0; i < length; ++i) {
		intArray[i] = 0;
		// printf("intArray value initialized to: [%d] \n value of i [%i] \n", intArray[i], i);
	}
	// Populate intArray
	int j = 2;
	int end = 0;
	// printf("value of argv[j]: %i\n", atoi(argv[j]));
	for(i = 0; i < length; i++, j++) {
		intArray[i] = atoi(argv[j]);
		// printf("intArray: %i\n", intArray[i]);
		// printf("argv: %i\n", atoi(argv[j]));
		// printf("index of intArray: %i\n", i);
		// printf("index of argv: %i\n\n", j);
		end = i;
	}
	// debug: before quicksort
	// for(i = 0; i < length; ++i) {
	// 	printf("intArray before qsort: %i\n", intArray[i]);
	// }
	// Sort intArray
	qsort(intArray, end + 1, sizeof(*intArray), comp);
	// debug after quicksort
	// for(i = 0; i < length; ++i) {
	// 	printf("intArray after qsort: %i\n", intArray[i]);
	// }
	for(i = 0; i < length; ++i) {
		add(intArray[i], true);
	}
	print();
	return 0;
	}
}