; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  push byte 'A'
  push byte 'A'
  lea d, [bp + -1] ; c1
  mov b, d
  push b
  call f1
  add sp, 2
  leave
  syscall sys_terminate_proc
f1:
  push bp
  mov bp, sp
  push byte 'A'
  mov d, 0
  mov b, 0
  add d, b
  mov b, d
  lea d, [bp + 5]
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
