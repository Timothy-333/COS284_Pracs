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
    c dq 0 ; Pointer to struct Book

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
    push rdi
    push rsi
    push rdx

    movss [price], xmm0
    mov rdi, book_size
    call malloc
    mov [c], rax

    pop rdx
    pop rsi
    pop rdi
    movss xmm0, [price]

    mov rsi, [rsi]
    mov rdi, [rdi]

    mov [rax + c_isbn], rdi
    mov [rax + c_title], rsi
    movss [rax + c_price], xmm0
    mov [rax + c_quantity], edx
    
    ret