;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SHELL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MEMORY MAP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 0000		ROM BEGIN
; ....
; 7FFF		ROM END
;
; 8000		RAM begin
; ....
; F7FF		Stack root
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; I/O MAP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FF80		UART 0		(16550)
; FF90		UART 1		(16550)
; FFA0		RTC			(M48T02)
; FFB0		PIO 0		(8255)
; FFC0		PIO 1		(8255)
; FFD0		IDE			(Compact Flash / PATA)
; FFE0		Timer		(8253)
; FFF0		BIOS CONFIGURATION NV-RAM STORE AREA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SYSTEM CONSTANTS / EQUATIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TOKTYP_IDENTIFIER		.equ 0
TOKTYP_KEYWORD			.equ 1
TOKTYP_DELIMITER		.equ 2
TOKTYP_STRING			.equ 3
TOKTYP_CHAR			.equ 4
TOKTYP_NUMERIC			.equ 5

TOK_NULL			.equ 0
TOK_FSLASH			.equ 1
TOK_TIMES 			.equ 2
TOK_PLUS 			.equ 3
TOK_MINUS 			.equ 4
TOK_DOT				.equ 5
TOK_DDOT			.equ 6
TOK_SEMI			.equ 7
TOK_ANGLE			.equ 8

TOK_END				.equ 15


_STACK_BEGIN			.equ $F7FF				; beginning of stack

_NULL				.equ 0

	
	
.export shell_disk_buffer	
; declare RESET VECTOR. we must declare the reset vector of every new process
; so that the kernel knows where to jump when it loads the process

.dw SHELL_RESET_VECTOR


; file includes. these are functions used by the shell
.include "kernel.exp"
.include "stdio.asm"
.include "string.asm"
.include "ctype.asm"

SHELL_RESET_VECTOR:	
	mov bp, _STACK_BEGIN
	mov sp, _STACK_BEGIN

	mov d, s_welcome
	call puts
	call cmd_printdate
	
shell_L0:
	sti
	mov byte [token_str], 0			; clear token_str (so that enter doesnt repeat last shell command)
	mov al, 13
	syscall sys_fileio				; print current path
	call command_parser
	jmp shell_L0;

command_parser:
	mov d, shell_input_buff
	mov a, d
	mov [shell_buff_ptr], a
	call gets						; get command
parser_newtoken:
	call get_token					; get command into token_str
	mov di, keywords
	mov a, 0
	mov [parser_index], a		; reset keywords index
parser_L2:
	mov si, token_str
	call strcmp
	je parser_cmd_equal
parser_L2_L0:
	lea d, [di + 0]
	mov al, [d]
	cmp al, 0
	je parser_L2_L0_exit			; run through the keyword until finding NULL
	add di, 1
	jmp parser_L2_L0
parser_L2_L0_exit:
	add di, 1				; then skip NULL byte at the end 
	mov a, [parser_index]
	add a, 2
	mov [parser_index], a			; increase keywords table index
	lea d, [di + 0]
	mov al, [d]
	cmp al, 0
	je parser_cmd_not_found
	jmp parser_L2
parser_cmd_equal:
	mov a, $0D00
	syscall sys_io				; print carriage return
	mov a, [parser_index]			; get the keyword pointer
	call [a + keyword_pointers]		; execute command
	mov a, $0D00
	syscall sys_io				; print carriage return
parser_retry:
	call get_token
	mov al, [token]
	cmp al, TOK_SEMI
	je parser_newtoken
	call putback
	ret
parser_cmd_not_found:
	call cmd_exec			; execute as file/program
	jmp parser_retry		; check for more commands
	ret

parser_index: .dw 0

cmd_ps:
	call printnl
	syscall sys_list
	ret

cmd_fork:
	call printnl
	syscall sys_fork
	ret

cmd_fwb:
	syscall sys_fwb
	ret
	
cmd_fwk:
	syscall sys_fwk
	ret
	
loadcall:
	call get_token
	mov d, token_str
	call strtoint
	
	mov [addr1], a			; save address
	mov d, s_dataentry
	call puts
	mov di, a					; save destiny
	call _load_hex
	call printnl

	mov a, [addr1]			; retrieve address
	
	call a
	ret
	
addr1: .dw 0
		
