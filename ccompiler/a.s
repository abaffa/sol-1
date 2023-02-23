; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  mov b, s
  mov d, b
  mov b, [d]
  leave
  syscall sys_terminate_proc
prints:
  push bp
  mov bp, sp
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
aa: .dw 233
p: .dw 444
ss: .dw 0, 22, 
s_data: .db "Hello", 0
s: .dw s_data
ii: .dw 45, 22, 
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
