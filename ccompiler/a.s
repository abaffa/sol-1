; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  mov c, 0
  mov b, [i3]
  mov a, 25
  mul a, b
  add c, b
  mov b, [i2]
  mov a, 5
  mul a, b
  add c, b
  mov b, [i1]
  add c, b
  mov a, c
  mov a, [matrix + a]
  mov b, a
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
matrix: .fill 125, 65
c: .fill 1, 90
i1: .dw 2
i2: .dw 1
i3: .dw 0
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
