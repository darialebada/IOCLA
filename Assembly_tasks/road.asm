%include "../include/io.mac"
/*
Se va calcula distanța dintre punctele dintr-un vector. Astfel, pentru un vector de 
4 puncte (A,B,C,D), se vor calcula 3 distanțe: *A-B* , *B-C*, *C-D*. Perechile de 
puncte se află pe drepte paralele cu axele.
*/

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global road
    extern printf

road:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]      ; points
    mov ecx, [ebp + 12]     ; len
    mov ebx, [ebp + 16]     ; distances
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    xor esi, esi        ; contor
    dec ecx             ; aflam lungimea vectorului de distante

while:
    cmp esi, ecx        ; verificam daca mai exista distante de calculat
    je end

points_distance:
    ; eliberam registrele in care vom lucra
    xor edx, edx
    xor edi, edi

    mov di, [eax + 4 * esi + point.x]           ; = x1
    mov dl, [eax + 4 * (esi + 1) + point.x]     ; = x2
    cmp edi, edx                                ; coordonate x sunt egale, deci verificam coordonatele y
    je equals

    cmp edi, edx
    jl dif                                       ; x1 este mai mic decat x2, deci |x1 - x2| = x2 - x1

    sub edi, edx                                 ; x1 - x2
    mov dword [ebx + 4 * esi], edi               ; am aflat distanta si o copiem pe pozitia corespunzatoare
    inc esi                                      ; incrementam contorul
    jmp while

dif:
    sub edx, edi                                 ; x2 - x1 sau y2 - y1
    mov dword [ebx + 4 * esi], edx               ; am aflat distanta si o copiem pe pozitia corespunzatoare 
    inc esi                                      ; incrementam contorul
    jmp while

equals:
    xor edx, edx
    xor edi, edi

    mov di, [eax + 4 * esi + point.y]           ; = y1
    mov dl, [eax + 4 * (esi + 1) + point.y]     ; = y2
    cmp edi, edx                                ; |y1 - y2| = y2 - y1
    jl dif

    sub edi, edx                                ; y1 - y2
    mov dword [ebx + 4 * esi], edi              ; am aflat distanta si o copiem pe pozitia corespunzatoare 
    inc esi                                     ; incrementam contorul
    jmp while

end:

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY