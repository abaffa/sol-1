; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  push a
  mov a, 0
  mov b, [i3]
  push a
  mov a, 4
  mul a, b
  pop a
  add a, b
  mov b, [i2]
  push a
  mov a, 2
  mul a, b
  pop a
  add a, b
  mov b, [i1]
  add a, b
  mov a, [a + matrix]
  mov b, a
  pop a
  mov [c], bl
; --- begin inline asm block
    mov a, [c]
    swp a
    call putchar

  ; --- end inline asm block
  leave
  syscall sys_terminate_proc
; --- end text block

; --- begin data block
matrix: .fill 8, 65
c: .fill 1, 90
i1: .fill 2, 2
i2: .fill 2, 1
i3: .fill 2, 0
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
