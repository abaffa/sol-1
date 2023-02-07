; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  sub sp, 4 ; i
  lea d, [bp + -3] ; i
  mov b, d
  mov d, b
  mov b, 0
  mov a, 2
  mul a, b
  add d, b
  mov b, 2
  mov a, b
  swp a
  mov [d], a
  lea d, [bp + -3] ; i
  mov b, d
  mov d, b
  mov b, 1
  mov a, 2
  mul a, b
  add d, b
  mov b, 1
  mov a, b
  swp a
  mov [d], a
; --- begin inline asm block
    mov a, [bp + -3]
    swp a
    call print_u16d
  ; --- end inline asm block
  leave
  syscall sys_terminate_proc
; --- end text block

; --- begin data block
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