;******************************************************************************

	
; ************************************************************
; GET HEX FILE
; di = destination address
; return length in bytes in C
; ************************************************************
_load_hex:
	push bp
	mov bp, sp
	push a
	push b
	push d
	push si
	push di
	sub sp, $6000				; string data block
	mov c, 0
	
	mov a, sp
	inc a
	mov d, a				; start of string data block
	call gets				; get program string
	mov si, a
__load_hex_loop:
	lodsb					; load from [SI] to AL
	cmp al, 0				; check if ASCII 0
	jz __load_hex_ret
	mov bh, al
	lodsb
	mov bl, al
	call atoi				; convert ASCII byte in B to int (to AL)
	stosb					; store AL to [DI]
	inc c
	jmp __load_hex_loop
__load_hex_ret:
	add sp, $6000
	pop di
	pop si
	pop d
	pop b
	pop a
	mov sp, bp
	pop bp
	ret

mem_dump:
	call get_token
	mov d, token_str
	call strtoint
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
	call printnl
	ret
print_ascii:
	mov a, $2000
	syscall sys_io
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
	call printnl
	mov b, d
	call print_u16x				; display row
	mov a, $3A00
	syscall sys_io
	mov a, $2000
	syscall sys_io
	jmp back

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SHELL DATA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
get_token:
	mov al, TOK_NULL
	mov [token], al				; nullify token
	mov a, [shell_buff_ptr]
	mov si, a
	mov di, token_str
skip_spaces:
	lodsb
	cmp al, $20
	je skip_spaces
	cmp al, $0D
	je skip_spaces
	cmp al, $0A
	je skip_spaces
get_tok_type:
	call isalpha				;check if is alpha
	jz is_alphanumeric
	call isnumeric			;check if is numeric
	jz is_alphanumeric
; other token types
get_token_slash:
	cmp al, '/'				; check if '/'
	jne get_token_dash
	stosb					; store '/' into token string
	mov al, 0
	stosb					; terminate token string
	mov al, TOK_FSLASH
	mov [token], al			
	mov a, si
	mov [shell_buff_ptr], a		; update pointer
	ret
get_token_dash:
	cmp al, '-'				; check if '-'
	jne get_token_semi
	stosb					; store '-' into token string
	mov al, 0
	stosb					; terminate token string
	mov al, TOK_MINUS
	mov [token], al			
	mov a, si
	mov [shell_buff_ptr], a		; update pointer
	ret
get_token_semi:
	cmp al, $3B				; check if ';'
	jne get_token_angle
	stosb					; store ';' into token string
	mov al, 0
	stosb					; terminate token string
	mov al, TOK_SEMI
	mov [token], al			
	mov a, si
	mov [shell_buff_ptr], a		; update pointer
	ret
get_token_angle:
	cmp al, $3E				; check if '>'
	jne get_token_dot
	stosb					; store ';' into token string
	mov al, 0
	stosb					; terminate token string
	mov al, TOK_ANGLE
	mov [token], al			
	mov a, si
	mov [shell_buff_ptr], a		; update pointer
	ret
get_token_dot:
	cmp al, '.'				; check if '.'
	jne get_token_skip
	stosb					; store '.' into token string
	lodsb
	cmp al, $2E
	je get_token_ddot
	sub si, 1
	mov al, 0
	stosb					; terminate token string
	mov al, TOK_DOT
	mov [token], al			
	mov a, si
	mov [shell_buff_ptr], a		; update pointer
	ret
get_token_ddot:
	stosb
	mov al, 0
	stosb
	mov al, TOK_DDOT
	mov [token], al			
	mov a, si
	mov [shell_buff_ptr], a		; update pointer
	ret
get_token_skip:
	sub si, 1
	mov a, si
	mov [shell_buff_ptr], a		; update pointer
	ret
is_alphanumeric:
	stosb
	lodsb
	call isalpha				;check if is alpha
	jz is_alphanumeric
	call isnumeric			;check if is numeric
	jz is_alphanumeric
	cmp al, $2E				; check if is '.'
	je is_alphanumeric
	mov al, 0
	stosb
	mov al, TOKTYP_IDENTIFIER
	mov [token_type], al
	sub si, 1
	mov a, si
	mov [shell_buff_ptr], a		; update pointer
	ret
	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PUT BACK TOKEN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
putback:
	push si
	mov si, token_str	
putback_loop:
	lodsb
	cmp al, 0
	je putback_end
	mov a, [shell_buff_ptr]
	dec a
	mov [shell_buff_ptr], a			; update pointer
	jmp putback_loop
