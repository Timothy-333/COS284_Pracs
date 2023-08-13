; This makes your function available to other files
global get_pin

section .data
; ==========================
  prompt db "Enter 4-digit PIN: ", 0
  prompt_len equ $ - prompt
; ==========================
section .bss
    input_char resb 4  ; Buffer to store the user input character

section .text
; uint32_t get_pin()
; Reads a 4-digit PIN from stdin and converts it to an integer.
; The PIN returned must be a valid 4-digit (32-bit) integer.
get_pin:
  push rbp
  mov rbp, rsp
; Do not modify anything above this line unless you know what you are doing
; ==========================
  ; Write the prompt to stdout
  mov rax, 1    ; System call for write
  mov rdi, 1  ; File descriptor 1 is stdout
  mov rsi, prompt ; Address of the string to output
  mov rdx, 19 ; Number of bytes
  syscall        ; Invoke
  ; Read the pin from stdin and store it in a buffer
  mov rax, 0            ; Syscall number for sys_read
  mov rbx, 0            ; File descriptor 0 is stdin
  mov rsi, input_char   ; Address of the buffer to store the character
  mov rdx, 4            ; Number of bytes to read
  syscall              ; Call the kernel
; Convert the pin to an integer
  xor rax, rax  ; Initialize rax to zero
  xor rcx, rcx  ; Initialize rcx to zero

.parse_loop:
  movzx rdx, byte [rsi + rcx]  ; Load the current character from the string
  cmp rdx, 0                   ; Check if it's the null terminator
  je .convert_done             ; If null terminator, exit loop
  sub rdx, '0'                 ; Convert ASCII digit to integer
  imul rax, rax, 10           ; Multiply rax by 10
  add rax, rdx                 ; Add the new digit
  inc rcx                      ; Move to the next character
  jmp .parse_loop              ; Repeat the loop

.convert_done:
  mov rax, rax
; ==========================
; Do not modify anything below this line unless you know what you are doing
  leave
  ret