; This makes your function available to other files
global calculate_balance

section .data
; ==========================
  A db 0
; ==========================

section .text
; Calculate balance based on account number and pin
; Inputs:
;   rdi - account number
;   rsi - pin
; Outputs:
;   eax - balance
calculate_balance:
  push rbp
  mov rbp, rsp
  
; Do not modify anything above this line unless you know what you are doing
; ==========================
; Your code goes here
  mov [A] , rdi ; Store account number in A
  add rdi, rsi ; (A + P)
  imul rdi, rsi ; (A + P) * P
  xor rsi, [A] ; XOR account number and pin
  and rsi, rdi ; AND result and previous result
  mov rax, rsi ; Move result to rax
  mov rbx, 50000 ; Move 50000 to rbx
  xor rdx, rdx ; Clear rdx
  idiv rbx ; Divide rax by rbx
  add rdx, 50000 ; Add 50000 to rdx
  mov rax, rdx ; Move rdx to rax
; ==========================
; Do not modify anything below this line unless you know what you are doing
  leave
  ret