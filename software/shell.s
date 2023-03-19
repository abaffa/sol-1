.include "kernel.exp"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SHELL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SYSTEM CONSTANTS / EQUATIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STACK_BEGIN:  .equ $F7FF  ; beginning of stack

.org PROC_TEXT_ORG      ; origin at 1024

shell_main:  
  mov bp, STACK_BEGIN
  mov sp, STACK_BEGIN

  mov d, s_prompt_config
  call puts

; open config file
; example: PATH=/usr/bin;
; read PATH config entry
  mov d, s_prompt_PATH
  call puts
  mov d, s_etc_config        ; '/etc/sh.conf'
  mov si, s_PATH          ; config entry name is "PATH"
  mov di, PATH          ; config value destination is the var that holds the PATH variable
  call read_config  
  mov d, PATH
  call puts

; open config file
; read home directory config entry
  mov d, s_etc_config        ; '/etc/sh.conf'
  mov si, s_home          ; config entry name is "home"
  mov di, homedir          ; config value destination is the var that holds the home directory path
  call read_config  

  mov a, s_etc_profile
  mov [prog], a
  call cmd_ssh

shell_L0:
  mov d, s_sol1
  call puts
  mov al, 18
  syscall sys_fileio        ; print current path
  mov d, s_hash
  call puts
  mov d, shell_input_buff
  mov a, d
  mov [prog], a      ; reset tokenizer buffer pointer
  call gets            ; get command
  call cmd_parser
  jmp shell_L0

cmd_parser:
  call get_token          ; get command into tokstr
  mov di, commands
  cla
  mov [parser_index], a    ; reset commands index
parser_L0:
  mov si, tokstr
  call strcmp
  je parser_cmd_equal
parser_L0_L0:
  lea d, [di + 0]
  cmp byte[d], 0
  je parser_L0_L0_exit      ; run through the keyword until finding NULL
  add di, 1
  jmp parser_L0_L0
parser_L0_L0_exit:
  add di, 1        ; then skip NULL byte at the end 
  mov a, [parser_index]
  add a, 2
  mov [parser_index], a      ; increase commands table index
  lea d, [di + 0]
  cmp byte[d], 0
  je parser_cmd_not_found
  jmp parser_L0
parser_cmd_equal:
  mov a, $0D00
  syscall sys_io        ; print carriage return
  mov a, [parser_index]      ; get the keyword pointer
  call [a + keyword_ptrs]    ; execute command
  mov a, $0D00
  syscall sys_io        ; print carriage return
parser_retry:
  call get_token
  cmp byte[tok], TOK_SEMI
  je cmd_parser
  call putback
  ret
parser_cmd_not_found:
  call putback
  call cmd_exec      ; execute as file/program
  jmp parser_retry    ; check for more commands
  ret

; inputs:
; D = filename ptr
; SI = entry name ptr
; DI = output value string ptr
read_config:
  push di
  push si
  mov di, shell_transient_area
  mov al, 20
  syscall sys_fileio        ; read entire config file
  mov a, shell_transient_area
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
  call get_token      ; bypass '=' sign
  pop di
  mov a, [prog]
  mov si, a
read_conf_L1:
  lodsb
  cmp al, $3B        ; ';'
  je read_config_EOF_2
  stosb
  jmp read_conf_L1
read_config_EOF:
  pop di
read_config_EOF_2:
  mov al, 0
  stosb          ; terminate value with NULL
  ret

; ssh = sol shell
cmd_ssh:
  call get_path
  mov d, tokstr
  mov di, shell_transient_area
  mov al, 20
  syscall sys_fileio        ; read textfile 
  
  mov d, shell_transient_area
  mov a, d
  mov [prog], a      ; reset tokenizer buffer pointer
  call cmd_parser

  call printnl
  ret

cmd_setdate:
  mov al, 1      ; set datetime
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
; example:  cd /usr/bin; ls
;       cd /usr/bin;
;      cd /usr/bin
cmd_cd:
  call get_token
  mov al, [tok]
  cmp al, TOK_END
  je cmd_cd_gotohome
  cmp al, TOK_SEMI
  je cmd_cd_gotohome
  cmp al, TOK_TILDE
  je cmd_cd_gotohome
  call putback
  call get_path    ; get the path for the cd command
cmd_cd_syscall:
  mov d, tokstr
  mov al, 19
  syscall sys_fileio  ; get dirID in A
  cmp a, $FFFF
  je cmd_cd_fail
  mov b, a
  mov al, 3
  syscall sys_fileio  ; set dir to B
  ret
