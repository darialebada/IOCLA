section .text
	global sort

; struct node {
;     	int val;
;    	struct node* next;
; };

;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list
sort:
	enter 0, 0

    ; eliberam registrii in care vom lucra
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	xor esi, esi

	mov esi, 2				; valoarea pe care o cautam

	mov ebx, [ebp + 8]		; retinem numarul de elemente din vector

	mov eax, [ebp + 12]		; retinem stringul

; gasim primul element din string (care are valoarea 1)
search_head:
	cmp dword [eax], 1
	je found_head

    ; verificam urmatorul element
	add eax, 8
	jmp search_head

found_head:
	mov ecx, [ebp + 12]         ; cautam elementul cu valoarea 2
	cmp ebx, esi                ; daca stringul are mai mult de 1 termen
	jl exit

search_head_next:
	cmp dword [ecx], 2
	je add_head_next

	add ecx, 8
	jmp search_head_next

add_head_next:
    ; adaugam head.next
	mov [eax + 4], ecx

while:
    ; verificam daca mai avem elemente care trebuie sortate
	cmp ebx, esi
	je exit

	mov ecx, [ebp + 12]

while_search_first:
    ; caut primul element
	cmp esi, dword [ecx]
	je find_second_el

	add ecx, 8
	jmp while_search_first

find_second_el:
	inc esi             ; valoarea elementului urmator
	cmp ebx, esi        ; verific daca mai am elemente in vector
	jl exit

    ; parcurg stringul pana la gasirea valorii esi
	mov edx, [ebp + 12]

while_search_second:
    ; caut al doilea element
	cmp esi, dword [edx]
	je found_second_el

	add edx, 8
	jmp while_search_second	

found_second_el:
    ; completex campul node.next
	mov [ecx + 4], edx

	jmp while

exit:
	leave
	ret
