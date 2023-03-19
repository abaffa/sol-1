.include "kernel.exp"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ls /usr/bin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.org PROC_TEXT_ORG			; origin at 1024

cmd_ls:
	mov a, 0
	mov [prog], a			; move tokennizer pointer to the beginning of the arguments area (address 0)
	call get_token
	mov al, [tok]
	cmp al, TOK_END
	je cmd_ls_current
cmd_ls_arg_given:
	call putback
	call get_path
	mov d, tokstr
	mov al, 19
	syscall sys_filesystem	; get dirID in A
	mov b, a
	mov al, 4
	syscall sys_filesystem
	syscall sys_terminate_proc
cmd_ls_current:
	mov al, 17
	syscall sys_filesystem		; get current dirID in B
	mov al, 4
	syscall sys_filesystem

	syscall sys_terminate_proc


.include "token.asm"
.include "stdio.asm"
.include "ctype.asm"

.end



