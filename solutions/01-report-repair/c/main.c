#include <stdio.h>
#include <stdlib.h>

int main() {
	
	FILE* fp;
	fp = fopen("input.txt", "r");
	if (fp == NULL) {
		return EXIT_FAILURE;
	}
	
	int* report = calloc(200, sizeof(int));
	
	char* input_line = NULL;
	size_t s = 0;
	for (int i = 0; i < 200; i++) {
		getline(&input_line, &s, fp);
		report[i] = strtol(input_line, NULL, 10);
	}
	
	int part_one = 0;
	int part_two = 0;
	for (int i = 0; i < 200; i++) {
		for (int j = i; j < 200; j++) {
			for (int k = j; k < 200; k++) {
				if (report[i] + report[j] == 2020) {
					part_one = report[i] * report[j];
				}
				if (report[i] + report[j] + report[k] == 2020) {
					part_two = report[i] * report[j] * report[k];
				}
			}
		}
	}
	
	printf("Part 1 answer: %d\n", part_one);
	printf("Part 2 answer: %d\n", part_two);
	
	free(report);
	free(input_line);
	free(fp);
	return EXIT_SUCCESS;
}
