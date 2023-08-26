; This makes your function available to other files
global populateMatrix

section .data
    alphabet db "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    matrix_size equ 26

section .bss
    matrix resb matrix_size * matrix_size
    strArr resq 26 ; outer array, the pointer to the pointer

section .text

populateMatrix:
    mov rdi, strArr  ; Load the address of strArr into rdi
    mov rsi, matrix
    ; Outer loop setup
    xor rcx, rcx  ; Clear rcx to use as an outer loop counter
outer_loop:
    mov qword [rdi + rcx*8], rsi  ; Set strArr element to point to matrix section
    xor r9, r9    ; Clear r9 to use as an inner loop counter
    inner_loop:
        cmp r9, matrix_size     ; Compare r9 with matrix_size (section length)
        jge end_inner   ; Jump to end_inner if r9 is greater or equal to 26
        mov rbx , matrix_size   ; Load matrix_size into ebx
        mov rax, rcx    ; Load rcx into eax
        add rax, r9     ; Add r9 to eax
        xor rdx, rdx    ; Clear edx to use as a division remainder
        div rbx         ; Divide eax by ebx
        mov al, [alphabet + rdx]  ; Load the character from the alphabet
        mov byte [rsi + r9], al  ; Populate the character in the matrix section
        inc r9         ; Increment r9 to the next character position
        jmp inner_loop  ; Jump back to inner_loop
    end_inner:
    add rsi, matrix_size     ; Move to the next matrix section
    inc rcx
    cmp rcx, matrix_size
    jl outer_loop   ; Jump to outer_loop if rcx is less than matrix_size
    
    mov rax, rdi
    ret
