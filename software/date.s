.include "kernel.exp"

.org PROC_TEXT_ORG			; origin at 1024

; ********************************************************************
; DATETIME
; ********************************************************************
cmd_printdate:
	mov al, 0			; print datetime
	syscall sys_datetime

	syscall sys_terminate_proc



.end


