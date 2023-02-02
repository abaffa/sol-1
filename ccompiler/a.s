; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  mov d, 0
  mov b, [i3]
  mov a, 25
  mul a, b
  add d, b
  mov b, [i2]
  mov a, 5
  mul a, b
  add d, b
  mov b, [i1]
  add d, b
  mov a, [d + matrix]
  mov b, a
  push bl
  call print
  add sp, 1
  leave
  syscall sys_terminate_proc
print:
  push bp
  mov bp, sp
; --- begin inline asm block
    mov a, ^c
    swp a
    add a, $0100
    call putchar
  ; --- end inline asm block
  leave
  ret
; --- end text block

; --- begin data block
matrix: .fill 125, 97
c: .fill 1, 90
i1: .dw 2
i2: .dw 1
i3: .dw 0
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
