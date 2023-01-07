.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; -----begin text block-----
main:
	mov a, 0
	mov b, 50
	mov [_var_i], b
	mov a, 0
	mov b, 100
	mov [_var_j], b
; -----begin inline asm block-----
	syscall sys_terminate_proc
; -----end inline asm block-----
test:
	push bp
	mov bp, sp
	push word 0
	mov b, [_var_i]
	push a
	mov a, b
	mov b, [_var_j]
	add a, b
	mov b, a
	pop a
	leave
	ret

; -----end text block-----


; -----begin data block-----

_var_i: .dw 0
_var_j: .dw 0

; -----end data block-----


; -----begin include block-----

.include "lib/stdio.asm"


; -----end include block-----


.end
