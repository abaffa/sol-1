; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  push a
  mov a, 0
  mov b, 0
  push a
  mov a, 4
  mul a, b
  pop a
  add a, b
  mov b, 0
  push a
  mov a, 2
  mul a, b
  pop a
  add a, b
  mov b, 0
  add a, b
  mov a, [a + matrix]
  mov b, a
  pop a
  mov [c], bl
  leave
  syscall sys_terminate_proc
; --- end text block

; --- begin data block
matrix:
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
c:
.db 0
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
