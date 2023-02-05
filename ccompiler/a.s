; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  push byte 'A'
  push byte 'A'
  mov b, 55
  mov a, b
  swp a
  mov [bp + -1], a ; j
  mov b, [bp + -1] ; j
  swp b
  swp b
  push b
  call f2
  add sp, 2
; --- begin inline asm block

    ; division
  ; --- end inline asm block
  push byte 'A'
  push byte 'A'
  lea d, [bp + -3] ; c1
  mov b, d
  swp b
  swp b
  push b
  call f1
  add sp, 2
  leave
  syscall sys_terminate_proc
f2:
  push bp
  mov bp, sp
f1:
  push bp
  mov bp, sp
  push byte 'A'
  lea d, [bp + 5] ; c
  mov b, [d]
  swp b
  mov d, b
  mov b, 1
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
