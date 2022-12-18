.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; -----begin text block-----
main:
	call primes
; -----begin inline asm block-----
	syscall sys_terminate_proc
; -----end inline asm block-----
primes:
	push bp
	mov bp, sp
	mov a, 0
	mov b, 2
	mov [_var_n], b
_while1_cond:
	mov b, [_var_n]
	push a
	mov a, b
	mov b, 500
	cmp a, b
	lodflgs
	and al, %00000010
	mov ah, 0
	mov b, a
	pop a
	mov a, b
	cmp a, 0
	je _while1_exit
_while1_block:
	mov a, 0
	mov b, [_var_n]
	mov [_var_s], b
	mov a, 0
	mov b, 0
	mov [_var_divides], b
	mov a, 0
	mov b, 2
	mov [_var_i], b
_while2_cond:
	mov b, [_var_i]
	push a
	mov a, b
	mov b, [_var_s]
	cmp a, b
	lodflgs
	and al, %00000010
	mov ah, 0
	mov b, a
	pop a
	mov a, b
	cmp a, 0
	je _while2_exit
_while2_block:
_if3_cond:
	mov b, [_var_n]
	push a
	mov a, b
	mov b, [_var_i]
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
_if3_block:
	mov a, 0
	mov b, 1
	mov [_var_divides], b
	jmp _while2_exit
	jmp _if3_exit
_if3_exit:
	mov a, 0
	mov b, [_var_i]
	push a
	mov a, b
	mov b, 1
	add a, b
	mov b, a
	pop a
	mov [_var_i], b
_if4_cond:
	mov b, [_var_i]
	push a
	mov a, b
	mov b, [_var_n]
	cmp a, b
	lodflgs
	and al, %00000001
	mov ah, 0
	mov b, a
	pop a
	cmp b, 0
	je _if4_exit
_if4_block:
	jmp _while2_exit
	jmp _if4_exit
_if4_exit:
	jmp _while2_cond
_while2_exit:
_if5_cond:
	mov b, [_var_divides]
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
_if5_block:
	mov a, 0
	mov b, [_var_count]
	push a
	mov a, b
	mov b, 1
	add a, b
	mov b, a
	pop a
	mov [_var_count], b
; -----begin inline asm block-----
	mov a, [_var_n]
	call print_u16d
	mov d, _var_newline
	mov a, [d]
	mov d, a
	call puts
; -----end inline asm block-----
	jmp _if5_exit
_if5_exit:
	mov a, 0
	mov b, [_var_n]
	push a
	mov a, b
	mov b, 1
	add a, b
	mov b, a
	pop a
	mov [_var_n], b
	jmp _while1_cond
_while1_exit:
	leave
	ret

; -----end text block-----


; -----begin data block-----

_var_x: .dw 20
_var_y: .dw 5
_var_z: .dw 10
_var_n: .dw 0
_var_i: .dw 0
_var_j: .dw 0
_var_s: .dw 0
_var_count: .dw 0
_var_divides: .dw 0
_var_newline_data: .db "\n", 0
_var_newline: .dw _var_newline_data
_var_s1_data: .db "TRUE", 0
_var_s1: .dw _var_s1_data

; -----end data block-----


; -----begin include block-----

.include "lib/stdio.asm"


; -----end include block-----


.end
