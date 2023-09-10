global library
extern malloc
extern strcpy
extern strcmp

section .data
    struc Library
        c_books: resb 72*5
        align 4
        c_count: resd 1
    endstruc
    c dq 1 ; pointer to library
    struc Book
        .isbn: resb 13
        .title: resb 50
        align 4
        .quantity: resd 1
        .price: resd 1
    endstruc
section .text
    ; struct Library * initialiseLibrary ( void ) ;
    global initialiseLibrary
    ; int addBook ( struct Library * lib , struct Book * book ) ;
    global addBook
    ; struct Book * searchBookByISBN ( struct Library * lib , char * isbn ) ;
    global searchBookByISBN

; Arguments:
; rdi: void
; rax: return empty library*

; struct Library
; {
;     struct Book books [5];
;     int count;
; };

initialiseLibrary:
    push rbp
    mov rbp, rsp
    ; allocate memory for library
    mov rdi, Library_size
    call malloc
    mov [c], rax
    mov ecx, 0
    mov [rax + c_count], ecx

    leave
    ret

; Arguments:
; rdi: library*
; rsi: book*

addBook:
    push rbp
    mov rbp, rsp

    lea rsi, [rsi + Book.isbn]
    mov r10, [rsi + Book.quantity]
    call searchBookByISBN
    cmp rax, 0
    jne exit
    mov rbx, 5
    mov rcx, [rdi + c_count]
    push rcx
    cmp rcx, rbx
    jge exitFull
    movss xmm0, [rsi + Book.price]
    mov r11, [rsi + Book.quantity]

    mov r12, Book_size
    imul r12, rcx

    inc rcx
    mov [rdi + c_count], rcx

    mov [rdi + r12 + Book.quantity], r11
    movss [rdi + r12 + Book.price], xmm0
    push rdi
    push rsi
    push r12
    lea rdi, [rdi + r12 + Book.title]
    lea rsi, [rsi + Book.title]
    call strcpy
    pop rdi
    pop rsi
    pop r12
    push rdi
    push rsi
    lea rdi, [rdi + r12 + Book.isbn]
    lea rsi, [rsi + Book.isbn]
    call strcpy
    pop rdi
    pop rsi

    mov rax, 1
    leave
    ret

; Arguments:
; rdi: library*
; rsi: isbn*
; rax: return book*
; Arguments:
; rdi: library*
; rsi: isbn*
; rax: return book*

searchBookByISBN:
    push rbp
    mov rbp, rsp
    mov rdx, [rdi + c_count] ; Load the book count

    ; Initialize loop counter and book pointer
    mov rcx, 0
    lea rdi, [rdi + c_books]

    ; Loop through all books
    searchLoop:
        cmp rcx, rdx
        jge exitSearchNoBook

        mov r12, Book_size
        imul r12, rcx
        lea r8, [rdi + r12 + Book.isbn]

        ; Compare the ISBNs
        lea rax, [rsi + Book.isbn]
        call strcmp

        ; If strcmp returns 0 (meaning the ISBNs match), return the pointer to the book
        test rax, rax
        jz foundBook

        ; Move to the next book
        inc rcx
        jmp searchLoop

exitSearchNoBook:
    ; Book not found, return 0
    xor rax, rax
    leave
    ret

foundBook:
    ; Return the pointer to the found book
    lea rax, [rdi + r12]
    leave
    ret


exitFull:
    mov rax, 0
    leave
    ret
exit:
    mov rcx, [rdi + Book.quantity]
    add rcx, r10
    mov [rax + Book.quantity], rcx
    mov rax, 1
    leave
    ret