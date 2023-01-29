; --- Filename: test.c

.include "lib/kernel.exp"

.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  push word 0 ; i
  mov b, 2 ; haha
  mov a, b
  swp a
  mov [bp + -1], a ; i
  leave
  syscall sys_terminate_proc
; --- end text block

; --- begin data block
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
