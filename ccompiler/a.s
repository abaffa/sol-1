; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  mov b, 50
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  sub sp, 2 ; j
  mov b, 51
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
  leave
  syscall sys_terminate_proc
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
s_data: .db "Hello World", 0
s: .dw s_data
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
