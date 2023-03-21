.include "lib/kernel.exp"

.org PROC_TEXT_ORG			; origin at 1024

cmd_hexd:
	mov a, 0
	mov [prog], a			; move tokennizer pointer to the beginning of the arguments area (address 0)
	call get_path

	mov d, tokstr
	mov di, transient_area
	mov al, 20
	syscall sys_filesystem				; read textfile into shell buffer
	mov d, transient_area

	call get_token			; read dump address
	mov d, tokstr
	call strtointx

	add a, transient_area
	mov d, a				; dump pointer in d
	mov c, 0
dump_loop:
	mov al, cl
	and al, $0F
	jz print_base
back:
	mov al, [d]				; read byte
	mov bl, al
	call print_u8x
	mov a, $2000
	syscall sys_io			; space
	mov al, cl
	and al, $0F
	cmp al, $0F
	je print_ascii
back1:
	inc d
	inc c
	cmp c, 512
	jne dump_loop
	
	mov a, $0A00
	syscall sys_io
	mov a, $0D00
	syscall sys_io
	;call printnl

	syscall sys_terminate_proc
print_ascii:
	sub d, 16
	mov b, 16
print_ascii_L:
	inc d
	mov al, [d]				; read byte
	cmp al, $20
	jlu dot
	cmp al, $7E
	jleu ascii
dot:
	mov a, $2E00
	syscall sys_io
	jmp ascii_continue
ascii:
	mov ah, al
	mov al, 0
	syscall sys_io
ascii_continue:
	loopb print_ascii_L
	jmp back1
print_base:
	mov a, $0A00
	syscall sys_io
	mov a, $0D00
	syscall sys_io
	mov b, d
	sub b, transient_area
	call print_u16x				; display row
	add b, transient_area
	mov a, $2000
	syscall sys_io
	jmp back

	syscall sys_terminate_proc

.include "lib/token.asm"
.include "lib/stdio.asm"
.include "lib/ctype.asm"

transient_area:	

.end



	
