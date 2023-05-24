section .text
	global cmmmc

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b

;; vom calcula cmmmc prin adunari repetate pana gasim
;; sumele x*a = y*b
;; la fiecare pas se ia suma mai mica si se adauga termenul initial in ea
cmmmc:
	push ebp
	push esp
	pop ebp
	
	; eliberam registrele cu care vom lucra
	xor ecx, ecx
	xor edx, edx
	xor eax, eax

	push dword [ebp + 8]
	pop ecx					; retinem primul numar (a)
	push dword [ebp + 12]
	pop edx					; retinem al doilea numar (b)

while:
	cmp ecx, edx			; am gasit 2 sume egale, deci rezultatul este cmmmc
	je found_cmmmc

	cmp ecx, edx			; sum(a) < sum(b) => sum(a) += a
	jl add_first

	jmp add_last			; sum(a) > sum(b) => sum(b) += b

add_first:
	; sum(a) += a
	add ecx, dword [ebp + 8]
	jmp while

add_last:
	; sum(b) += b
	add edx, dword [ebp + 12]
	jmp while

found_cmmmc:
	; retinem in eax cmmmc
	push ecx
	pop eax

exit:
	push ebp
	pop esp
	pop ebp
	ret
