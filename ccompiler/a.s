; --- Filename: test.c

.include "lib/kernel.exp"

.org PROC_TEXT_ORG

; --- begin text block
main:
; --- begin inline asm block
  call scan_u16d
  syscall sys_bkpt
  call print_u16d
  syscall sys_terminate_proc
; --- end inline asm block
; --- end text block

; --- begin data block
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
