%include "../include/io.mac"

section .text
    global beaufort
    extern printf

section .data
    len_plain dd 0
    len_key dd 0

; void beaufort(int len_plain, char *plain, int len_key, char *key, char tabula_recta[26][26], char *enc) ;
beaufort:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; len_plain
    mov ebx, [ebp + 12] ; plain (address of first element in string)
    mov ecx, [ebp + 16] ; len_key
    mov edx, [ebp + 20] ; key (address of first element in matrix)
    mov edi, [ebp + 24] ; tabula_recta
    mov esi, [ebp + 28] ; enc
    ;; DO NOT MODIFY
    ;; TODO: Implement spiral encryption
    ;; FREESTYLE STARTS HERE

    mov [len_plain], eax   
    mov [len_key], ecx  
    ; eliberam registrele in care vom lucra       
    xor eax, eax
    xor ecx, ecx
    xor edi, edi

while:
    cmp edi, [len_plain]        ; verific daca mai avem litere de criptat
    je end

while_key:
    ; realizez un ciclu in cheie
    cmp ecx, [len_key]          ; verific daca mai avem litere in cheie
    je restore_len

enc:
    ; formula calcul litera criptata:
    ; litera criptata = |litera cheie - litera string| + 65
    mov al, [edx + ecx]         ; iau cate o litera din cheie
    add al, 65                  
    sub al, [ebx + edi]         ; scad litera din string corespunzatoare
    cmp eax, 65                 ; verific daca am un caracter valid (majuscula)
    jge continue
    add eax, 26
    
continue:
    mov [esi + edi], eax        ; copiez caracterul criptat in enc
    inc ecx                     ; incrementez contotul de cheie
    inc edi                     ; incrementez contorul de string
    jmp while

restore_len:
    xor ecx, ecx                ; revin la primul element din cheie
    jmp enc

end:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
