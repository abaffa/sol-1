; --- Filename: pascal.c

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
  mov [rows], a
; --- end inline asm block
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
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  mov a, b
  cmp a, 0
  je _for1_exit
_for1_block:
_for2_init:
  mov b, 1
  mov [space], b
_for2_cond:
  mov b, [space]
  push a
  mov a, b
  mov b, [rows]
  push a
  mov a, b
  mov b, [i]
  sub a, b
  mov b, a
  pop a
  cmp a, b
  lodflgs
  and al, %00000011
  mov ah, 0
  mov b, a
  pop a
  mov a, b
  cmp a, 0
  je _for2_exit
_for2_block:
  call print
_for2_update:
  mov b, [space]
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  mov [space], b
  jmp _for2_cond
_for2_exit:
_for3_init:
  mov b, 0
  mov [j], b
_for3_cond:
  mov b, [j]
  push a
  mov a, b
  mov b, [i]
  cmp a, b
  lodflgs
  and al, %00000011
  mov ah, 0
  mov b, a
  pop a
  mov a, b
  cmp a, 0
  je _for3_exit
_for3_block:
_if4_cond:
  mov b, [j]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [i]
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
  push a
  lodflgs
  mov b, a
  pop a
  not bl
  and bl, %00000001
  mov bh, 0
  cmp a, 0
  lodflgs
  not al
  and al, %00000001
  mov ah, 0
  or a, b
  mov b, a
  pop a
  cmp b, 0
  je _if4_else_block
_if4_block:
  mov b, 1
  mov [coef], b
  jmp _if4_exit
_if4_else_block:
  mov b, [coef]
  push a
  mov a, b
  mov b, [i]
  push a
  mov a, b
  mov b, [j]
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [j]
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [coef], b
_if4_exit:
  call print
  mov b, [coef]
  push b
  call print_nbr
  add sp, 2
_for3_update:
  mov b, [j]
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  mov [j], b
  jmp _for3_cond
_for3_exit:
; --- begin inline asm block
  mov d, nl_data
  call puts
; --- end inline asm block
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
  leave
  syscall sys_terminate_proc
print_nbr:
	push bp
	mov bp, sp
; --- begin inline asm block
  mov a, [bp + 5] ; n
  call print_u16d
; --- end inline asm block
  leave
  ret
print:
	push bp
	mov bp, sp
; --- begin inline asm block
  mov d, ss_data
  call puts
; --- end inline asm block
  leave
  ret
; --- end text block

; --- begin data block
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
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
