#include <stdio.h>
#include <stdlib.h>

int main() {
	
	FILE* fp;
	fp = fopen("input.txt", "r");
	if (fp == NULL) {
		return EXIT_FAILURE;
	}
	
	fclose(fp);
	return EXIT_SUCCESS;
}
