#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>
#include "structs.h"
#include "functions.h"

#define MAX_LINE 257

int main()
{
	// the vector of bytes u have to work with
	// good luck :)
	void *arr = NULL;
	int len = 0;
    char *instr = malloc(MAX_LINE * sizeof(char));

    while (1) {
		// citim fiecare comanda
        fgets(instr, MAX_LINE, stdin);
        if (instr[strlen(instr) - 1] == '\n')
            instr[strlen(instr) - 1] = 0;

        if (strncmp(instr, "insert ", 7) == 0) {
			int index = 0;
            data_structure *data = get_data(instr, &index);
            add_last(&arr, &len, data);

        } else if (strncmp(instr, "insert_at", 9) == 0) {
			int index = 1;
			data_structure *data = get_data(instr, &index);
			add_at(&arr, &len, data, index);

		} else if (strncmp(instr, "delete_at", 9) == 0) {
			int index = get_index(instr);
			delete_at(&arr, &len, index);

		} else if (strncmp(instr, "find", 4) == 0) {
			int index = get_index(instr);
			find(arr, len, index);

		} else if (strncmp(instr, "print", 5) == 0) {
			print(arr, len);

		} else if (strncmp(instr, "exit", 4) == 0) {
			free(arr);
			break;
		}
    }
    free(instr);
	return 0;
}
