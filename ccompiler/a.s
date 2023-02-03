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
  push byte 'A'
  push byte 'A'
  push byte 'A'
  push byte 'A'
  push byte 'A'
  mov d, 0
  mov b, [i3]
  mov a, 4
  mul a, b
  add d, b
  mov b, [i2]
  mov a, 2
  mul a, b
  add d, b
  mov b, [i1]
  add d, b
  mov b, d
  lea d, [bp + -7]
  add d, b
  mov bl, [d]
  push bl
  call print
  add sp, 1
  leave
  syscall sys_terminate_proc
print:
  push bp
  mov bp, sp
; --- begin inline asm block
    mov a, [bp + 4]
    swp a
    call putchar
  ; --- end inline asm block
  leave
  ret
; --- end text block

; --- begin data block
c: .fill 1, 90
i1: .dw 2
i2: .dw 1
i3: .dw 0
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
