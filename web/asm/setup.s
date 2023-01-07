.include "kernel.exp"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.org PROC_TEXT_ORG			; origin at 1024

; 1) read /etc/boot.conf to find kernel filename
; 2) from filename, obtain LBA address of kernel file
; 3) write LBA address to bootloader sector, at address 1FF (511)

bootloader_installer:
; open /etc/boot.conf file
; read image config entry
	mov d, s_etc_bootconf			; '/etc/boot.conf'
	mov si, s_image					; config entry name is "image"
	mov di, kernel_filename		
	call read_config
	
	mov d, kernel_filename
	call puts
	call printnl
	
	mov d, kernel_filename
	mov al, 19
	syscall sys_fileio		; obtain dirID for kernel file, in A
	inc a					; increment LBA because data starts after the header sector
	mov b, a
	call print_u16x
	syscall sys_boot_install

	call printnl
	syscall sys_terminate_proc

; inputs:
; D = filename ptr
; SI = entry name ptr
; DI = output value string ptr
read_config:
	push di
	push si
	mov di, transient_area
	mov al, 20
	syscall sys_fileio				; read entire config file
	mov a, transient_area
	mov [prog], a
	pop si
read_config_L0:
	call get_token
	cmp byte[tok], TOK_END
	je read_config_EOF
	mov di, tokstr
	call strcmp
	je read_config_found_entry
read_config_L0_L0:
	call get_token
	cmp byte[tok], TOK_SEMI
	je read_config_L0
	jmp read_config_L0_L0
read_config_found_entry:
	call get_token			; bypass '=' sign
	pop di
	mov a, [prog]
	mov si, a
read_conf_L1:
	lodsb
	cmp al, $3B				; ';'
	je read_config_EOF_2
	stosb
	jmp read_conf_L1
read_config_EOF:
	pop di
read_config_EOF_2:
	mov al, 0
	stosb					; terminate value with NULL
	ret

s_etc_bootconf:		.db "/etc/boot.conf", 0
s_image:			.db "image", 0
kernel_filename:	.fill 64, 0

.include "token.asm"
.include "stdio.asm"
.include "ctype.asm"

transient_area:

.end



