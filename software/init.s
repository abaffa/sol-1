.include "kernel.exp"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SHELL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SYSTEM CONSTANTS / EQUATIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STACK_BEGIN:	.equ $F7FF	; beginning of stack

.org PROC_TEXT_ORG			; origin at 1024

shell_main:	
	mov bp, STACK_BEGIN
	mov sp, STACK_BEGIN

	mov d, s_prompt_init
	call puts

	mov d, s_prompt_shell
	call puts
	mov d, s_shell_path
	syscall sys_fork

s_shell_path:	.db "/usr/bin/sh", 0

s_prompt_shell:	.db "launching a shell session...\n\r", 0

s_prompt_init:	.db "init started\n\r", 0

.include "stdio.asm"

.end
