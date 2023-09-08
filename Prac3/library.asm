global library
extern malloc
extern strcpy
section .data
    struc library
        c_books: resb 5*8
        c_count: resb 1
        align 8
    endstruc
    c dq 0 ; pointer to library

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
; struct Book books [5];
; int count ;
; };

initialiseLibrary:
    push rbp
    mov rbp , rsp
; allocate memory for library
    mov rax, library_size
    call malloc
    mov [c], rax
    mov rbx, 0
    mov [rax + c_count], rbx
    leave
    ret

; Arguments:
; rdi: library*
; rsi: book*
addBook:
    push rbp
    mov rbp, rsp

    mov rbx, 5
    mov [c], rdi
    cmp [rdi + c_count], rbx
    jge exitFull

    mov rcx, [rdi + c_count]
    mov [rdi + c_books + rcx*8], rsi

    mov r10, [rdi + c_count]
    inc r10
    mov [rdi + c_count], r10

    mov rax, 1
    leave
    ret

exitFull:
    mov rax, 0
    leave
    ret

; add a book
