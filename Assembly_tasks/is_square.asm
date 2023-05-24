%include "../include/io.mac"

// Analizarea fiecărei distanțe calculate anterior pentru a determina dacă este pătrat perfect.
section .text
    global is_square
    extern printf

section .data
    num dd 0

is_square:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; dist
    mov eax, [ebp + 12]     ; nr
    mov ecx, [ebp + 16]     ; sq
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    mov [num], eax          ; retinem in variabila globala num numarul de distante
    xor eax, eax
    xor edi, edi            ; contor care merge de la o la lungime vector de distante

while:
    cmp edi, [num]          ; verificam daca mai avem distante de verificat
    je end

    xor esi, esi            

loop:
    ; calculam patratele numerelor de la 0 la n, unde n^2 >= distanta curenta
    xor eax, eax
    mov eax, esi
    mul esi                 
    inc esi                         ; incrementam contorul pentru calculul patratelor perfecte

    ; incadram patratul perfect
    cmp eax, [ebx + 4 * edi]
    jl loop                         ; patratul perfect < distanta curenta, deci verificam urmatorul patrat
    cmp eax, [ebx + 4 * edi]
    je squared_root                 ; patratul perfect == distanta curenta, deci am gasit un patrat perfect
    cmp eax, [ebx + 4 * edi]
    jg not_squared_loop             ; patratul perfect > distanta curenta, deci distanta nu este patrat perfect

squared_root:
    mov dword [ecx + 4 * edi], 1
    inc edi
    jmp while

not_squared_loop:
    mov dword [ecx + 4 * edi], 0
    inc edi
    jmp while

end:

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY