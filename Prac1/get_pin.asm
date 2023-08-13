; This makes your function available to other files
global get_pin

section .data
; ==========================
  prompt db "Enter 4-digit PIN: "
  prompt_len equ $ - prompt
  input_buffer db 4
; ==========================
section .bss
    input_char resb 1  ; Buffer to store the user input character

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
  mov rdi, 1    ; System call for write
  mov rax, 1  ; File descriptor 1 is stdout
  mov rsi, prompt ; Address of the string to output
  mov rdx, prompt_len ; Number of bytes
  syscall        ; Invoke
  ; Read the pin from stdin and store it in a buffer
  mov rax, 0            ; Syscall number for sys_read
  mov rdi, 0            ; File descriptor 0 is stdin
  mov rsi, input_buffer   ; Address of the buffer to store the character
  mov rdx, 4            ; Number of bytes to read
  syscall              ; Call the kernel
; Convert the pin to an integer
  xor rax, rax
  mov rcx, 4
  lea rsi, [input_buffer]

.parse_loop:
  movzx rdx, byte [rsi]  ; Load the current character from the string
  sub rdx, '0'                 ; Convert ASCII digit to integer
  imul rax, rax, 10           ; Multiply rax by 10
  add rax, rdx                 ; Add the new digit
  inc rsi                      ; Move to the next character
  loop .parse_loop              ; Repeat the loop

.convert_done:
  mov rax,rax
; ==========================
; Do not modify anything below this line unless you know what you are doing
  leave
  ret