; --- Filename: factors.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
; --- begin inline asm block
		mov d, s_data
		call puts
		call scan_u16d
		mov [num], a
		mov d, s2_data
		call puts
	; --- end inline asm block
_for1_init:
  mov b, 1
  mov [i], b
_for1_cond:
  mov b, [i]
  push a
  mov a, b
  mov b, [num]
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for1_exit
_for1_block:
_if2_cond:
  mov b, [num]
  push a
  mov a, b
  mov b, [i]
  div a, b
  pop a
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if2_exit
_if2_true:
; --- begin inline asm block
				mov a, [i]
				call print_u16d
				mov d, nl_data
				call puts
			; --- end inline asm block
  jmp _if2_exit
_if2_exit:
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
; --- begin inline asm block
		syscall sys_terminate_proc
	; --- end inline asm block
; --- end text block

; --- begin data block
s_data: .db "Enter a positive integer: ", 0
s: .dw s_data
s2_data: .db "Factors are: ", 0
s2: .dw s2_data
nl_data: .db "\n", 0
nl: .dw nl_data
num: .dw 0
i: .dw 0
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
