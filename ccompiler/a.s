; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  sub sp, 100 ; m
  sub sp, 2 ; i
  sub sp, 2 ; j
  sub sp, 2 ; p
  lea d, [bp + -99] ; m
  mov b, d
  mov a, b
  swp a
  mov [bp + -105], a ; p
  leave
  syscall sys_terminate_proc
; --- end text block

; --- begin data block
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
