section .text
	global par

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression

; parantezele sunt valide doar daca exista un numar egal de
; paranteze deschise si inchise
; daca la un anumit pas numarul de paranteze inchise ')' este mai mare 
; decat numarul deparanteze deschise '(', atunci stringul dat nu este
; corect
par:
	push ebp
	push esp
	pop ebp

	xor esi, esi			; numarul de paranteze deschise
	xor edi, edi			; numarul de paranteze inchise
	xor ecx, ecx
	xor ebx, ebx
	xor eax, eax
	push dword [ebp + 8]
	pop ebx					; retinem numarul de paranteze
	push dword [ebp + 12]
	pop eax					; retinem stringul

while:
	cmp ebx, ecx			; am terminat de parcurs stringul
	je exit_correct

	cmp esi, edi			; verificam daca nr patanteze deschise < nr par inchise
	jl exit_wrong

	xor edx, edx			
	push dword [eax + ecx]	; citim un caracter din string
	pop edx

	; verificam ce tip de paranteza am citit
	cmp dl, '('				
	je par_open

	cmp dl, ')'
	je par_close

par_open:
	; incrementam numarul de paranteze deschise si numarul total
	; de paranteze parcurse din string
	inc esi
	inc ecx
	jmp while

par_close:
	; incrementam numarul de paranteze innchise si numarul total
	; de paranteze parcurse din string
	inc edi
	inc ecx
	jmp while

exit_correct:
	; verificam daca avem acelasi nr de paranteze deschise si inchise
	cmp esi, edi
	jne exit_wrong

	; am gasit un raspuns corect, afisam 1
	push 1
	pop eax
	jmp exit

exit_wrong:
	; am gasit un rasouns gresit, afisam 0
	push 0
	pop eax

exit:
	push ebp
	pop esp
	pop ebp
	ret
