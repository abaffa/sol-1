; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  sub sp, 20 ; i
  lea d, [bp + -19] ; i_data
  mov b, d
  leave
  syscall sys_terminate_proc
prints:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  mov b, 23
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
aa: .dw 233
p: .dw 444
ss_data: .db 'a', 22, 
ss: .dw ss_data
s_data: .dw "Hello", 0
s: .dw s_data
ii_data: .dw 45, 22, 
ii: .dw ii_data
c: .db 'A'
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
