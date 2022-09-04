;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.include "kernel.exp"

.org PROC_TEXT_ORG			; origin at 1024

main:
	mov a, $55
	cmp a, $55
	je stage1_pass1
stage1_fail1:
	
stage1_pass1:
	mov a, $aa
	cmp a, $aa
	je stage1_pass2
stage1_fail2:
	
stage1_pass2:


.include "stdio.asm"
.include "ctype.asm"
.include "token.asm"


.end

