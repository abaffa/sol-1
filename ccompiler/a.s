; --- Filename: test.c

.include "lib/kernel.exp"

.org PROC_TEXT_ORG

; --- begin text block
main:
; --- begin inline asm block
  mov al, 12
  call print_u8d
  syscall sys_terminate_proc
; --- end inline asm block
; --- end text block

; --- begin data block
i: .dw 0
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
