;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; sol-1 assembler
;
; label1:
; mov a, $FF
; mov b, 21
; mov a, b
; mov a, label2
; jmp label2
; mov a, 1
; mov b, 22
; label2:
; mov b, a
; jmp label1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.include "kernel.exp"

.org PROC_TEXT_ORG			; origin at 1024

asm_main:
	mov sp, $FFFF
	mov bp, $FFFF

	mov a, program_buffer
	mov [prog], a
pre_scan:
	call get_token
	mov al, [tok]
	cmp al, TOK_END
	je pre_scan_end
	mov a, [prog]
	mov d, a
	mov al, [d]
	cmp al, $3A 
	je pre_scan_is_label
	call find_EOL
	jmp pre_scan
pre_scan_is_label:
	mov d, tokstr
	call puts
	call printnl
	call get_token
	jmp pre_scan
pre_scan_end:
	syscall sys_terminate_proc

find_EOL:
	mov a, [prog]
	mov si, a
find_EOL_L0:
	lodsb
	cmp al, $0A
	jne find_EOL_L0
	mov a, si
	mov [prog], a
	ret

mnemonic_tab:
	.db "mov a, @", 0
	.db "mov a, b", 0

	.db "mov b, @", 0
	.db "mov b, a", 0

	.db "jmp @", 0
	.db "jmp a", 0

	.db 0

instr_length_tab:
	.db 3
	.db 1

	.db 3
	.db 1
	
	.db 3
	.db 1

opcode_tab:
	.db "10", 0
	.db "11", 0

	.db "26", 0
	.db "27", 0

	.db "0A", 0
	.db "0B", 0

.include "stdio.asm"
.include "ctype.asm"
.include "token.asm"

;label_tab:		.fill 32 * 64, 0		; 64 labels of 32 chars each
;label_addr_tab:	.fill 2 * 64, 0			; 64 words

;output_buffer:	.fill 64		; 4KB for now
program_buffer:	.db "mov a, 23\nmov b, a\nlabel1:\n"
				.db "mov a, b\nmov b, 45\njmp label2\n"
				.db "label2:\nmov a, 34\njmp label1\n\n", 0

temp_tokstr: .fill 64, 0

.end

