#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>
#include "structs.h"
#include "functions.h"

data_structure* get_data(char *instr, int *index)
{
	char *name1, *name2;
	void *banknote1, *banknote2;
	int size_bn1, size_bn2;
	// alocarea structurii new_data
	data_structure *new_data = malloc(sizeof(data_structure));
	new_data->header = malloc(sizeof(head));

	// parsarea instructiunii
	char *token = strtok(instr, " ");
	if (*index == 1) {
		token = strtok(NULL, " ");
		*index = atoi(token);
	}
	token = strtok(NULL, " ");

	// citirea valorilor din header
	new_data->header->type = token[0];
	char tp = token[0];
	new_data->header->len = 0;

	// citirea si salvarea primului nume
	token = strtok(NULL, " ");
	name1 = malloc((strlen(token) + 1) * sizeof(char));
	memcpy(name1, token, strlen(token) + 1);
	// modificarea lungimii datelor
	new_data->header->len += strlen(token) + 1;
	token = strtok(NULL, " ");

	// citirea valorii fiecarei bancnote (in functie de tip)
	if (tp == '1') {
		banknote1 = malloc(sizeof(int8_t));
        *(int8_t *)banknote1 = atoi(token);
		size_bn1 = sizeof(int8_t);

		token = strtok(NULL, " ");

        banknote2 = malloc(sizeof(int8_t));
        *(int8_t *)banknote2 = atoi(token);
		size_bn2 = sizeof(int8_t);

    } else if (tp == '2') {
        banknote1 = malloc(sizeof(int16_t));
        *(int16_t *)banknote1 = atoi(token);
		size_bn1 = sizeof(int16_t);

		token = strtok(NULL, " ");

        banknote2 = malloc(sizeof(int32_t));
        *(int32_t *)banknote2 = atoi(token);
		size_bn2 = sizeof(int32_t);

    } else if (tp == '3') {
        banknote1 = malloc(sizeof(int32_t));
        *(int32_t *)banknote1 = atoi(token);
		size_bn1 = sizeof(int32_t);

		token = strtok(NULL, " ");

        banknote2 = malloc(sizeof(int32_t));
        *(int32_t *)banknote2 = atoi(token);
		size_bn2 = sizeof(int32_t);
    }

	new_data->header->len += size_bn1 + size_bn2;

	// citirea si salvarea celui de al doilea nume
	token = strtok(NULL, " \n");
	name2 = malloc((strlen(token) + 1) * sizeof(char));
    memcpy(name2, token, strlen(token) + 1);
	new_data->header->len += strlen(token) + 1;

	// copierea datelor in noua structura
	// offset reprezinta pozitia curenta in parcurgerea datelor
	int offset = 0;
	new_data->data = malloc(new_data->header->len);

	memcpy(new_data->data + offset, name1, strlen(name1) + 1);
	offset += strlen(name1) + 1;

	memcpy(new_data->data + offset, banknote1, size_bn1);
	offset += size_bn1;

	memcpy(new_data->data + offset, banknote2, size_bn2);
	offset += size_bn2;

	memcpy(new_data->data + offset, name2, strlen(name2) + 1);
	offset += strlen(name2) + 1;

	free(name1);
	free(name2);
	free(banknote1);
	free(banknote2);

	return new_data;
}

// functie care returneaza numarul de bytes din vectorul generic arr
int get_size(void *arr, int len)
{
	int offset = 0;
	for (int i = 0; i < len; i++) {
		head *p = (head *)(arr + offset);
		offset += p->len + sizeof(head);
	}
	return offset;
}

int add_last(void **arr, int *len, data_structure *data)
{
	// in offset retinem numarul de bytes
	int offset = get_size(*arr, *len);
	if (*len == 0) {
		// nu exista alte date in arr
		*arr = malloc(data->header->len + sizeof(head));
		if (!(*arr))
			return -1;
	} else {
		// exista cel putin un element in arr
		int l = data->header->len + sizeof(head) + offset;
		*arr = realloc(*arr, l);
		if (!(*arr))
			return -1;
	}
	// copiem structura header in arr
	memcpy(*arr + offset, data->header, sizeof(head));
	offset += sizeof(head);
	// copiem datele in arr
	memcpy(*arr + offset, data->data, data->header->len);
	(*len)++;

	free(data->header);
	free(data->data);
	free(data);

	return 0;
}

// functie care returneaza indexul pentru anumite comenzi
int get_index(char *instr)
{ 
	char *token = strtok(instr, " ");
	token = strtok(NULL, " ");
	int index = atoi(token);

	return index;
}

int get_num_bytes(void *arr, int index)
{
	int offset = 0;
	// parcurgem fiecare element din arr pana la index
	for (int i = 0; i < index; i++) {
		head *p = (head *)(arr + offset);
		offset += sizeof(head);
		offset += p->len;
	}
	return offset;
}

int add_at(void **arr, int *len, data_structure *data, int index)
{
	if (index < 0)
		return -1;
	if (index > *len)
		index = *len;

	int size = get_size(*arr, *len);
	int data_size = data->header->len + sizeof(head);
	int offset = get_num_bytes(*arr, index);

	if (*len == 0) {
		// nu exista alte date in arr
		*arr = malloc(data->header->len + sizeof(head));
		if (!(*arr))
			return -1;
	} else {
		// exista cel putin un element in arr
		int l = data->header->len + sizeof(head) + size;
		*arr = realloc(*arr, l);
		if (!(*arr))
			return -1;

		// mut datele din arr la dreapta pentru a elibera pozitia cautata
		head *str1 = ((head *)(*arr + offset));
		int move_size = size - offset;
		head *str2 = ((head *)(*arr + offset + data_size));
		memcpy(str2, str1, move_size);
	}

	// copiem structura header in arr
	memcpy(*arr + offset, data->header, sizeof(head));
	offset += sizeof(head);
	// copiem datele in arr
	memcpy(*arr + offset, data->data, data->header->len);
	(*len)++;

	free(data->header);
	free(data->data);
	free(data);

	return 0;
}

void find(void *data_block, int len, int index)
{
	if (index < 0 || index >= len)
		return;

	int offset = get_num_bytes(data_block, index);
	print_elem(data_block, offset);
}

int delete_at(void **arr, int *len, int index)
{
	int offset = get_num_bytes(*arr, index);
	int size = get_size(*arr, *len);

	// elementele aflate inaite de index
	head *dest = ((head *)(*arr + offset));
	int elem_size = dest->len + sizeof(head);
	int del_size = size - offset - elem_size;

	// elementele aflate dupa index
	head *src = ((head *)(*arr + offset + elem_size));

	// stergerea elementului de pe pozitia index
	memcpy(dest, src, del_size);

	int new_size = size - elem_size;
	(*len)--;
	
	*arr = realloc(*arr, new_size);
	if (!(*arr))
		return -1;
	return 0;
}

// functie care afiseaza elementul de pe pozitia n
void print_elem(void *arr, int n)
{
	int offset = n;
	head *p = (head *)(arr + offset);
	offset += sizeof(head);

	// citim primul nume
	char *name1 = strtok(arr + offset, "\0");
	int size_name1 = strlen(name1) + 1;
	offset += size_name1;

	// citim valorile bancnotelor - inca nu stim tipul lor
	void *banknote1, *banknote2;
	if (p->type == '1') {
		banknote1 = malloc(sizeof(int8_t));
		*(int8_t *)banknote1 = *(int8_t *)(arr + offset);
		offset += sizeof(int8_t);

		banknote2 = malloc(sizeof(int8_t));
		*(int8_t *)banknote2 = *(int8_t *)(arr + offset);
		offset += sizeof(int8_t);

	} else if (p->type == '2') {
		banknote1 = malloc(sizeof(int16_t));
		*(int16_t *)banknote1 = *(int16_t *)(arr + offset);
		offset += sizeof(int16_t);

		banknote2 = malloc(sizeof(int32_t));
		*(int32_t *)banknote2 = *(int32_t *)(arr + offset);
		offset += sizeof(int32_t);

	} else if (p->type == '3') {
		banknote1 = malloc(sizeof(int32_t));
		*(int32_t *)banknote1 = *(int32_t *)(arr + offset);
		offset += sizeof(int32_t);

		banknote2 = malloc(sizeof(int32_t));
		*(int32_t *)banknote2 = *(int32_t *)(arr + offset);
		offset += sizeof(int32_t);

	}

	// citim al doilea nume
	char *name2 = strtok(arr + offset, "\0");

	// afisarea datelor in formatul dorit
	printf("Tipul %c\n", p->type);
	printf("%s pentru %s\n", name1, name2);
	if (p->type == '1') {
		printf("%"PRId8"\n", *(int8_t *)banknote1);
		printf("%"PRId8"\n", *(int8_t *)banknote2);

	} else if (p->type == '2') {
		printf("%"PRId16"\n", *(int16_t *)banknote1);
		printf("%"PRId32"\n", *(int32_t *)banknote2);

	} else if (p->type == '3') {
		printf("%"PRId32"\n", *(int32_t *)banknote1);
		printf("%"PRId32"\n", *(int32_t *)banknote2);
	}
	printf("\n");

	free(banknote1);
	free(banknote2);
}

void print(void *arr, int len)
{
	if (len == 0)
		return;

	int offset = 0;
	for (int i = 0; i < len; i++) {
		// afisare fiecare element
		print_elem(arr, offset);
		// parcurgere vector generic arr
		head *p = (head *)(arr + offset);
		offset += sizeof(head);
		offset += p->len;
	}
}
