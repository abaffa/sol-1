; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  mov b, [j]
  push a
  mov a, b
  mov b, [i]
  or a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [i]
  or a, b
  mov b, a
  pop a
  leave
  syscall sys_terminate_proc
; --- end text block

; --- begin data block
i: .fill 2, 00
j: .fill 2, 00
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
