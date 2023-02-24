; --- FILENAME: auto.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  leave
  syscall sys_terminate_proc
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
p1: .fill 2, 0
p2: .fill 2, 0
SIZE: .fill 2, 0
c: .fill 1, 0
mm_data: .dw 1, 2, 
.fill 4, 0
mm: .dw mm_data
ss_data: .db "Hello", 0
ss: .dw ss_data
m2_data: .dw 3, 4, 5, 6, 
.fill 0, 0
m2: .dw m2_data
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
