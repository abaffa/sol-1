.include "kernel.exp"

.org PROC_TEXT_ORG			; origin at 1024

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PWD - PRINT WORKING DIRECTORY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
cmd_pwd:
	mov al, 7
	syscall sys_filesystem
	syscall sys_terminate_proc


.include "token.asm"
.include "stdio.asm"
.include "ctype.asm"

.end


