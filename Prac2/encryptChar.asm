global encryptChar

section .data

section .text
; char encryptChar(char**, char, char)

encryptChar:
    ; Parameters: rdi = matrix, rsi = input char, rdx = key char
    xor rax, rax
    sub rsi, 65
    sub rdx, 65
    mov qword rax, [rdi + rdx * 8]
    mov al, [rax + rsi]

    ret