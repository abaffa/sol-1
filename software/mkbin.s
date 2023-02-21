.include "kernel.exp"

.org PROC_TEXT_ORG			; origin at 1024

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CREATE NEW BINARY FILE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; search for first null block
cmd_mkbin:
	mov a, 0
	mov [prog], a
	call get_token
	mov d, s_prompt
	call puts
	mov d, tokstr
	mov al, 6
	syscall sys_fileio

	syscall sys_terminate_proc

s_prompt: .db "% ", 0

.include "token.asm"
.include "stdio.asm"
.include "ctype.asm"

.end


