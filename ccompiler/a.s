; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  sub sp, 8 ; i
  sub sp, 2 ; j
  lea d, [bp + -7] ; i
  mov b, d
  mov d, b
  mov b, 1
  mov a, 4
  mul a, b
  add d, b
  mov b, 0
  mov a, 2
  mul a, b
  add d, b
  mov b, 2
  mov a, b
  swp a
  mov [d], a
  lea d, [bp + -7] ; i
  mov b, d
  mov d, b
  mov b, 1
  mov a, 4
  mul a, b
  add d, b
  mov b, 1
  mov a, 2
  mul a, b
  add d, b
  mov b, 1
  mov a, b
  swp a
  mov [d], a
  lea d, [bp + -7] ; i
  mov b, d
  mov d, b
  mov b, 1
  mov a, 4
  mul a, b
  add d, b
  mov b, 0
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  swp b
  mov a, b
  swp a
  mov [bp + -9], a ; j
; --- begin inline asm block
    mov a, [bp + -9]
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
