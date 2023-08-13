; This tells the function that these exist outside of this file
extern greeting
extern get_pin
extern obscure_pin
extern calculate_balance
extern calculate_account

; This makes your function available to other files
global create_account

section .data
; ==========================
; Your data goes here
  acc_ptr dq 0
  pin_ptr dq 0
  bal_ptr dq 0
  acc_num_val dd 0
  pin_val dd 0
  account_message db 'Your account number is:',0
  acc_len equ $ - account_message 
  balance_message db 'Your balance is:',0
  bal_len equ $ - balance_message
  pin_message db 'Your obscured PIN is:',0
  pin_len equ $ - pin_message
  newline db 10,10,0
; ==========================

section .text
; void create_account(char *account_number, char *obscured_pin, char *balance)
; 
; Inputs:
;   rdi - account number
;   rsi - pin
;   rdx - balance
; 
; README:
; A lot has been given to start you off. You should be able to complete this without fully understanding how
; the functions work. I recommend using the foundation provided, however, you are free to change it as you see fit.
create_account:
  push rbp
  mov rbp, rsp
  sub rsp, 32

  mov qword [acc_ptr], rdi
  mov qword [pin_ptr], rsi
  mov qword [bal_ptr], rdx

  ; Greet the user (Diplomacy)
  call greeting

  ; Get the pin as a 32 bit integer
  call get_pin ; Call get_pin function
  mov [pin_val], eax  ; save pin

  ; Calculate the account number
  mov rdi, rax
  call calculate_account
  mov [acc_num_val], eax  ; save account number

  ; Calculate the balance
  mov edi, eax  ; set account number as the first argument to calculate balance
  mov esi, [pin_val]  ; set pin as the second argument to calculate balance
  call calculate_balance
  ; Convert the balance to ascii and store it in the balance pointer
  mov rsi, [bal_ptr]
  mov rbx, 10
  mov rcx, 5
  .balance_loop:
    xor rdx, rdx
    idiv rbx
    add dl, 48
    mov byte [rsi + 4], dl
    dec rsi
    test rax, rax
    loop .balance_loop
  ; Convert the pin to ascii and store it in the pin pointer
  mov rax, [pin_val]
  mov rsi, [pin_ptr]
  mov rbx, 10
  mov rcx, 4

  .pin_loop:
    xor rdx, rdx
    idiv rbx
    add dl, 48
    mov byte [rsi + 3], dl
    dec rsi
    test rax, rax
    loop .pin_loop
  ; Convert the account number to ascii and store it in the account number pointer
  mov eax, [acc_num_val]
  mov rsi, [acc_ptr]
  mov rbx, 10
  mov rcx, 5

  .account_loop:
    xor rdx, rdx
    idiv rbx
    add dl, 48
    mov byte [rsi + 4], dl
    dec rsi
    test rax, rax
    loop .account_loop

  ; Output account number
  mov rsi, account_message
  mov rdi, 1
  mov rax, 1
  mov rdx, acc_len
  syscall
  mov rsi, newline
  mov rdi, 1
  mov rax, 1
  mov rdx, 1
  syscall
  mov rsi, [acc_ptr]
  mov rdi, 1
  mov rax, 1
  mov rdx, 5
  syscall
  ; Output balance message
  mov rsi, newline
  mov rdi, 1
  mov rax, 1
  mov rdx, 1
  syscall
  mov rsi, balance_message
  mov rdi, 1
  mov rax, 1
  mov rdx, bal_len
  syscall
  mov rsi, newline
  mov rdi, 1
  mov rax, 1
  mov rdx, 1
  syscall
  mov rsi, [bal_ptr]
  mov rdi, 1
  mov rax, 1
  mov rdx, 5
  syscall
  ; Obsfucate the pin
  mov rdi, pin_ptr
  call obscure_pin
  ; Output newline
  ; mov rsi, newline
  ; mov rdi, 1
  ; mov rax, 1
  ; mov rdx, 1
  ; syscall
  ; ; Output pin message
  ; mov rsi, pin_message
  ; mov rdi, 1
  ; mov rax, 1
  ; mov rdx, pin_len
  ; syscall
  ; mov rsi, newline
  ; mov rdi, 1
  ; mov rax, 1
  ; mov rdx, 1
  ; syscall
  ; ; Output obscured pin
  ; mov rsi, [pin_ptr]
  ; mov rdi, 1
  ; mov rax, 1
  ; mov rdx, 4
  ; syscall
    
  leave
  ret
