; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
; --- begin inline asm block
   ; --- end inline asm block
  leave
  syscall sys_terminate_proc
; --- end text block

; --- begin data block
c: .db 11, 22, 33, 
mp: .dw 222, 0, 123, 
matrix: .dw 1, 2, 3, 
m_data: .db "hello", 0
m: .dw m_data
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
