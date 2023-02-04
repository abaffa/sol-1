; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  push byte 'A'
  push byte 'A'
  push byte 'A'
  mov bl, [bp + -2] ; c1
  push bl
  call f1
  add sp, 3
  leave
  syscall sys_terminate_proc
f1:
  push bp
  mov bp, sp
  mov d, 0
  mov b, 2
  add d, b
  mov b, d
  lea d, [bp + 5]
  add d, b
  mov bl, [d]
  mov [cc], bl
; --- begin inline asm block
    mov a, [cc];
    swp a
    call putchar
  ; --- end inline asm block
; --- end text block

; --- begin data block
cc: .fill 1, 0
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
