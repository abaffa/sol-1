; -----begin include block-----
.include "lib/kernel.exp"
.include "lib/stdio.asm"
; -----end include block-----

.org PROC_TEXT_ORG

; -----begin text block-----
main:
  push bp
  mov bp, sp
  push word 0
  mov a, 0
  mov b, integer
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  mov a, b
  swp a
  mov [bp + -1], a
; -----begin inline asm block-----
  syscall sys_terminate_proc
; -----end inline asm block-----
  leave
  ret
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
integer: .dw 25
s_data: .db "hello world", 0
s: .dw s_data
; -----end data block-----

.end
