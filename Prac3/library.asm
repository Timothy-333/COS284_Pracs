global library
extern malloc

section .data
    struc Library
        align 4  ; Align the entire structure
        c_count: resd 1
        c_books: resq 5
        align 4  ; Align the books array
    endstruc
    c dq 1 ; pointer to library

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
    mov rcx, 5
    mov [rax + c_count], rcx

    leave
    ret

; Arguments:
; rdi: library*
; rsi: book*

addBook:
    push rbp
    mov rbp, rsp

    mov rbx, 5
    cmp [rdi + c_count], rbx
    jge exitFull

    mov rcx, [rdi + c_count]
    mov [rdi + c_books + rcx*8], rsi
    inc rcx
    mov [rdi + c_count], rcx

    mov rax, 1
    leave
    ret

exitFull:
    mov rax, 0
    leave
    ret
