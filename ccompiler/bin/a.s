; -----begin include block-----
.include "lib/kernel.exp"
.include "lib/stdio.asm"
; -----end include block-----

.org PROC_TEXT_ORG

; -----begin text block-----
main:
  push bp
  mov bp, sp
  leave
  ret
; -----end text block-----

; -----begin data block-----
p: .dw 0
s_data: .db "Hello World", 0
s: .dw s_data
c: .db 'a'
d: .db 0
; -----end data block-----

.end
