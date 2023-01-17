; --- Filename: pascal.c

.include "lib/kernel.exp"

.org PROC_TEXT_ORG

; --- begin text block
main:
_for1_init:
  mov b, 0
  mov [i], b
_for1_cond:
  mov b, [i]
  push a
  mov a, b
  mov b, [rows]
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000011
  mov b, a
  pop a
  mov a, b
  cmp a, 0
  je _for1_exit
_for1_block:
_for1_update:
  mov b, [i]
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  mov [i], b
  jmp _for1_cond
_for1_exit:
; --- end text block

; --- begin data block
s_data: .db "Enter the number of rows: ", 0
s: .dw s_data
i: .dw 0
rows: .dw 10
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
