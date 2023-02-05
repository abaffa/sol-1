; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  sub sp, 100 ; m
  lea d, [bp + -99] ; m
  mov b, d
  mov d, b
  mov b, 0
  mov a, 10
  mul a, b
  add d, b
  mov b, 1
  add d, b
  mov bl, 'A'
  mov bl, al
  mov [d], al
  leave
  syscall sys_terminate_proc
f1:
  push bp
  mov bp, sp
  sub sp, 1 ; cc
  lea d, [bp + 5] ; c
  mov b, [d]
  swp b
  mov d, b
  mov b, 1
  mov a, 10
  mul a, b
  add d, b
  mov b, 0
  add d, b
  mov bl, [d]
  mov al, bl
  mov [bp + 0], al ; cc
; --- begin inline asm block
    mov a, [bp + 0];
    swp a
    call putchar
  ; --- end inline asm block
  leave
  ret
; --- end text block

; --- begin data block
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
