; This makes your function available to other files
global greeting

section .data
; ==========================
  greeting_msg db 'Welcome to the Bank of <<Redacted>>', 0   ; The greeting message
  msg_len equ $ - greeting_msg                  ; The length of the message
; ==========================

section .text
; void greeting()
; This function prints a greeting to the screen
greeting:
  push rbp
  mov rbp, rsp
; Do not modify anything above this line unless you know what you are doing
; ==========================
  mov rax, 1    ; System call for write
  mov rdi, 1  ; File descriptor 1 is stdout
  mov rsi, greeting_msg ; Address of the string to output
  mov rdx, msg_len  ; Number of bytes
  syscall        ; Invoke
; ==========================
; Do not modify anything below this line unless you know what you are doing
  leave
  ret