; -----begin include block-----
.include "lib/kernel.exp"
.include "lib/stdio.asm"
; -----end include block-----

.org PROC_TEXT_ORG

; -----begin text block-----
main:
  push bp
  mov bp, sp
  mov b, 1
  push a
  mov a, b
  mov b, 2
  push a
  mov a, b
  mov b, 3
  mul a, b
  pop a
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 5
  add a, b
  mov b, a
  pop a
  mov [i1], b
  leave
  ret
; -----end text block-----

; -----begin data block-----
mychar: .db $61
p_data: .db "", 0
p: .dw p_data
i1: .dw 0
i2: .dw 0
; -----end data block-----

.end
