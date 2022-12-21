.include "kernel.exp"

.org PROC_TEXT_ORG			; origin at 1024

cmd_echo:
	mov a, 0
	mov [prog], a			; move tokennizer pointer to the beginning of the arguments area (address 0)
	call get_arg			; read argument line
	mov d, tokstr
	call puts
	call printnl
	syscall sys_terminate_proc


.include "token.asm"
.include "stdio.asm"
.include "ctype.asm"

.end


