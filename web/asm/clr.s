.include "kernel.exp"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.org PROC_TEXT_ORG			; origin at 1024

cmd_clear:
	mov d, s_telnet_clear
	call puts

	syscall sys_terminate_proc

s_telnet_clear:	.db 27, "[2J", 27, "[H", 0

.include "token.asm"
.include "stdio.asm"
.include "ctype.asm"

.end



