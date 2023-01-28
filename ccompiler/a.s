; --- Filename: test.c

.include "lib/kernel.exp"

.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
_switch1_expr:
  mov b, [i]
  leave
  syscall sys_terminate_proc
; --- end text block

; --- begin data block
i: .dw 55
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
