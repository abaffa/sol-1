; -----begin include block-----
.include "lib/kernel.exp"
.include "lib/stdio.asm"
; -----end include block-----

.org PROC_TEXT_ORG

; -----begin text block-----
main:
  push bp
  mov bp, sp
_while1_cond:
  mov b, [i1]
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  mov a, b
  cmp a, 0
  je _while1_exit
_while1_block:
  jmp _while1_cond
_while1_exit:
  leave
  ret
; -----end text block-----

; -----begin data block-----
mychar: .db $61
p_data: .db "", 0
p: .dw p_data
s_data: .db "Hello World", 0
s: .dw s_data
i1: .dw 0
i2: .dw 0
; -----end data block-----

.end
