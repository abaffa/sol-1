.include "kernel.exp"

.org PROC_TEXT_ORG			; origin at 1024

cmd_ps:
	syscall sys_list

	syscall sys_terminate_proc


.include "token.asm"
.include "stdio.asm"
.include "ctype.asm"

.end


