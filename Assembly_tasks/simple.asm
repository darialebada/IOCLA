%include "../include/io.mac"
/*
Algoritm de criptare care presupune shiftarea la dreapta în cadrul alfabetului 
a fiecărui caracter de un anumit număr de ori. De exemplu, textul ANABANANA se transformă 
în BOBCBOBOB când pasul este 1. Se folosesc doar majuscule din alfabetul englez. Astfel, 
o criptare cu pasul 26 nu modifică litera, întrucât alfabetul englez are 26 de caractere.
*/
section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain - string de criptat
    mov     edi, [ebp + 16] ; enc_string - unde criptam
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here

    ; punem 0 in registrele in care vom lucra
    xor eax, eax
    xor ebx, ebx                ; contor pentru pasi

while: 
    mov al, [esi + ebx]         ; luam fiecare caracter si il prelucram
    add eax, edx                ; adaugam pasul
    cmp eax, 91                 ; verificam daca nu am depasit codul ascii al literei Z
    jl dif
    sub eax, 26                 ; aflam litera pentru cazul de mai sus
dif:
    mov [edi + ebx], eax        ; mutam litera in enc_string
    inc ebx                     ; trecem la litera urmatoare
    cmp ecx, ebx                ; verificam daca mai avem litere de criptat
    jne while
 

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
