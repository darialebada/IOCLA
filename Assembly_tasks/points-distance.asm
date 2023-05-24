%include "../include/io.mac"

// Se va calcula distanța dintre două puncte aflate pe o dreapta paralelă cu axele OX sau OY
struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global points_distance
    extern printf

points_distance:
    ;; DO NOT MODIFY
    
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; points
    mov eax, [ebp + 12]     ; distance
    ;; DO NOT MODIFY
   
    ;; Your code starts here
    
    ; eliberam registrele in care vom lucra
    xor edx, edx
    xor ecx, ecx

    mov cl, [ebx + point.x]         ; = x1
    mov dl, [ebx + 4 + point.x]     ; = x2
    cmp ecx, edx                    
    je equals                       ; coordonate x sunt egale, deci verificam coordonatele y

    cmp ecx, edx
    jl dif                          ; x1 este mai mic decat x2, deci |x1 - x2| = x2 - x1

    sub ecx, edx                    ; x1 - x2
    mov [eax], ecx                  ; am aflat distanta
    jmp end

dif:
    sub edx, ecx                    ; x2 - x1 sau y2 - y1
    mov [eax], edx                  ; am aflat distanta
    jmp end

equals:
    ; eliberam registrele
    xor edx, edx
    xor ecx, ecx

    mov cl, [ebx + point.y]         ; = y1
    mov dl, [ebx + 4 + point.y]     ; = y2
    cmp ecx, edx                    ; |y1 - y2| = y2 - y1
    jl dif

    sub ecx, edx                    ; y1 - y2
    mov [eax], ecx                  ; am aflat distanta
    jmp end

end:

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret

    ;; DO NOT MODIFY