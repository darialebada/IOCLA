#ifndef _FUNCTIONS_H_
#define _FUNCTIONS_H_

data_structure* get_data(char *instr, int *index);

int get_size(void *arr, int len);

int add_last(void **arr, int *len, data_structure *data);

int get_index(char *instr);

int get_num_bytes(void *arr, int index);

int add_at(void **arr, int *len, data_structure *data, int index);

void print_elem(void *arr, int n);

void find(void *data_block, int len, int index);

int delete_at(void **arr, int *len, int index);

void print(void *arr, int len);

#endif  // _FUNCTIONS_H_
