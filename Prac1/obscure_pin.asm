global obscure_pin

section .data
; ==========================
; Your data goes here
  buffer db 0,0,0,0
; ==========================

; void obscure_pin(char* pin)
; Obscures a 4-digit ASCII PIN in place.
; Assumes pin is in rdi.
section .text
obscure_pin:
  push rbp
  mov rbp, rsp
; Do not modify anything above this line unless you know what you are doing
; ==========================
; Your code goes here
  mov rbx, buffer ; buffer
  mov rcx, 0
  ; copy pin to buffer
  .copy_loop:
    movzx rdx, byte [rdi + rcx] ; Load the current character from the string
    cmp rcx, 4                  ; Check if it's the null terminator
    je .copy_done               ; If null terminator, exit loop
    mov byte [rbx + rcx], dl    ; Store the character back in the string
    inc rcx                     ; Increment the loop counter
    jmp .copy_loop              ; Repeat the loop

  .copy_done:
    xor rcx, rcx        
    
  mov rsi, 3 ; string index
  .parse_loop:
    movzx rdx, byte [rbx + rcx]  ; Load the current character from the string
    cmp rcx, 4                   ; Check if it's the null terminator
    je .done            ; If null terminator, exit loop
    ; obscure digits
    sub rdx, 48                 ; Convert ASCII digit to integer
    xor rdx, 0xF               ; XOR with 0xF
    ; convert back to ASCII and store in reverse order
    add rdx, 48                 ; Convert back to ASCII
    mov byte [rdi + rsi], dl    ; Store the character back in the string
    inc rcx                      ; Increment the loop counter
    dec rsi                      ; Decrement the string index
    jmp .parse_loop              ; Repeat the loop

  .done:
    mov rsi, rdi
; ==========================
; Do not modify anything below this line unless you know what you are doing

  leave
  ret
