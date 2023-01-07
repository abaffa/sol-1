.include "kernel.exp"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.org PROC_TEXT_ORG			; origin at 1024

cmd_fg:
	mov a, 0
	mov [prog], a			; move tokennizer pointer to the beginning of the arguments area (address 0)
	call get_token
	mov al, [tokstr]
	sub al, $30
	syscall sys_resumeproc

	syscall sys_terminate_proc


.include "token.asm"
.include "stdio.asm"
.include "ctype.asm"

.end



