; This makes your function available to other files
global populateMatrix

section .data
    alphabet db "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0
    matrix_size equ 26

section .bss
    matrix resb 26*26  ; Reserve space for the matrix

section .text
; char** populateMatrix()
; This creates a 2D array of characters and returns it

populateMatrix:
    mov rcx, 0   ; Outer loop index (row index)
    mov rax, 0   ; Inner loop index (column index)
    mov rdi, matrix ; load address of matrix into rdi
    mov rbx, alphabet ; load alphabet into rbx

populate_loop:
    cmp rcx, matrix_size ; compare row index to matrix size
    jge populate_end ; if row index >= matrix size, end loop
    xor rax, rax ; reset column index
    inner_loop:
        cmp rax, matrix_size ; compare column index to matrix size
        jge inner_loop_end ; if column index >= matrix size, end loop
        mov bl, [rbx] ; load current letter into bl
        mov [rdi], bl ; store current letter in matrix
        inc rdi ; increment matrix index
        inc rax ; increment column index
        jmp inner_loop ; jump to inner_loop
    inner_loop_end:
    inc rcx ; increment row index
    ror rbx, 1 ; Rotate alphabet one to the right
    jmp populate_loop ; jump to populate_loop

populate_end:
    mov rax, matrix ; return address of matrix
    ret
