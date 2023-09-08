global book
extern malloc
extern strcpy
section .data
    price dd 0.0
    struc book
        c_isbn: resb 13
        c_title: resb 50
        align 4
        c_price: resd 1
        c_quantity: resd 1
    endstruc
    c dq 1 ; Pointer to struct Book

section .text
    global allocateBook

; Arguments:
; RDI - char *isbn
; RSI - char *title
; XMM0 - float price
; EDX - int quantity
; Return:
; RAX - struct Book *

allocateBook:
    push rbp
    mov rbp , rsp
    push rdi
    push rsi
    push rdx

    movss [price], xmm0
    mov rdi, book_size
    call malloc
    mov [c], rax

    pop rdx
    movss xmm0, [price]
    movss [rax + c_price], xmm0
    mov [rax + c_quantity], edx

    pop rsi
    lea rdi, [rax + c_title]
    call strcpy
    mov rax, [c]

    pop rdi
    lea rsi, [rdi]
    lea rdi, [rax + c_isbn]
    call strcpy
    mov rax, [c]


    leave
    ret