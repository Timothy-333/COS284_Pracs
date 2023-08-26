extern encryptChar
extern populateMatrix
global encryptString

section .data
section .bss
    outputString resb 500
    spaces resb 1
section .text
; char encryptString(char**, char*, char*)

encryptString:
    ; Parameters: rdi = matrix, rsi = input string, rdx = keyword
    mov r12, 0
    mov r8, rsi
    xor rcx, rcx
    xor r9, r9
    mov r10, rdx
    messageLoop:
        mov byte bl, [r8 + rcx]
        cmp rbx, 0
        je endMessageLoop
        cmp rbx, 32
        je space
        mov rsi, rbx
        xor rdx, rdx
        mov byte dl, [r10 + r9]
        call encryptChar
        mov [outputString + rcx + r12], rax
        inc rcx
        inc r9
        mov byte bl, [r10 + r9]
        cmp rbx, 0
        je resetR9
        jmp messageLoop
    space:
        dec r12
        inc rcx
        jmp messageLoop
    resetR9:
        xor r9, r9
        jmp messageLoop
    endMessageLoop:
        mov byte [outputString + rcx + r12], 0
        mov rax, outputString
        ret
