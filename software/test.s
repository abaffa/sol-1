.include "kernel.exp"

.org PROC_TEXT_ORG			; origin at 1024

main:
	mov c, $ffff
loop:
	dec c
	cmp c, 0
	jg loop

	mov d, msg
	call puts
	syscall sys_terminate_proc


msg:	.db "\n\n",0

.include "token.asm"
.include "stdio.asm"
.include "ctype.asm"

.end


