global allocateBooke

section .data

section .text
;struct Book *allocateBook(char *isbn, char *title, float price, int quantity);
allocateBook:
    ;parameters: rdi = isbn, rsi = title, xmm0 = price, ecx = quantity
    
