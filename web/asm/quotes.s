.include "kernel.exp"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.org PROC_TEXT_ORG			; origin at 1024

cmd_quotes:
	mov ah, $FF
	call putchar
	
	call printnl
	syscall sys_terminate_proc

.include "token.asm"
.include "stdio.asm"
.include "ctype.asm"


transient_area:	

.end