cmd_cd_gotohome:
  call putback
  mov si, homedir
  mov di, tokstr
  call strcpy
  jmp cmd_cd_syscall
cmd_cd_fail:
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
;; EXEC/OPEN PROGRAM/FILE
;; 'filename' maps to '$path/filename'
;; './file' or '/a/directory/file' loads a file directly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmd_exec:
  cmp byte[tok], TOK_END
  je cmd_exec_ret    ; check for NULL input
  call get_path    ; get file path 
  mov a, [prog]
  push a        ; save argument pointer
  mov si, tokstr
  mov di, temp_data1
  call strcpy      ; copy filename for later
  cmp byte[tokstr], '/'  ; check first character of path
  je cmd_exec_abs
  cmp byte[tokstr], '.'  ; check first character of path
  je cmd_exec_abs
  mov a, PATH
  mov [prog], a    ; set token pointer to $PATH beginning
cmd_exec_L0:
  call get_path    ; get a path option
  mov si, tokstr
  mov di, temp_data
  call strcpy      ; firstly, form address from one of the '$PATH' addresses
  mov si, s_fslash
  mov di, temp_data
  call strcat      ; add '/' in between $PATH component and filename
  mov si, temp_data1
  mov di, temp_data
  call strcat      ; now glue the given filename to the total path
  mov d, temp_data
  mov al, 21
  syscall sys_fileio  ; now we check whether such a file exists. success code is given in A. if 0, file does not exist
  cmp a, 0
  jne cmd_exec_PATH_exists
  call get_token
  cmp byte[tok], TOK_SEMI
  jne cmd_exec_L0    ; if not ';' at the end, then token must be a separator. so try another path
  jmp cmd_exec_unknown
cmd_exec_PATH_exists:
  pop a        ; retrieve token pointer which points to the arguments given
  mov [prog], a
  call get_arg    ; if however, $PATH/filename was found, then we execute it
  mov b, tokstr
  mov d, temp_data
  syscall sys_fork
  ret
cmd_exec_abs:  ; execute as absolute path
  pop a
  mov [prog], a
  call get_arg
  mov b, tokstr
  mov d, temp_data1  ;original filename
  syscall sys_fork
cmd_exec_ret:
  ret
cmd_exec_unknown:
  pop a
  ret

cmd_shutdown:
  mov al, 1
  syscall sys_IDE
  halt
  ret

cmd_reboot:
  mov d, s_rebooting
  call puts
  syscall sys_reboot

cmd_drtoggle:
  lodstat
  mov bl, al
  and bl, %11011111
  and al, %00100000
  xor al, %00100000
  or al, bl
  stostat
  
  ret

cmd_fg:
  call get_token
  mov al, [tokstr]
  sub al, $30
  syscall sys_resumeproc
  ret

commands: .db "mkfs", 0
          .db "cd", 0
          .db "sdate", 0
          .db "reboot", 0
          .db "shutdown", 0
          .db "drtoggle", 0
          .db "fg", 0
          .db "ssh", 0
          .db 0

keyword_ptrs: .dw cmd_mkfs
              .dw cmd_cd
              .dw cmd_setdate
              .dw cmd_reboot
              .dw cmd_shutdown
              .dw cmd_drtoggle
              .dw cmd_fg
              .dw cmd_ssh

homedir:    .fill 128, 0
PATH:      .fill 128, 0    ; $PATH environment variable (for now just one path)

s_etc_profile:  .db "/etc/profile", 0
s_etc_config:  .db "/etc/sh.conf", 0
s_home:      .db "home", 0
s_PATH:      .db "PATH", 0

s_prompt_homedir:  .db "\nhome directory=", 0
s_prompt_PATH:    .db "PATH=", 0
s_prompt_config:  .db "\nreading \'/etc/sh.conf\' configuration file\n", 0

s_rebooting:   .db 27, "[2J", 27, "[H", "rebooting", 0
s_dataentry:  .db "% ", 0
s_syntax_err:  .db "\nsyntax error\n", 0
s_hash:      .db " # ", 0
s_fslash:    .db "/", 0
s_sol1:      .db "Solarium:", 0, 0
; shell variables
shell_input_buff:  .fill 512, 0
shell_buff_ptr:    .dw 0
parser_index:     .dw 0

.include "stdio.asm"
.include "ctype.asm"
.include "token.asm"

temp_data1:        .fill 256, 0
temp_data:        .fill 512, 0
shell_transient_area:  ; shell transient data area

.end
