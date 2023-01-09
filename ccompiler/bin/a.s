.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; -----begin text block-----
main:
  mov b, 5
  push b
  mov b, 10
  push b
  mov b, 15
  push b
  mov b, 1
  push b
  call test
  add sp, 8
; -----begin inline asm block-----
  syscall sys_terminate_proc
; -----end inline asm block-----
test:
  push bp
  mov bp, sp
  push word 0
  push byte 0
  push word 0
_for1_init:
  mov a, 0
  mov b, 0
  mov a, b
  swp a
  mov [bp + 7], a
_for1_cond:
  mov b, [bp + 7]
  swp b
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
  je _for1_exit
_for1_block:
_for1_update:
  mov b, [bp + 7]
  swp b
  jmp _for1_cond
_for1_exit:

; -----end text block-----


; -----begin data block-----


; -----end data block-----


; -----begin include block-----

.include "lib/stdio.asm"


; -----end include block-----


.end
