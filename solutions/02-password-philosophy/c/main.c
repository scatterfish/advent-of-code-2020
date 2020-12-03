#include <stdio.h>
#include <stdlib.h>

int main() {
	
	FILE* fp;
	fp = fopen("input.txt", "r");
	if (fp == NULL) {
		return EXIT_FAILURE;
	}
	
	int part_one = 0;
	int part_two = 0;
	
	int min, max;
	char letter;
	char password[30];
	while (fscanf(fp, "%d-%d %c: %s", &min, &max, &letter, &password) == 4) {
		int letter_count = 0;
		for (int i = 0; password[i] != '\0'; i++) {
			if (password[i] == letter)
				letter_count++;
		}
		if (letter_count >= min && letter_count <= max)
			part_one++;
		if ((password[min - 1] == letter) != (password[max - 1] == letter))
			part_two++;
	}
	
	printf("Part 1 answer: %d\n", part_one);
	printf("Part 2 answer: %d\n", part_two);
	
	fclose(fp);
	return EXIT_SUCCESS;
}
