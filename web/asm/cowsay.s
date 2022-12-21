.include "kernel.exp"

.org PROC_TEXT_ORG			; origin at 1024

cowsay:
	call printnl
	mov a, 0
	mov [prog], a			; move tokennizer pointer to the beginning of the arguments area (address 0)
	call get_arg			; read argument line
	mov d, tokstr
	call puts
	call printnl
	mov d, cow
	call puts
	syscall sys_terminate_proc

cow: .db "    \\  ^__^\n"
     .db "     \\ (oo)\\_______\n"
     .db "       (__)\\       )\\/\\\n"
     .db "           ||----w |\n"
     .db "           ||     ||\n\n", 0

.include "token.asm"
.include "stdio.asm"
.include "ctype.asm"

.end