putback_end:
	pop si
	ret
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IS NUMERIC
;; sets ZF according with result
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
isnumeric:
	push al
	cmp al, '0'
	jlu isnumeric_false
	cmp al, '9'
	jgu isnumeric_false
	lodflgs
	or al, %00000001
	stoflgs
	pop al
	ret
isnumeric_false:
	lodflgs
	and al, %11111110
	stoflgs
	pop al
	ret	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IS ALPHA
;; sets ZF according with result
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
isalpha:
	push al
	cmp al, '_'
	je isalpha_true
	
	call to_lower
	cmp al, 'a'
	jlu isalpha_false
	cmp al, 'z'
	jgu isalpha_false
isalpha_true:
	lodflgs
	or al, %00000001
	stoflgs
	pop al
	ret
isalpha_false:
	lodflgs
	and al, %11111110
	stoflgs
	pop al
	ret
	

	
; ********************************************************************
; DATETIME
; ********************************************************************
cmd_printdate:
	mov al, 0			; print datetime
	syscall sys_datetime
	ret
	
cmd_setdate:
	mov al, 1			; set datetime
	syscall sys_datetime	
	ret	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FILE SYSTEM DATA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; infor for : IDE SERVICES INTERRUPT
; al = option
; IDE read/write sector
; 512 bytes
; user buffer pointer in D
; AH = number of sectors
; CB = LBA bytes 3..0	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FILE SYSTEM DATA STRUCTURE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; for a directory we have the header first, followed by metadata
; header 1 sector (512 bytes)
; metadata 1 sector (512 bytes)
; HEADER ENTRIES:
; filename (64)
; parent dir LBA (2) -  to be used for faster backwards navigation...
;
; metadata entries:
; filename (24)
; attributes (1)
; LBA (2)
; size (2)
; day (1)
; month (1)
; year (1)
; packet size = 32 bytes
;
; first directory on disk is the root directory '/'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FILE SYSTEM DISK FORMATTING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; writes FST_TOTAL_SECTORS + FS_NBR_FILES disk sectors  with 0's
; this is the file system table formating
cmd_mkfs:
	mov al, 0
	syscall sys_fileio
	ret

cmd_fs_space:
	mov al, 1
	syscall sys_fileio
	call printnl
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CREATE NEW DIRECTORY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; search list for NULL name entry.
; add new directory to list
cmd_mkdir:
	call get_token
	mov d, token_str
	mov al, 2
	syscall sys_fileio
	ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; parse path
;; 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; search for given directory inside current dir
; if found, read its LBA, and switch directories
; example: cd /usr/bin/file.txt
;
cmd_cd:
	call get_token			; get dir name
	mov al, [token]			; get token
	cmp al, TOK_DDOT			; check if ".."
	jne cmd_cd_child			; is a child directory
; else we want the parent directory
	mov al, 12
	syscall sys_fileio
	ret
cmd_cd_child:
	mov d, token_str
	mov al, 3
	syscall sys_fileio
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmd_ls:	
	mov al, 4
	syscall sys_fileio
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pad string to 32 chars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; count in C
padding:
	push a
	mov a, 32
	mov b, c
	sub a, b
	mov c, a
padding_L1:
	mov ah, $20
	call putchar
	loopc padding_L1
	pop a
	ret
; file structure:
; 512 bytes header
; header used to tell whether the block is free

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CREATE NEW TEXTFILE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; search for first null block
cmd_mktxt:
	call get_token
	mov d, token_str
	mov al, 5
	syscall sys_fileio
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CREATE NEW BINARY FILE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; search for first null block
cmd_mkbin:
	call get_token
	mov d, token_str
	mov al, 6
	syscall sys_fileio
	ret

			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PWD - PRINT WORKING DIRECTORY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
cmd_pwd:
	mov al, 7
	syscall sys_fileio
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:
cmd_cat:
	call get_token
	mov al, [token]
	cmp al, TOK_ANGLE
	je cmd_cat_write
	mov d, token_str
	mov al, 8
	syscall sys_fileio
	ret
