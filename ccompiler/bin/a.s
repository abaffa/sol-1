; -----begin include block-----
.include "lib/kernel.exp"
.include "lib/stdio.asm"
; -----end include block-----

.org PROC_TEXT_ORG

; -----begin text block-----
main:
  push bp
  mov bp, sp
  mov a, 0
  mov b, integer
  mov [p], b
  mov b, [p]
  mov d, b
  mov b, [d]
  mov d, b
  mov b, 22
  mov [d], b
  leave
  ret
; -----end text block-----

; -----begin data block-----
integer: .dw 25
p: .dw 0
; -----end data block-----

.end
