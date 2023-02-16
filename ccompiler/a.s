; --- Filename: primes.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
; --- begin inline asm block
		mov a, [prompt]
		mov d, a
		call puts
		call scan_u16d
		mov [top], a
	; --- end inline asm block
  call primes
; --- begin inline asm block
		syscall sys_terminate_proc
	; --- end inline asm block
primes:
  push bp
  mov bp, sp
  mov b, 2
  mov [n], b
_while1_cond:
  mov b, [n]
  push a
  mov a, b
  mov b, [top]
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while1_exit
_while1_block:
  mov b, [n]
  mov [s], b
  mov b, 0
  mov [divides], b
  mov b, 2
  mov [i], b
_while2_cond:
  mov b, [i]
  push a
  mov a, b
  mov b, [s]
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while2_exit
_while2_block:
_if3_cond:
  mov b, [n]
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
  je _if3_exit
_if3_true:
  mov b, 1
  mov [divides], b
  jmp _while2_exit
  jmp _if3_exit
_if3_exit:
  mov b, [i]
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  mov [i], b
_if4_cond:
  mov b, [i]
  push a
  mov a, b
  mov b, [n]
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if4_exit
_if4_true:
  jmp _while2_exit
  jmp _if4_exit
_if4_exit:
  jmp _while2_cond
_while2_exit:
_if5_cond:
  mov b, [divides]
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
  je _if5_exit
_if5_true:
  mov b, [count]
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  mov [count], b
; --- begin inline asm block
				mov a, [n]
				call print_u16d
				mov d, newline
				mov a, [d]
				mov d, a
				call puts
			; --- end inline asm block
  jmp _if5_exit
_if5_exit:
  mov b, [n]
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  mov [n], b
  jmp _while1_cond
_while1_exit:
  leave
  ret
; --- end text block

; --- begin data block
n: .dw 0
i: .dw 0
j: .dw 0
s: .dw 0
count: .dw 0
divides: .dw 0
newline_data: .db "\n", 0
newline: .dw newline_data
prompt_data: .db "Max: ", 0
prompt: .dw prompt_data
top: .dw 0
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