cmd_cat_write:
	call get_token
	mov d, token_str
	mov al, 5
	syscall sys_fileio
	ret
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RMDIR - remove DIR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; deletes directory  entry in the current directory's file list 
; also deletes the actual directory entry in the FST
cmd_rmdir:
	call get_token
	mov d, token_str
	mov al, 9
	syscall sys_fileio	
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RM - remove file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; frees up the data sectors for the file further down the disk
; deletes file entry in the current directory's file list 
cmd_rm:
	call get_token
	mov d, token_str
	mov al, 10
	syscall sys_fileio
	ret
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CHMOD - change file permissions
;; ex: chmod 7 <filename>
;; 1 = exec, 2 = write, 4 = read
;; we only have one digit in Sol-1 for now since we don't have users or groups
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; filename passed to the kernel in D
; permission value in A
cmd_chmod:
	call get_token				; read permission value
	mov d, token_str			; pointer to permission token string
	call strtoint				; integer in A
	and al, %00000111			; mask out garbage
	mov bl, al					; save permission in bl
	call get_token				; get filename. D already points to token_str
	mov al, 14
	syscall sys_fileio			; call kernel to set permission
	ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mv - move / change file name
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmd_mv:
	;mov si, d
	;mov di, userspace_data
	;mov c, 256
	;load					; load data from user-space

	;mov a, [current_dir_LBA]
	;inc a				; metadata sector
	;mov b, a
	;mov c, 0				; reset LBA to 0
	;mov a, $0102			; disk read
	;mov d, disk_buffer
	;syscall sys_ide		; read directory
	;mov a, 0
	;mov [index], a		; reset file counter
;cmd_mv_L1:
	;mov si, d
	;mov di, userspace_data
	;call strcmp
	;je cmd_mv_found_entry
;cmd_mv_no_permission:
	;add d, 32
	;mov a, [index]
	;inc a
	;mov [index], a
	;cmp a, FST_FILES_PER_DIR
	;je cmd_mv_not_found
	;jmp cmd_mv_L1
;cmd_mv_found_entry:
	;push bl
	;call get_token		; get new file name
	;mov si, userspace_data
	;mov di, d
	;call strcpy
	;mov c, 0
	;mov d, disk_buffer
	;mov a, $0103					; disk write 1 sect
	;pop bl
	;syscall sys_ide				; write sector
;cmd_mv_not_found:

	ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EXEC/OPEN PROGRAM/FILE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmd_exec:
; we read "./" sequence here
	mov al, [token]
	cmp al, TOK_DOT
	jne cmd_exec_end
	call get_token
	mov al, [token]
	cmp al, TOK_FSLASH	
	jne cmd_exec_end
	call get_token		; get filename
	mov d, token_str
	mov al, 11
	syscall sys_fileio
cmd_exec_end:
	mov a, $0D00
	syscall sys_io		; print carriage return
	ret



cmd_reboot:
	syscall sys_reboot




index:			.dw 0
buffer_addr:		.dw 0

; shell variables
token_type: 		.db 0
token:			.db 0
token_str:		.fill 256, 0
shell_input_buff:	.fill 256, 0
shell_buff_ptr:		.dw 0

; file system variables


username:	.fill 64, 0
filename:	.fill 256, 0		; holds filename for search


keywords:
	.db "mkfs", 0
	.db "ps", 0
	.db "ls", 0
	.db "cd", 0
	.db "fwb", 0
	.db "fwk", 0
	.db "fss", 0
	.db "fork", 0
	.db "dmp", 0
	.db "lc", 0
	.db "cat", 0
	.db "rm", 0
	.db "mkbin", 0
	.db "mktxt", 0
	.db "mkdir", 0
	.db "rmdir", 0
	.db "chmod", 0
	.db "mv", 0
	.db "pwd", 0
	.db "date", 0
	.db "sdate", 0
	.db "reboot", 0
	.db 0

keyword_pointers:
	.dw cmd_mkfs
	.dw cmd_ps
	.dw cmd_ls
	.dw cmd_cd
	.dw cmd_fwb
	.dw cmd_fwk
	.dw cmd_fs_space
	.dw cmd_fork
	.dw mem_dump
	.dw loadcall
	.dw cmd_cat
	.dw cmd_rm
	.dw cmd_mkbin
	.dw cmd_mktxt
	.dw cmd_mkdir
	.dw cmd_rmdir
	.dw cmd_chmod
	.dw cmd_mv
	.dw cmd_pwd
	.dw cmd_printdate
	.dw cmd_setdate
	.dw cmd_reboot

s_welcome:		.db "\n\r"
			.db "Welcome to Sol-OS ver. 0.1\n\r", 0
s_dataentry:		.db "% ", 0


shell_disk_buffer:	.db 0			; this is actually a long buffer for disk data reads/writes

.end
