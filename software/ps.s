.include "lib/kernel.exp"

.org PROC_TEXT_ORG			; origin at 1024

cmd_ps:
	syscall sys_list

	syscall sys_terminate_proc


.include "lib/token.asm"
.include "lib/stdio.asm"
.include "lib/ctype.asm"

.end


