
.include "lib/kernel.exp"

.org PROC_TEXT_ORG

; -----begin text block-----
main:
; -----begin inline asm block-----
  mov d, s_data
  call puts
  call scan_u16d
  mov [rows], a
; -----end inline asm block-----
_for1_init:
  mov a, 0
  mov b, 0
  mov [i], b
_for1_cond:
  mov b, [i]
  push a
  mov a, b
  mov b, [rows]
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
; -----begin inline asm block-----
  mov a, [i]
  call print_u16d
; -----end inline asm block-----
_for1_update:
  mov a, 0
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
; -----begin inline asm block-----
  syscall sys_terminate_proc
; -----end inline asm block-----
; -----end text block-----

; -----begin data block-----
s_data: .db "Enter the number of rows: ", 0
s: .dw s_data
ss_data: .db "    ", 0
ss: .dw ss_data
coef: .dw 1
rows: .dw 0
space: .dw 0
i: .dw 0
j: .dw 0
nl_data: .db "\n\r", 0
nl: .dw nl_data
; -----end data block-----
; -----begin include block-----
.include "lib/stdio.asm"
; -----end include block-----

.end
