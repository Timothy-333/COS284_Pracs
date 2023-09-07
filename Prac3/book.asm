global book
extern malloc
extern strcpy
section .data
    isbn db "12345678",0
    title db 50
    price dd 1
    quantity dd 1
    struc book
        c_isbn: resb 8
        c_title: resb 8
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
    mov [isbn], rdi
    mov [title], rsi
    movss [price], xmm0
    mov [quantity], edx
    mov rdi, book_size
    call malloc
    mov [c], rax
    mov rdi, [isbn]
    mov [rax + c_isbn], rdi
    mov rsi, [title]
    mov [rax + c_title], rsi
    movss xmm0, [price]
    movss [rax + c_price], xmm0
    mov edx, [quantity]
    mov [rax + c_quantity], edx
    ; mov [isbn], rdi
    ; mov [title], rsi
    ; movss [price], xmm0
    ; mov [quantity], edx
    ; mov rdi, book_size
    ; call malloc
    ; mov [c], rax
    ; lea rdi, [rax + c_isbn]
    ; lea rsi, [isbn]
    ; call strcpy
    ; mov rax, [c]
    ; lea rdi, [rax + c_title]
    ; lea rsi, [title]
    ; call strcpy
    ; mov rax, [c]
    ; movss [rax + c_price], xmm0
    ; mov rax, [c]
    ; mov [rax + c_quantity], edx
    ; mov rax, [c]
    ret