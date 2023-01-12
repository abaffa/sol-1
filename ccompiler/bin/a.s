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
  mov b, mychar
  mov [p], bl
  mov bl, [p]
  mov d, b
  mov bl, 'b'
  mov bh, 0
  mov [d], bl
  leave
  ret
; -----end text block-----

; -----begin data block-----
mychar: .db $61
p_data: .db "", 0
p: .dw p_data
; -----end data block-----

.end
