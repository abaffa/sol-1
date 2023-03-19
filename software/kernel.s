;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MEMORY MAP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 0000    ROM BEGIN
; ....
; 7FFF    ROM END
;
; 8000    RAM begin
; ....
; F7FF    Stack root
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; I/O MAP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FF80    UART 0    (16550)
; FF90    UART 1    (16550)
; FFA0    RTC    (M48T02)
; FFB0    PIO 0    (8255)
; FFC0    PIO 1    (8255)
; FFD0    IDE    (Compact Flash / PATA)
; FFE0    Timer    (8253)
; FFF0    BIOS CONFIGURATION NV-RAM STORE AREA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SYSTEM CONSTANTS / EQUATIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_UART0_DATA      	.equ $FF80        ; data
_UART0_DLAB_0    	.equ $FF80        ; divisor latch low byte
_UART0_DLAB_1    	.equ $FF81        ; divisor latch high byte
_UART0_IER      	.equ $FF81        ; Interrupt enable register
_UART0_FCR      	.equ $FF82        ; FIFO control register
_UART0_LCR      	.equ $FF83        ; line control register
_UART0_LSR      	.equ $FF85        ; line status register

_ide_BASE        	.equ $FFD0        ; IDE BASE
_ide_R0           .equ _ide_BASE + 0    ; DATA PORT
_ide_R1           .equ _ide_BASE + 1    ; READ: ERROR CODE, WRITE: FEATURE
_ide_R2           .equ _ide_BASE + 2    ; NUMBER OF SECTORS TO TRANSFER
_ide_R3           .equ _ide_BASE + 3    ; SECTOR ADDRESS LBA 0 [0:7]
_ide_R4           .equ _ide_BASE + 4    ; SECTOR ADDRESS LBA 1 [8:15]
_ide_R5           .equ _ide_BASE + 5    ; SECTOR ADDRESS LBA 2 [16:23]
_ide_R6           .equ _ide_BASE + 6    ; SECTOR ADDRESS LBA 3 [24:27 (LSB)]
_ide_R7           .equ _ide_BASE + 7    ; READ: STATUS, WRITE: COMMAND

_7SEG_DISPLAY    	.equ $FFB0        ; BIOS POST CODE HEX DISPLAY (2 DIGITS)
_BIOS_POST_CTRL  	.equ $FFB3        ; BIOS POST DISPLAY CONTROL REGISTER, 80h = As Output
_PIO_A          	.equ $FFB0    
_PIO_B          	.equ $FFB1
_PIO_C          	.equ $FFB2
_PIO_CONTROL    	.equ $FFB3        ; PIO CONTROL PORT

_TIMER_C_0      	.equ $FFE0        ; TIMER COUNTER 0
_TIMER_C_1      	.equ $FFE1        ; TIMER COUNTER 1
_TIMER_C_2      	.equ $FFE2        ; TIMER COUNTER 2
_TIMER_CTRL      	.equ $FFE3        ; TIMER CONTROL REGISTER

STACK_BEGIN      	.equ $F7FF        ; beginning of stack
FIFO_SIZE        	.equ (1024*2)

PROC_TEXT_ORG   	.equ $400
NULL            	.equ 0


; for the next iteration:
; boot-sector(1) | kernel-sectors(32) | inode-bitmap | rawdata-bitmap | inode-table | raw-disk-data
;
; inode-table format:
;  file-type(f, d)
;  permissons
;  link-count
;  filesize
;  time-stamps
;  15 data block pointers
;  single-indirect pointer
;

; for now:
; boot-sector(1) | kernel-sectors(32) | rawdata-bitmap() | raw-disk-data
;
; filename (24)
; attributes (1)       :|0|0|file_type(3bits)|x|w|r|
; LBA (2)          : location of raw data for file entry, or dirID for directory entry
; size (2)          : filesize
; day (1)           
; month (1)
; year (1)
; packet size = 32 bytes  : total packet size in bytes
;
FST_ENTRY_SIZE        	.equ 32
FST_FILES_PER_SECT    	.equ (512 / FST_ENTRY_SIZE)
FST_FILES_PER_DIR      	.equ 16
FST_NBR_DIRECTORIES    	.equ 64
            ; 1 sector for header, the rest is for the list of files/dirs
FST_SECTORS_PER_DIR    	.equ (1 + (FST_ENTRY_SIZE * FST_FILES_PER_DIR / 512))    
FST_TOTAL_SECTORS      	.equ (FST_SECTORS_PER_DIR * FST_NBR_DIRECTORIES)
FST_LBA_START          	.equ 32
FST_LBA_END            	.equ (FST_LBA_START + FST_TOTAL_SECTORS - 1)

FS_NBR_FILES           	.equ (FST_NBR_DIRECTORIES * FST_FILES_PER_DIR)
FS_SECTORS_PER_FILE    	.equ 32        ; the first sector is always a header with a NULL parameter (first byte)
                      ; so that we know which blocks are free or taken
FS_FILE_SIZE          	.equ (FS_SECTORS_PER_FILE * 512)                  
FS_TOTAL_SECTORS      	.equ (FS_NBR_FILES * FS_SECTORS_PER_FILE)
FS_LBA_START          	.equ (FST_LBA_END + 1)
FS_LBA_END            	.equ (FS_LBA_START + FS_NBR_FILES - 1)

CF_CARD_LBA_SIZE    		.equ $800      ; temporary small size

ROOT_dirID:        			.equ FST_LBA_START

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GLOBAL SYSTEM VARIABLES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; EXTERNAL INTERRUPT TABLE
; highest priority at lowest address
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.dw int_0
.dw int_1
.dw int_2
.dw int_3
.dw int_4
.dw int_5
.dw int_6
.dw int_7

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; RESET VECTOR DECLARATION
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.dw kernel_reset_vector

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EXCEPTION VECTOR TABLE
;; total of 7 entries, starting at address $0012
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.dw trap_privilege
.dw trap_div_zero
.dw undefined_opcode
.dw NULL
.dw NULL
.dw NULL
.dw NULL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SYSTEM CALL VECTOR TABLE
;; starts at address $0020
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.dw trap_breakpoint
.dw rtc_services
.dw ide_services
.dw io_services
.dw file_system
.dw cmd_fork
.dw list_procs
.dw datetime_services
.dw syscall_reboot
.dw cmd_pause_proc
.dw resume_proc
.dw cmd_terminate_proc
.dw cmd_system
.dw cmd_boot_installer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FILE INCLUDES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.include "bios.exp"  ; to obtain the BIOS_RESET_VECTOR location (for reboots)
.include "stdio.asm"
.include "ctype.asm"
.include "token.asm"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

sys_bkpt      			.equ 0
sys_rtc        			.equ 1
sys_ide        			.equ 2
sys_io        			.equ 3
sys_filesystem  		.equ 4
sys_fork      			.equ 5
sys_list      			.equ 6
sys_datetime    		.equ 7
sys_reboot      		.equ 8
sys_pause_proc  		.equ 9
sys_resume_proc    	.equ 10
sys_terminate_proc  .equ 11
sys_system      		.equ 12
sys_boot_install  	.equ 13

.export PROC_TEXT_ORG
.export sys_bkpt
.export sys_ide
.export sys_io
.export sys_filesystem
.export sys_fork
.export sys_list
.export sys_rtc
.export sys_datetime
.export sys_reboot
.export sys_pause_proc
.export sys_resume_proc
.export sys_terminate_proc
.export sys_system
.export sys_boot_install

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; EXTERNAL INTERRUPTS' CODE BLOCK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; uart
int_0:
  sysret
int_1:
  sysret
int_2:
  sysret
int_3:
  sysret
int_4:
  sysret
int_5:
  sysret
int_6:  
; save all registers into kernel stack
  pusha
  mov ah, 0
  mov al, [active_proc_index]
  shl a              ; x2
  mov a, [proc_table_convert + a]  ; get process state start index
    
  mov di, a
  mov a, sp
  inc a
  mov si, a
  mov c, 20
  rep movsb          ; save process state!
; restore kernel stack position to point before interrupt arrived
  add sp, 20
; now load next process in queue
  mov al, [active_proc_index]
  mov bl, [nbr_active_procs]
  cmp al, bl
  je int6_cycle_back
  inc al            ; next process is next in the series
  jmp int6_continue
int6_cycle_back:
  mov al, 1        ; next process = process 1
int6_continue:
  mov [active_proc_index], al    ; set next active proc

; calculate LUT entry for next process
  mov ah, 0
  shl a              ; x2
  mov a, [proc_table_convert + a]    ; get process state start index  
  
  mov si, a            ; source is proc state block
  mov a, sp
  sub a, 19
  mov di, a            ; destination is kernel stack
; restore SP
  dec a
  mov sp, a
  mov c, 20
  rep movsb
; set VM process
  mov al, [active_proc_index]
  setptb
    
  mov byte[_TIMER_C_0], 0        ; load counter 0 low byte
  mov byte[_TIMER_C_0], $10        ; load counter 0 high byte
      
  popa
  sysret

int_7:
  push a
  push d
  pushf
      
  mov a, [fifo_pi]
  mov d, a

  mov al, [_UART0_DATA]  ; get character
  cmp al, $03        ; CTRL-C
  je CTRLC
  cmp al, $1A        ; CTRL-Z
  je CTRLZ
  mov [d], al        ; add to fifo
  
  mov a, [fifo_pi]
  inc a
  cmp a, fifo + FIFO_SIZE         ; check if pointer reached the end of the fifo
  jne int_7_continue
  mov a, fifo  
int_7_continue:  
  mov [fifo_pi], a      ; update fifo pointer
  
  popf
  pop d
  pop a  
  sysret

CTRLC:
  popf
  pop d
  pop a
  jmp cmd_terminate_proc

CTRLZ:
  popf
  pop d
  pop a
  jmp cmd_pause_proc    ; pause current process and go back to the shell

cmd_system_jmptbl:
  .dw cmd_system_uname
  .dw cmd_system_whoami

cmd_system:
  jmp [cmd_system_jmptbl + al]
cmd_system_uname:
  mov d, s_uname
  call puts
  sysret
cmd_system_whoami:
  mov d, s_root
  call puts
  sysret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; REBOOT SYSTEM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
syscall_reboot:
  push word $FFFF 
  push byte %00000000        ; dma_ack = 0, interrupts disabled, mode = supervisor, paging = off, halt=0, display_reg_load=0, dir=0
  push word BIOS_RESET_VECTOR    ; and then push RESET VECTOR of the shell to the stack
  sysret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; switch to another process
;; inputs:
;; AL = new process number
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
resume_proc:
  mov g, a  ; save the process number
; save all registers into kernel stack
  pusha
  mov ah, 0
  mov al, [active_proc_index]
  shl a              ; x2
  mov a, [proc_table_convert + a]  ; get process state start index
  mov di, a
  mov a, sp
  inc a
  mov si, a
  mov c, 20
  rep movsb          ; save process state!
; restore kernel stack position to point before interrupt arrived
  add sp, 20
; now load the new process number!
  mov a, g            ; retrieve the process number argument that was saved in the beginning
  mov [active_proc_index], al    ; set new active proc
; calculate LUT entry for next process
  mov ah, 0
  shl a              ; x2
  mov a, [proc_table_convert + a]    ; get process state start index  
  
  mov si, a            ; source is proc state block
  mov a, sp
  sub a, 19
  mov di, a            ; destination is kernel stack
; restore SP
  dec a
  mov sp, a
  mov c, 20
  rep movsb
; set VM process
  mov al, [active_proc_index]
  setptb
      
  popa
  sysret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
list_procs:
  mov d, s_ps_header
  call puts
  mov d, proc_availab_table + 1
  mov c, 1
list_procs_L0:  
  cmp byte[d], 1
  jne list_procs_next
  mov b, d
  sub b, proc_availab_table
  shl b, 5
  push d
  push b
  mov b, c
  call print_u8x
  mov ah, ' '
  call putchar
  call putchar
  pop b
  mov d, b
  add d, proc_names
  call puts
  call printnl
  pop d
list_procs_next:
  inc d
  inc c
  cmp c, 9
  jne list_procs_L0
list_procs_end:
  sysret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PRIVILEGE EXCEPTION
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
trap_privilege:
  jmp syscall_reboot
  push d

  mov d, s_priviledge
  call puts

  pop d
  
  sysret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; BREAKPOINT EXCEPTION
; IMPORTANT: values in the stack are being pushed in big endian. i.e.: MSB at low address
; and LSB at high address. *** NEED TO CORRECT THIS IN THE MICROCODE and make it little endian again ***
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
trap_breakpoint:
  pusha
trap_break_prompt:
  mov d, s_break1
  call puts
  call printnl
  call scan_u16d
  cmp a, 0
  je trap_break_regs
  cmp a, 1
  je trap_break_mem
trap_break_end:  
  popa
  sysret
trap_break_regs:
  mov a, sp
  add a, 14  ; back-track 7 registers
  mov d, a
  mov cl, 7
trap_regs_L0:
  mov b, [d]
  swp b
  call print_u16x  ; print register value
  call printnl
  sub d, 2
  sub cl, 1
  cmp cl, 0
  jne trap_regs_L0
  jmp trap_break_prompt
  call printnl
  jmp trap_break_prompt
trap_break_mem:
  call printnl
  call scan_u16x
  mov si, a      ; data source from user space
  mov di, scrap_sector    ; destination in kernel space
  mov c, 512
  load        ; transfer data to kernel space!
  mov d, scrap_sector    ; dump pointer in d
  mov c, 0
dump_loop:
  mov al, cl
  and al, $0F
  jz print_base
back:
  mov al, [d]        ; read byte
  mov bl, al
  call print_u8x
  mov a, $2000
  syscall sys_io      ; space
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
  jmp trap_break_prompt  ; go to trap_breakpoint return point
print_ascii:
  mov a, $2000
  syscall sys_io
  sub d, 16
  mov b, 16
print_ascii_L:
  inc d
  mov al, [d]        ; read byte
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
  sub b, scrap_sector      ; remove this later and fix address bases which display incorrectly
  call print_u16x        ; display row
  mov a, $3A00
  syscall sys_io
  mov a, $2000
  syscall sys_io
  jmp back

s_break1:  .db "\nDebugger entry point.\n"
      .db "0. Show Registers\n"
      .db "1. Show 512B RAM block\n"
      .db "2. Continue Execution", 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DIVIDE BY ZERO EXCEPTION
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
trap_div_zero:
  push a
  push d
  pushf
    
  mov d, s_divzero
  call puts
  
  popf
  pop d
  pop a
              ; enable interrupts
  sysret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UNDEFINED OPCODE EXCEPTION
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undefined_opcode:
  sysret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; RTC SERVICES INTERRUPT
; RTC I/O bank = FFA0 to FFAF
; FFA0 to FFA7 is scratch RAM
; control register at $FFA8 [ W | R | S | Cal4..Cal0 ]
; al = 0..6 -> get
; al = 7..D -> set
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
rtc_services:
  push al
  push d
  cmp al, 6
  jgu rtc_set
rtc_get:
  add al, $A9      ; generate RTC address to get to address A9 of clock
  mov ah, $FF    
  mov d, a        ; get to FFA9 + offset
  mov byte[$FFA8], $40    ; set R bit to 1
  mov al, [d]      ; get data
  mov byte[$FFA8], 0    ; reset R bit
  mov ah, al
  pop d
  pop al
  sysret
rtc_set:
  push bl
  mov bl, ah    ; set data asIDE
  add al, $A2    ; generate RTC address to get to address A9 of clock
  mov ah, $FF    
  mov d, a    ; get to FFA9 + offset
  mov al, bl    ; get data back
  mov byte[$FFA8], $80  ; set W bit to 1
  mov [d], al    ; set data
  mov byte[$FFA8], 0    ; reset write bit
  pop bl
  pop d
  pop al
  sysret

datetime_serv_tbl:
  .dw print_date
  .dw set_date
datetime_services:
  jmp [datetime_serv_tbl + al]      
print_date:
  mov a, $0D00        ; print carriage return char
  mov al, 3
  syscall sys_rtc        ; get week
  mov al, ah
  mov ah, 0
  shl a, 2          
  mov d, s_week
  add d, a
  call puts
  mov a, $2000
  syscall sys_io          ; display ' '
  
  mov al, 4
  syscall sys_rtc          ; get day
  mov bl, ah
  call print_u8x
  mov a, $2000
  syscall sys_io          ; display ' '
; there is a problem with the month displaying
; the month is stored as BCD. so when retrieving the month, the value will be in binary
; even though it is to be understood as BCD.
; when retrieving the value and adding the string table address offset the value will go overboard!  
  mov al, 05
  syscall sys_rtc        ; get month
  mov al, ah
  mov ah, 0
  shl a, 2          
  mov d, s_months
  add d, a
  call puts
  
  mov a, $2000
  syscall sys_io      ; display ' '
  
  mov bl, $20
  call print_u8x      ; print 20 for year prefix
  mov al, 06
  syscall sys_rtc          ; get year
  mov bl, ah
  call print_u8x
  
  mov a, $2000  
  syscall sys_io      ; display ' '

  mov al, 2
  syscall sys_rtc          ; get hours
  mov bl, ah
  call print_u8x
  mov a, $3A00    
  syscall sys_io        ; display ':'

  mov al, 01
  syscall sys_rtc          ; get minutes
  mov bl, ah
  call print_u8x
  mov a, $3A00  
  syscall sys_io      ; display ':'

  mov al, 0
  syscall sys_rtc          ; get seconds
  mov bl, ah
  call print_u8x
  
  call printnl
  sysret
  
set_date:
  mov d, s_set_year
  call puts
  call scan_u8x        ; read integer into A
  shl a, 8        ; only AL used, move to AH
  mov al, 0Dh        ; set RTC year
  syscall sys_rtc          ; set RTC
  
  mov d, s_set_month
  call puts
  call scan_u8x          ; read integer into A
  shl a, 8        ; only AL used, move to AH
  mov al, 0Ch        ; set RTC month
  syscall sys_rtc          ; set RTC

  mov d, s_set_day
  call puts
  call scan_u8x          ; read integer into A
  shl a, 8        ; only AL used, move to AH
  mov al, 0Bh        ; set RTC month
  syscall sys_rtc          ; set RTC

  mov d, s_set_week
  call puts
  call scan_u8x          ; read integer into A
  shl a, 8        ; only AL used, move to AH
  mov al, 0Ah        ; set RTC month
  syscall sys_rtc          ; set RTC

  mov d, s_set_hours
  call puts
  call scan_u8x          ; read integer into A
  shl a, 8        ; only AL used, move to AH
  mov al, 09h        ; set RTC month
  syscall sys_rtc          ; set RTC

  mov d, s_set_minutes
  call puts
  call scan_u8x          ; read integer into A
  shl a, 8        ; only AL used, move to AH
  mov al, 08h        ; set RTC month
  syscall sys_rtc          ; set RTC

  mov d, s_set_seconds
  call puts
  call scan_u8x          ; read integer into A
  shl a, 8          ; only AL used, move to AH
  mov al, 07h        ; set RTC month
  syscall sys_rtc          ; set RTC
  sysret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; IDE SERVICES INTERRUPT
; al = option
; 0 = IDE reset, 1 = IDE sleep, 2 = read sector, 3 = write sector
; IDE read/write sector
; 512 bytes
; user buffer pointer in D
; AH = number of sectors
; CB = LBA bytes 3..0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ide_serv_tbl:
  .dw ide_reset
  .dw ide_sleep
  .dw ide_read_sect_wrapper
  .dw ide_write_sect_wrapper
ide_services:
  jmp [ide_serv_tbl + al]    
  
ide_reset:      
  mov byte[_ide_R7], 4    ; RESET IDE
  call ide_wait        ; wait for IDE ready             
  mov byte[_ide_R6], $E0    ; LBA3= 0, MASTER, MODE= LBA        
  mov byte[_ide_R1], 1    ; 8-BIT TRANSFERS      
  mov byte[_ide_R7], $EF    ; SET FEATURE COMMAND
  sysret
ide_sleep:
  call ide_wait          ; wait for IDE ready             
  mov byte [_ide_R6], %01000000  ; lba[3:0](reserved), bit 6=1
  mov byte [_ide_R7], $E6    ; sleep command
  call ide_wait          ; wait for IDE ready
  sysret
ide_read_sect_wrapper:
  call ide_read_sect
  sysret
ide_write_sect_wrapper:
  call ide_write_sect
  sysret
ide_read_sect:
  mov al, ah
  mov ah, bl
  mov [_ide_R2], a      ; number of sectors (0..255)
  mov al, bh
  mov [_ide_R4], al
  mov a, c
  mov [_ide_R5], al
  mov al, ah
  and al, %00001111
  or al, %11100000      ; mode lba, master
  mov [_ide_R6], al
ide_read_sect_wait:
  mov al, [_ide_R7]  
  and al, $80        ; BUSY FLAG
  jnz ide_read_sect_wait
  mov al, $20
  mov [_ide_R7], al      ; read sector cmd
  call ide_read  
  ret
ide_write_sect:
  mov al, ah
  mov ah, bl
  mov [_ide_R2], a      ; number of sectors (0..255)
  mov al, bh
  mov [_ide_R4], al
  mov a, c
  mov [_ide_R5], al
  mov al, ah
  and al, %00001111
  or al, %11100000      ; mode lba, master
  mov [_ide_R6], al
ide_write_sect_wait:
  mov al, [_ide_R7]  
  and al, $80        ; BUSY FLAG
  jnz ide_write_sect_wait
  mov al, $30
  mov [_ide_R7], al      ; write sector cmd
  call ide_write      
  ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; READ IDE DATA
; pointer in D
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ide_read:
  push d
ide_read_loop:
  mov al, [_ide_R7]  
  and al, 80h        ; BUSY FLAG
  jnz ide_read_loop      ; wait loop
  
  mov al, [_ide_R7]
  and al, %00001000      ; DRQ FLAG
  jz ide_read_end
  mov al, [_ide_R0]
  mov [d], al
  inc d
  jmp ide_read_loop
ide_read_end:
  pop d
  ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; WRITE IDE DATA
; data pointer in D
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ide_write:
  push d
ide_write_loop:
  mov al, [_ide_R7]  
  and al, 80h        ; BUSY FLAG
  jnz ide_write_loop      ; wait loop
  
  mov al, [_ide_R7]
  and al, %00001000      ; DRQ FLAG
  jz ide_write_end
  mov al, [d]
  mov [_ide_R0], al
  inc d 
  jmp ide_write_loop
ide_write_end:
  pop d
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; wait for IDE to be ready
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ide_wait:
  mov al, [_ide_R7]  
  and al, 80h        ; BUSY FLAG
  jnz ide_wait
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; i/o interrupt
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
io_services_jmp:
  .dw io_putchar
  .dw io_getchar
  .dw io_uart_init

io_services:
  jmp [io_services_jmp + al]
io_uart_init:
  mov byte[_UART0_LCR], $83      ; 8 data, 1 stop, no parity  , divisor latch = 1, UART address 3 = Line Control Register
  mov byte[_UART0_DLAB_0], 3      ; baud = 38400, divisor latch low byte = 3
  mov byte[_UART0_DLAB_1], 0      ; divisor latch high byte = 0      
  mov byte[_UART0_LCR], 3      ; UART address 3 = Line Control Register
  mov byte[_UART0_IER], 1      ; enable interrupt: receive data available
  mov byte[_UART0_FCR], 0      ; disable FIFO
  sysret
; char in ah
io_putchar:
io_putchar_L0:
  mov al, [_UART0_LSR]      ; read Line Status Register
  test al, $20          ; isolate Transmitter Empty
  jz io_putchar_L0    
  mov al, ah
  mov [_UART0_DATA], al      ; write char to Transmitter Holding Register
  sysret
; char in ah
; al = sucess code
io_getchar:
  push b
  push d
io_getchar_L0:  
  mov a, [fifo_pr]
  mov b, [fifo_pi]
  cmp a, b
  je io_getchar_fail
  
  mov d, a
  mov al, [d]
  push al
  
  mov a, [fifo_pr]
  inc a
  cmp a, fifo + FIFO_SIZE        ; check if pointer reached the end of the fifo
  jne io_getchar_cont
  mov a, fifo  
io_getchar_cont:  
  mov [fifo_pr], a      ; update fifo pointer
  
  pop ah
; here we just echo the char back to the console
io_getchar_echo_L0:
  mov al, [_UART0_LSR]      ; read Line Status Register
  test al, $20          ; isolate Transmitter Empty
  jz io_getchar_echo_L0
  mov al, ah
  mov [_UART0_DATA], al      ; write char to Transmitter Holding Register

  mov al, 1    ; AL = 1 means a char successfully received
  pop d
  pop b
  sysret
io_getchar_fail:
  pop d
  pop b
  mov al, 0      ; AL = 0 means no char received
  sysret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FILE SYSTEM DATA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; infor for : IDE SERVICES INTERRUPT
; IDE read/write 512-byte sector
; al = option
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
; attributes (1)  |_|_|file_type(3bits)|x|w|r| types: file, directory, character device
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
file_system_jmptbl:
  .dw file_system_mkfs
  .dw cmd_fs_space
  .dw cmd_mkdir
  .dw cmd_cd
  .dw cmd_ls
  .dw cmd_mktxt
  .dw cmd_mkbin
  .dw cmd_pwd
  .dw cmd_cat
  .dw cmd_rmdir          ; 9
  .dw cmd_rm
  .dw 0
  .dw 0
  .dw 0              ; 13
  .dw fileio_chmod        ; 14
  .dw cmd_mv            ; 15
  .dw cd_goto_root        ; 16
  .dw get_current_dirID      ; 17
  .dw get_path_from_dirID      ; 18
  .dw get_dirID_from_path_user  ; 19
  .dw loadfile_from_path_user    ; 20  
  .dw file_exists_by_path_user  ; 21
file_system:
  jmp [file_system_jmptbl + al]

file_system_mkfs:  
  mov di, transient_area
  mov al, 0
  mov c, 512
  rep stosb
  mov b, FST_LBA_START
  mov c, 0        ; reset LBA to 0
file_system_mkfs_L1:  
  mov ah, $01      ; one sect
  mov d, transient_area
  call ide_write_sect
  inc b
  cmp b, CF_CARD_LBA_SIZE
  jne file_system_mkfs_L1
file_system_mkfs_create_root:
  mov a, ROOT_dirID
  mov [current_dirID], a    ; set current directory LBA to ROOT
  sysret  
  
cd_goto_root:
  mov a, ROOT_dirID
  mov [current_dirID], a    ; set current directory LBA to ROOT
  sysret  

; filename in D (userspace data)
; permission in BL
fileio_chmod:
  push bl
  mov si, d
  mov di, temp_data
  mov c, 128
  load          ; load filename from user-space
    
  mov a, [current_dirID]
  inc a        ; metadata sector
  mov b, a
  mov c, 0        ; reset LBA to 0
  mov ah, $01      ; disk read
  mov d, transient_area
  call ide_read_sect    ; read directory
  cla
  mov [index], a    ; reset file counter
fileio_chmod_L1:
  mov si, d
  mov di, temp_data
  call strcmp
  je fileio_chmod_found_entry

  add d, 32
  mov a, [index]
  inc a
  mov [index], a
  cmp a, FST_FILES_PER_DIR
  jne fileio_chmod_L1
  pop bl
  jmp fileio_chmod_not_found
fileio_chmod_found_entry:  
  mov g, b          ; save LBA
  pop bl            ; retrieve saved permission value
  mov al, [d + 24]      ; read file permissions
  and al, %11111000      ; remove all permissions, keep other flags
  or al, bl          ; set new permissions
  mov [d + 24], al      ; write new permissions
  mov c, 0
  mov d, transient_area
  mov ah, $01        ; disk write 1 sect
  mov b, g          ; retrieve LBA
  call ide_write_sect    ; write sector
fileio_chmod_not_found:
  sysret

;; bootloader installer
;; kernel LBA address in A
cmd_boot_installer:
  push a
  mov b, 0
  mov c, 0
  mov ah, $01        ; 1 sector
  mov d, transient_area
  call ide_read_sect      ; read sector
  
  pop a
  mov [d + 510], a    ; update LBA address
  mov b, 0
  mov c, 0
  mov ah, $01        ; 1 sector
  mov d, transient_area
  call ide_write_sect    ; write sector
  
  sysret

cmd_fs_space:
  sysret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CREATE NEW DIRECTORY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; search list for NULL name entry. add new directory to list
cmd_mkdir:
  mov si, d
  mov di, temp_data
  mov c, 512
  load            ; load data from user-space
  mov b, FST_LBA_START + 2   ; start at 2 because LBA  0 is ROOT (this would also cause issues                 
                ; when checking for NULL name, since root has a NULL name)
  mov c, 0          ; reset LBA to 0
cmd_mkdir_L1:  
  mov ah, $01      ; disk read
  mov d, transient_area
  call ide_read_sect    ; read sector
  cmp byte[d], 0      ; check for NULL
  je cmd_mkdir_found_null
  add b, FST_SECTORS_PER_DIR          ; skip directory
  jmp cmd_mkdir_L1
cmd_mkdir_found_null:
;create header file by grabbing dir name from parameter
  push b        ; save new directory's LBA
  mov c, 64
  mov si, temp_data
  mov di, transient_area
  rep movsb          ; copy dirname from temp_data to transient_area
  mov a, [current_dirID]
  mov [transient_area + 64], a    ; store parent directory LBA
  mov al, 0
  mov di, transient_area + 512
  mov c, 512
  rep stosb          ; clean buffer
  mov c, 0        ; reset LBA(c) to 0
; write directory entry sectors
  mov d, transient_area
  mov ah, $02      ; disk write, 2 sectors
  call ide_write_sect    ; write sector
; now we need to add the new directory to the list, insIDE the current directory
  mov a, [current_dirID]
  add a, 1
  mov b, a          ; metadata sector
  mov c, 0
  mov g, b          ; save LBA
  mov d, transient_area
  mov ah, $01      ; disk read
  call ide_read_sect    ; read metadata sector
cmd_mkdir_L2:
  cmp byte[d], 0
  je cmd_mkdir_found_null2
  add d, FST_ENTRY_SIZE
  jmp cmd_mkdir_L2          ; we look for a NULL entry here but dont check for limits. CARE NEEDED WHEN ADDING TOO MANY FILES TO A DIRECTORY
cmd_mkdir_found_null2:
  mov si, temp_data
  mov di, d
  call strcpy      ; copy directory name
  add d, 24      ; goto ATTRIBUTES
  mov al, %00001011    ;directory, no execute, write, read
  mov [d], al      
  inc d
  pop b
  push b        ; push LBA back
  mov [d], b      ; save LBA
; set file creation date  
  add d, 4
  mov al, 4
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set day
  inc d
  mov al, 5
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set month
  inc d
  mov al, 6
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set year
; write sector into disk for new directory entry
  mov b, g
  mov c, 0
  mov d, transient_area
  mov ah, $01      ; disk write, 1 sector
  call ide_write_sect    ; write sector

; after adding the new directory's information to its parent directory's list
; we need to now enter the new directory, and to it add two new directories!
; which directories do we need to add ? '..' and '.' are the directories needed.
; importantly, note that these two new directories are only entries in the list
; and do not have actual physical entries in the disk as real directories.
; i.e. they only exist as list entries in the new directory created so that
; the new directory can reference its parent and itself
;
; we need to add both '..' and '.'
; this first section is for '..' and on the section below we do the same for '.'
  pop a            ; retrieve the new directory's LBA  
  push a            ; and save again
  add a, 1
  mov b, a          ; metadata sector
  mov c, 0
  mov g, b          ; save LBA
  mov d, transient_area
  mov ah, $01      ; disk read
  call ide_read_sect    ; read metadata sector
cmd_mkdir_L3:
  cmp byte[d], 0
  je cmd_mkdir_found_null3
  add d, FST_ENTRY_SIZE
  jmp cmd_mkdir_L3  ; we look for a NULL entry here but dont check for limits. CARE NEEDED WHEN ADDING TOO MANY FILES TO A DIRECTORY
cmd_mkdir_found_null3:
  mov si, s_parent_dir
  mov di, d
  call strcpy      ; copy directory name
  add d, 24      ; goto ATTRIBUTES
  mov al, %00001011    ;directory, no execute, write, read, 
  mov [d], al      
  inc d
  mov b, [current_dirID]  ; retrieve the parent directorys LBA
  mov [d], b      ; save LBA
; set file creation date  
  add d, 4
  mov al, 4
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set day
  inc d
  mov al, 5
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set month
  inc d
  mov al, 6
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set year
; write sector into disk for new directory entry
  mov b, g
  mov c, 0
  mov d, transient_area
  mov ah, $01      ; disk write, 1 sector
  call ide_write_sect    ; write sector

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; like we did above for '..', we need to now add the '.' directory to the list.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  pop a            ; retrieve the new directory's LBA  
  push a
  add a, 1
  mov b, a          ; metadata sector
  mov c, 0
  mov g, b          ; save LBA
  mov d, transient_area
  mov ah, $01        ; disk read
  call ide_read_sect        ; read metadata sector
cmd_mkdir_L4:
  cmp byte[d], 0
  je cmd_mkdir_found_null4
  add d, FST_ENTRY_SIZE
  jmp cmd_mkdir_L4  ; we look for a NULL entry here but dont check for limits. CARE NEEDED WHEN ADDING TOO MANY FILES TO A DIRECTORY
cmd_mkdir_found_null4:
  mov si, s_current_dir
  mov di, d
  call strcpy      ; copy directory name
  add d, 24      ; goto ATTRIBUTES
  mov al, %00001011    ;directory, no execute, write, read, 
  mov [d], al      
  inc d
  pop b        ; new directory's LBA itself. for self-referential directory entry '.'
  mov [d], b      ; save LBA
; set file creation date  
  add d, 4
  mov al, 4
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set day
  inc d
  mov al, 5
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set month
  inc d
  mov al, 6
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set year
; write sector into disk for new directory entry
  mov b, g
  mov c, 0
  mov d, transient_area
  mov ah, $01      ; disk write, 1 sector
  call ide_write_sect    ; write sector
cmd_mkdir_end:
  sysret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; get path from a given directory dirID
;; pseudo code:
;  get_path_from_dirID(int dirID, char *D){
;    if(dirID == 0){
;      reverse path in D;
;      return;
;    }
;    else{
;      copy directory name to end of D;
;      add '/' to end of D;
;      parentID = get parent directory ID;
;      get_path_from_dirID(parentID, D);
;    }
;  }
;; A = dirID
;; D = generated path string pointer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sample path: /usr/bin
get_path_from_dirID:
  mov d, filename
  mov al, 0
  mov [d], al        ; initialize path string 
  mov a, [current_dirID]
  call get_path_from_dirID_E0
  mov d, filename
  call strrev
  call puts
  sysret
get_path_from_dirID_E0:
  call get_dirname_from_dirID
  mov si, s_fslash
  mov di, d
  call strcat            ; add '/' to end of path
  cmp a, ROOT_dirID        ; check if we are at the root directory
  je get_path_from_dirID_root
  call get_parentID_from_dirID  ; use current ID (A) to find parentID (into A)
  cmp a, ROOT_dirID        ; check if we are at the root directory
  je get_path_from_dirID_root
  call get_path_from_dirID_E0    ; recursively call itself
get_path_from_dirID_root:
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; inputs:
;; A = directory ID
;; outputs:
;; D = pointer to directory name string
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
get_dirname_from_dirID:
  push a
  push b
  push d
  mov b, a
  mov c, 0        ; reset LBA to 0
  mov ah, $01      ; disk read
  mov d, transient_area - 512
  call ide_read_sect      ; read directory
  call strrev        ; reverse dir name before copying
  mov si, d
  pop d          ; destination address = D value pushed at beginning
  mov di, d
  call strcat        ; copy filename to D
  pop b
  pop a
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; inputs:
;; A = directory ID
;; outputs:
;; A = parent directory ID
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
get_parentID_from_dirID:
  push b
  push d
  mov b, a
  mov c, 0        ; reset LBA to 0
  mov ah, $01      ; disk read
  mov d, transient_area - 512
  call ide_read_sect      ; read directory
  mov a, [d + 64]      ; copy parent ID value to A
  pop d
  pop b
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; get dirID from a given path string
;; inputs:
;; D = path pointer 
;; outputs:
;; A = dirID
;; if dir non existent, A = FFFF (fail code)
;; /usr/local/bin    - absolute
;; local/bin/games    - relative
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
get_dirID_from_path_user:
  mov si, d
  mov di, temp_data
  mov c, 512
  load
  call get_dirID_from_path
  sysret

get_dirID_from_path:
  mov b, temp_data
  mov [prog], b      ; token pointer set to path string
  call get_token
  mov bl, [tok]
  cmp bl, TOK_FSLASH
  je get_dirID_from_path_abs 
  mov a, [current_dirID]
  call putback
  jmp get_dirID_from_path_E0
get_dirID_from_path_abs:
  mov a, ROOT_dirID
get_dirID_from_path_E0:
  call get_token
  mov bl, [toktyp]
  cmp bl, TOKTYP_IDENTIFIER
  jne get_dirID_from_path_end  ; check if there are tokens after '/'. i.e. is this a 'cd /' command?

  mov si, tokstr
  mov di, filename
  call strcpy        
  inc a          ; metadata sector
  mov b, a
  mov c, 0        ; reset LBA to 0
  mov ah, $01      ; disk read
  mov d, transient_area
  call ide_read_sect    ; read directory
  cla
  mov [index], a
get_dirID_from_path_L1:
  mov si, d
  mov di, filename
  call strcmp
  je get_dirID_from_path_name_equal  
  add d, 32
  mov a, [index]
  inc a
  mov [index], a
  cmp a, FST_FILES_PER_DIR
  je get_dirID_from_path_fail
  jmp get_dirID_from_path_L1
get_dirID_from_path_name_equal:
  add d, 25          ; 
  mov a, [d]          ; set result register A = dirID
  call get_token
  mov bl, [tok]
  cmp bl, TOK_FSLASH      ; check if there are more elements in the path
  je get_dirID_from_path_E0
  call putback
get_dirID_from_path_end:
  ret
get_dirID_from_path_fail:
  mov A, $FFFF
  ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; check if file exists by a given path string
;; inputs:
;; D = path pointer 
;; OUTPUTS:
;; A = success code, if file exists gives LBA, else, give 0
;; /usr/local/bin/ed
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
file_exists_by_path_user:
  mov si, d
  mov di, temp_data
  mov c, 512
  load
  call file_exists_by_path
  sysret
file_exists_by_path:
  mov b, temp_data
  mov [prog], b      ; token pointer set to path string
  call get_token
  mov bl, [tok]
  cmp bl, TOK_FSLASH
  je  file_exists_by_path_abs
  mov a, [current_dirID]
  call putback
  jmp file_exists_by_path_E0
file_exists_by_path_abs:
  mov a, ROOT_dirID
file_exists_by_path_E0:
  call get_token
  mov bl, [toktyp]
  cmp bl, TOKTYP_IDENTIFIER
  jne file_exists_by_path_end  ; check if there are tokens after '/'
  mov si, tokstr
  mov di, filename
  call strcpy        
  inc a          ; metadata sector
  mov b, a
  mov c, 0        ; reset LBA to 0
  mov ah, $01      ; disk read
  mov d, transient_area
  call ide_read_sect    ; read directory
  cla
  mov [index], a
file_exists_by_path_L1:
  mov si, d
  mov di, filename
  call strcmp
  je   file_exists_by_path_name_equal
  add d, 32
  mov a, [index]
  inc a
  mov [index], a
  cmp a, FST_FILES_PER_DIR
  je file_exists_by_path_end
  jmp file_exists_by_path_L1
file_exists_by_path_name_equal:
  mov bl, [d + 24]
  and bl, %00111000      ; directory flag
  cmp bl, %00001000      ; is dir?
  je file_exists_by_path_isdir;
; entry is a file
  mov a, [d + 25]      ; get and return LBA of file
  ret
file_exists_by_path_isdir:
  add d, 25          ; 
  mov a, [d]          ; set result register A = dirID
  call get_token
  jmp file_exists_by_path_E0
file_exists_by_path_end:
  mov a, 0      ; return 0 because file was not found
  ret





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load file data from a given path string
;; inputs:
;; D = path pointer 
;; DI = userspace program data destination
;; /usr/local/bin/ed
;; ./ed
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadfile_from_path_user:
  push di
  mov si, d
  mov di, temp_data
  mov c, 512
  load
  call loadfile_from_path
  pop di
  mov si, transient_area
  mov c, 512 * (FS_SECTORS_PER_FILE-1)
  store
  sysret
loadfile_from_path:
  mov b, temp_data
  mov [prog], b      ; token pointer set to path string
  call get_token
  mov bl, [tok]
  cmp bl, TOK_FSLASH
  je loadfile_from_path_abs 
  mov a, [current_dirID]
  call putback
  jmp loadfile_from_path_E0
loadfile_from_path_abs:
  mov a, ROOT_dirID
loadfile_from_path_E0:
  call get_token
  mov bl, [toktyp]
  cmp bl, TOKTYP_IDENTIFIER
  jne loadfile_from_path_end  ; check if there are tokens after '/'. i.e. is this a 'cd /' command?
  mov si, tokstr
  mov di, filename
  call strcpy        
  inc a          ; metadata sector
  mov b, a
  mov c, 0        ; reset LBA to 0
  mov ah, $01      ; disk read
  mov d, transient_area
  call ide_read_sect    ; read directory
  cla
  mov [index], a
loadfile_from_path_L1:
  mov si, d
  mov di, filename
  call strcmp
  je loadfile_from_path_name_equal  
  add d, 32
  mov a, [index]
  inc a
  mov [index], a
  cmp a, FST_FILES_PER_DIR
  je loadfile_from_path_end
  jmp loadfile_from_path_L1
loadfile_from_path_name_equal:
  mov bl, [d + 24]
  and bl, %00111000      ; directory flag
  cmp bl, %00001000      ; is dir?
  je loadfile_isdirectory  ;
; entry is a file
  mov b, [d + 25]      ; get LBA
  inc b        ; add 1 to B because the LBA for data comes after the header sector
  mov d, transient_area
  mov c, 0
  mov ah, FS_SECTORS_PER_FILE-1    ; number of sectors
  call ide_read_sect        ; read sector
  ret
loadfile_isdirectory:
  add d, 25          ; 
  mov a, [d]          ; set result register A = dirID
  call get_token
  jmp loadfile_from_path_E0
loadfile_from_path_end:
  ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; return the ID of the current directory
;; ID returned in B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
get_current_dirID:
  mov b, [current_dirID]
  sysret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; new dirID in B
cmd_cd:
  mov [current_dirID], b
  sysret  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LS
;; dirID in B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmd_ls:
  inc b        ; metadata sector
  mov c, 0        ; reset LBA to 0
  mov ah, $01      ; disk read
  mov d, transient_area
  call ide_read_sect    ; read directory
  cla
  mov [index], a    ; reset entry index
cmd_ls_L1:
  cmp byte [d], 0    ; check for NULL
  je cmd_ls_next
cmd_ls_non_null:
  mov al, [d + 24]
  and al, %00111000
  shr al, 3
  mov ah, 0          ; file type
  mov a, [a + file_type]      
  mov ah, al
  call putchar
  mov al, [d + 24]
  and al, %00000001
  mov ah, 0
  mov a, [a + file_attrib]    ; read
  mov ah, al
  call putchar
  mov al, [d + 24]
  and al, %00000010
  mov ah, 0
  mov a, [a + file_attrib]    ; write
  mov ah, al
  call putchar
  mov al, [d + 24]
  and al, %00000100
  mov ah, 0
  mov a, [a + file_attrib]    ; execute
  mov ah, al
  call putchar
  mov ah, $20
  call putchar  
  mov a, [d + 27]
  call print_u16d        ; filesize
  mov ah, $20
  call putchar  
  mov a, [d + 25]
  call print_u16d      ; dirID / LBA
  mov ah, $20
  call putchar
; print date
  mov bl, [d + 29]      ; day
  call print_u8x
  mov ah, $20
  call putchar  
  mov al, [d + 30]      ; month
  shl al, 2
  push d
  mov d, s_months
  mov ah, 0
  add d, a
  call puts
  pop d
  mov ah, $20
  call putchar
  mov bl, $20
  call print_u8x
  mov bl, [d + 31]      ; year
  call print_u8x  
  mov ah, $20
  call putchar  
  call puts        ; print filename  
  call printnl
cmd_ls_next:
  mov a, [index]
  inc a
  mov [index], a
  cmp a, FST_FILES_PER_DIR
  je cmd_ls_end
  add d, 32      
  jmp cmd_ls_L1  
cmd_ls_end:
  sysret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pad string to 32 chars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; count in C
padding:
  push a
  push b
  mov a, 32
  mov b, c
  sub a, b
  mov c, a
padding_L1:
  mov ah, $20
  call putchar
  dec c
  cmp c, 0
  jne padding_L1
  pop b
  pop a
  ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; finds an empty data block
;; block LBA returned in B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fs_find_empty_block:
  mov b, FS_LBA_START    ; raw files starting block
  mov c, 0            ; reset LBA to 0
fs_find_empty_block_L1:  
  mov ah, $01      ; disk read
  mov d, transient_area - 512
  call ide_read_sect    ; read sector
  cmp byte [d], 0
  je fs_find_empty_block_found_null
  add b, FS_SECTORS_PER_FILE
  jmp fs_find_empty_block_L1
fs_find_empty_block_found_null:
  ret

; file structure:
; 512 bytes header
; header used to tell whether the block is free
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CREATE NEW TEXTFILE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmd_mktxt:
  mov si, d
  mov di, transient_area
  mov c, FS_SECTORS_PER_FILE * 512
  load          ; load data from user-space
  call fs_find_empty_block  ; look for empty data blocks
  push b        ; save empty block LBA
;create header file by grabbing file name from parameter  
  mov d, transient_area + 512      ; pointer to file contents
  ;call gettxt
  call strlen            ; get length of the text file
  push c              ; save length
  mov al, 1
  mov [transient_area], al          ; mark sectors as USED (not NULL)
  mov d, transient_area
cmd_mktxt_L2:
  mov c, 0
  mov ah, FS_SECTORS_PER_FILE    ; number of sectors to write
  call ide_write_sect      ; write sectors
; now we add the file to the current directory!
cmd_mktxt_add_to_dir:  
  mov a, [current_dirID]
  inc a
  mov b, a          ; metadata sector
  mov c, 0
  mov g, b          ; save LBA
  mov d, transient_area - 512
  mov ah, $01      ; disk read
  call ide_read_sect    ; read metadata sector
cmd_mktxt_add_to_dir_L2:
  cmp byte[d], 0
  je cmd_mktxt_add_to_dir_null
  add d, FST_ENTRY_SIZE
  jmp cmd_mktxt_add_to_dir_L2    ; we look for a NULL entry here but dont check for limits. CARE NEEDED WHEN ADDING TOO MANY FILES TO A DIRECTORY
cmd_mktxt_add_to_dir_null:
  mov si, transient_area + 1    ; filename located after the data block 'USED' marker byte
  mov di, d
  call strcpy      ; copy file name
  add d, 24      ; skip name
  mov al, %00000011  ; type=file, no execute, write, read
  mov [d], al      
  add d, 3
  pop a
  mov [d], a
  sub d, 2
  pop b        ; get file LBA
  mov [d], b      ; save LBA  
  
  ; set file creation date  
  add d, 4
  mov al, 4
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set day
  
  inc d
  mov al, 5
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set month
  
  inc d
  mov al, 6
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set year
  
; write sector into disk for new directory entry
  mov b, g
  mov c, 0
  mov d, transient_area - 512
  mov ah, $01      ; disk write, 1 sector
  call ide_write_sect    ; write sector
  sysret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CREATE NEW BINARY FILE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; search for first null block
cmd_mkbin:
  mov si, d
  mov di, temp_data
  mov c, 512
  load          ; load data from user-space
  
  mov b, FS_LBA_START    ; files start when directories end
  mov c, 0        ; reset LBA to 0
cmd_mkbin_L1:  
  mov ah, $01      ; disk read
  mov d, transient_area
  call ide_read_sect    ; read sector
  cmp byte[d], 0      ; check for NULL
  je cmd_mkbin_found_null
  add b, FS_SECTORS_PER_FILE
  jmp cmd_mkbin_L1
cmd_mkbin_found_null:
  push b        ; save LBA
;create header file by grabbing file name from parameter
  mov di, transient_area + 512  ; pointer to file contents
  call _load_hex      ; load binary hex
  push c          ; save size (nbr of bytes)
  mov al, 1
  mov [transient_area], al    ; mark sectors as USED (not NULL)
  cla
  mov [index], a
  mov d, transient_area
  mov a, d
  mov [buffer_addr], a
cmd_mkbin_L2:
  mov c, 0
  mov ah, $01        ; disk write, 1 sector
  call ide_write_sect      ; write sector
  mov a, [index]
  inc a
  mov [index], a
  cmp a, FS_SECTORS_PER_FILE    ; remove 1 from this because we dont count the header sector
  je cmd_mkbin_add_to_dir
  inc b
  mov a, [buffer_addr]
  add a, 512
  mov [buffer_addr], a
  mov d, a
  jmp cmd_mkbin_L2
; now we add the file to the current directory!
cmd_mkbin_add_to_dir:  
  mov a, [current_dirID]
  inc a
  mov b, a          ; metadata sector
  mov c, 0
  mov g, b          ; save LBA
  mov d, transient_area
  mov ah, $01      ; disk read
  call ide_read_sect    ; read metadata sector
cmd_mkbin_add_to_dir_L2:
  cmp byte[d], 0
  je cmd_mkbin_add_to_dir_null
  add d, FST_ENTRY_SIZE
  jmp cmd_mkbin_add_to_dir_L2    ; we look for a NULL entry here but dont check for limits. CARE NEEDED WHEN ADDING TOO MANY FILES TO A DIRECTORY
cmd_mkbin_add_to_dir_null:
  mov si, temp_data
  mov di, d
  call strcpy      ; copy file name
  add d, 24      ; skip name
  mov al, %00000111    ;type=file, execute, write, read, 
  mov [d], al
  add d, 3
  pop a
  mov [d], a
  sub d, 2
  pop b        ; get file LBA
  mov [d], b      ; save LBA
  
  ; set file creation date  
  add d, 4
  mov al, 4
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set day
  
  inc d
  mov al, 5
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set month
  
  inc d
  mov al, 6
  syscall sys_rtc
  mov al, ah
  mov [d], al      ; set year
  
; write sector into disk for new directory entry
  mov b, g
  mov c, 0
  mov d, transient_area
  mov ah, $01      ; disk write, 1 sector
  call ide_write_sect    ; write sector
  sysret

      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PWD - PRINT WORKING DIRECTORY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
cmd_pwd:
  mov d, filename
  mov al, 0
  mov [d], al        ; initialize path string 
  mov a, [current_dirID]
  call get_path_from_dirID_E0
  mov d, filename
  call strrev
  call puts
  call printnl
  sysret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; get current directory LBA
;; A: returned LBA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:
cmd_get_curr_dir_LBA:
  mov a, [current_dirID]
  sysret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LOAD FILE INTO MEM
;; file loaded to transient_area
;; D: filename pointer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:
cmd_loadfile_user:
  mov si, d
  mov di, filename
  mov c, 256
  load
  call cmd_loadfile
  sysret

cmd_loadfile:
  mov a, [current_dirID]
  inc a        ; metadata sector
  mov b, a
  mov c, 0        ; reset LBA to 0
  mov ah, $01      ; disk read
  mov d, transient_area-512
  call ide_read_sect    ; read directory
  cla
  mov [index], a    ; reset file counter
cmd_loadfile_L1:
  mov si, d
  mov di, filename
  call strcmp
  je cmd_loadfile_found_entry
  add d, 32
  mov a, [index]
  inc a
  mov [index], a
  cmp a, FST_FILES_PER_DIR
  je cmd_loadfile_not_found
  jmp cmd_loadfile_L1
cmd_loadfile_found_entry:
  add d, 25      ; get to dirID of file in disk
  mov b, [d]      ; get LBA
  inc b        ; add 1 to B because the LBA for data comes after the header sector
  mov d, transient_area
  mov ah, FS_SECTORS_PER_FILE-1    ; number of sectors
  call ide_read_sect        ; read sector
cmd_loadfile_not_found:
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAT
;; userspace destination data pointer in D
;; filename starts at D, but is overwritten after the read is made
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:
cmd_cat:
  push d          ; save userspace file data destination
  mov si, d
  mov di, temp_data
  mov c, 512
  load          ; copy filename from user-space
  mov b, [current_dirID]
  inc b        ; metadata sector
  mov c, 0        ; reset LBA to 0
  mov ah, $01      ; disk read
  mov d, transient_area-512
  call ide_read_sect    ; read directory
  cla
  mov [index], a    ; reset file counter
cmd_cat_L1:
  mov si, d
  mov di, temp_data
  call strcmp
  je cmd_cat_found_entry
  add d, 32
  mov a, [index]
  inc a
  mov [index], a
  cmp a, FST_FILES_PER_DIR
  je cmd_cat_not_found
  jmp cmd_cat_L1
cmd_cat_found_entry:
  add d, 25      ; get to dirID of file in disk
  mov b, [d]      ; get LBA
  inc b        ; add 1 to B because the LBA for data comes after the header sector 
  mov d, transient_area  
  mov c, 0
  mov ah, FS_SECTORS_PER_FILE-1  ; nbr sectors
  call ide_read_sect    ; read sectors
  pop di            ; write userspace file data destination to DI
  mov si, transient_area    ; data origin
  mov c, 512*(FS_SECTORS_PER_FILE-1)
  store
  sysret
cmd_cat_not_found:
  pop d
  sysret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RMDIR - remove DIR by dirID
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; deletes a directory entry in the given directory's file list 
; also deletes the actual directory entry in the FST
; synopsis: rmdir /usr/local/testdir
; B = dirID
cmd_rmdir:
  mov g, b
  mov a, b
  call get_parentID_from_dirID  ; now get the directory's parent, in A
  push a            ; save dirID
; search for directory's entry in the parent's directory then and delete it
  inc a            ; metadata sector
  mov b, a
  mov c, 0          ; reset LBA to 0
  mov ah, $01          ;
  mov d, transient_area
  call ide_read_sect      ; read directory
  cla
  mov [index], a        ; reset file counter
  mov b, g          ; retrieve directory's dirID
cmd_rmdir_L1:
  mov a, [d + 25]        ; get entry's dirID/LBA value
  cmp a, b          ; compare dirID's to find the directory
  je cmd_rmdir_found_entry
  add d, 32
  mov a, [index]
  inc a
  mov [index], a
  cmp a, FST_FILES_PER_DIR
  je cmd_rmdir_not_found
  jmp cmd_rmdir_L1
cmd_rmdir_found_entry:
  cla
  mov [d], al          ; make filename NULL
  mov [d + 25], a        ; clear dirID/LBA as well not to generate problems with previously deleted directories
  pop b
  inc b            ; metadata sector
  mov c, 0          ; reset LBA to 0
  mov ah, $01          ; 
  mov d, transient_area
  call ide_write_sect      ; write sector and erase file's entry in the current DIR

  mov b, g
  mov d, transient_area  
  cla
  mov [d], al          ; make directory's name header NULL for re-use
  mov c, 0
  mov ah, $01          ; disk write 1 sect
  call ide_write_sect      ; delete directory given by dirID in B
  sysret
cmd_rmdir_not_found:
  pop b
  sysret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RM - remove file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; frees up the data sectors for the file further down the disk
; deletes file entry in the directory's file list 
cmd_rm:
  mov si, d
  mov di, temp_data
  mov c, 512
  load          ; load data from user-space
  mov a, [current_dirID]
  inc a        ; metadata sector
  mov b, a
  mov c, 0        ; reset LBA to 0
  mov ah, $01      ; disk read
  mov d, transient_area
  call ide_read_sect    ; read directory
  mov a, 0
  mov [index], a    ; reset file counter
cmd_rm_L1:
  mov si, d
  mov di, temp_data
  call strcmp
  je cmd_rm_found_entry
  add d, 32
  mov a, [index]
  inc a
  mov [index], a
  cmp a, FST_FILES_PER_DIR
  je cmd_rm_not_found
  jmp cmd_rm_L1
cmd_rm_found_entry:
  mov b, [d + 25]      ; get LBA
  mov g, b        ; save LBA
  mov al, 0
  mov [d], al      ; make file entry NULL
  mov a, [current_dirID]
  inc a        ; metadata sector
  mov b, a
  mov c, 0        ; reset LBA to 0
  mov ah, $01      ; disk write
  mov d, transient_area
  call ide_write_sect    ; write sector and erase file's entry in the current DIR
  mov d, transient_area  
  mov al, 0
  mov [d], al      ; make file's data header NULL for re-use
  mov c, 0
  mov b, g        ; get data header LBA
  mov ah, $01          ; disk write 1 sect
  call ide_write_sect        ; write sector
cmd_rm_not_found:  
  sysret  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mv - move / change file name
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmd_mv:
  mov si, d
  mov di, temp_data
  mov c, 512
  load            ; load data from user-space
  mov a, [current_dirID]
  inc a            ; metadata sector
  mov b, a  
  mov c, 0          ; reset LBA to 0
  mov ah, $01        ; disk read
  mov d, transient_area
  call ide_read_sect    ;read directory
  cla
  mov [index], a        ;reset file counter
cmd_mv_L1:
  mov si, d
  mov di, temp_data
  call strcmp
  je cmd_mv_found_entry
  add d, 32
  mov a, [index]
  inc a
  mov [index], a
  cmp a, FST_FILES_PER_DIR
  je cmd_mv_not_found
  jmp cmd_mv_L1
cmd_mv_found_entry:  
  push d
  mov si, temp_data + 128  ; (0...127) = original filename , (128...255) = new name
  mov di, d
  call strcpy  
  mov c, 0
  mov d, transient_area
  mov ah, $01          ;disk write 1 sect
  call ide_write_sect      ;write sector
  pop d
;;;;;;;; need to check whether its a dir or a file here ;;;;;;;;;;;;;;
  mov b, [d + 25]        ; get the dirID of the directory so we can locate its own entry in the list
  mov ah, $01
  mov d, transient_area
  mov c, 0
  call ide_read_sect      ; read directory entry
  mov si, temp_data + 128
  mov di, d
  call strcpy          ; change directory's name
  mov ah, $01
  call ide_write_sect      ; rewrite directory back to disk
cmd_mv_not_found:
  sysret

kernel_reset_vector:  
  mov bp, STACK_BEGIN
  mov sp, STACK_BEGIN
  
  mov al, %10000000
  stomsk          ; mask out timer interrupt for now (only allow UART to interrupt)
  sti  

  lodstat
  and al, %11011111  ; disable display register loading
  stostat
  
; reset fifo pointers
  mov a, fifo
  mov d, fifo_pi
  mov [d], a
  mov d, fifo_pr
  mov [d], a  
  mov al, 2
  syscall sys_io      ; enable uart in interrupt mode
  
  mov d, s_kernel_started
  call puts
  
  mov d, s_prompt_init
  call puts

  mov al, 16
  syscall sys_filesystem    ; set root dirID

  mov d, s_init_path
  syscall sys_fork    ; launch init as a new process

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Process Index in A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
find_free_proc:
  mov si, proc_availab_table + 1      ; skip process 0 (kernel)
find_free_proc_L0:
  lodsb            ; get process state
  cmp al, 0
  je find_free_proc_free      ; if free, jump
  jmp find_free_proc_L0      ; else, goto next
find_free_proc_free:
  mov a, si
  sub a, 1 + proc_availab_table        ; get process index
  ret
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Process Index in AL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
proc_memory_map:
  mov ah, 0
  mov b, a      ; page in BL, 0 in BH
  shl a, 5      ; multiply by 32
  mov c, a      ; save in C
  add c, 32
proc_memory_map_L0:
  pagemap
  add b, $0800          ; increase page number (msb 5 bits of BH only)
  add a, 1            ; increase both 
  cmp a, c            ; check to see if we reached the end of memory
  jne proc_memory_map_L0
  ret
  

cmd_terminate_proc:
  add sp, 5    ; clear stack of the values that were pushed by the interrupt (SP, Status, PC)
          ; since they will not be used for anything here.
  mov al, [active_proc_index]
  mov ah, 0  
  shl a, 5            ; x32
  add a, proc_names
  mov d, a
  mov al, 0
  mov [d], al      ; nullify process name

  mov al, [active_proc_index]
  mov ah, 0  
  mov d, a
  mov al, 0
  mov [d + proc_availab_table], al          ; make process empty again
  
  mov al, [nbr_active_procs]      ; decrease nbr of active processes
  dec al
  mov [nbr_active_procs], al

; now load the shell process again
  mov al, 2        ; next process = process 2 = shell
  mov [active_proc_index], al    ; set next active proc

; calculate LUT entry for next process
  mov ah, 0
  shl a              ; x2
  mov a, [proc_table_convert + a]    ; get process state start index  
  
  mov si, a            ; source is proc state block
  mov a, sp
  sub a, 19
  mov di, a            ; destination is kernel stack
; restore SP
  dec a
  mov sp, a
  mov c, 20
  rep movsb
; set VM process
  mov al, [active_proc_index]
  setptb
    
  popa
  sysret

cmd_pause_proc:
; save all registers into kernel stack
  pusha
  mov ah, 0
  mov al, [active_proc_index]
  shl a              ; x2
  mov a, [proc_table_convert + a]  ; get process state start index
    
  mov di, a
  mov a, sp
  inc a
  mov si, a
  mov c, 20
  rep movsb          ; save process state!
; restore kernel stack position to point before interrupt arrived
  add sp, 20
; now load the shell process again
  mov al, 2        ; next process = process 2 = shell
  mov [active_proc_index], al    ; set next active proc

; calculate LUT entry for next process
  mov ah, 0
  shl a              ; x2
  mov a, [proc_table_convert + a]    ; get process state start index  
  
  mov si, a            ; source is proc state block
  mov a, sp
  sub a, 19
  mov di, a            ; destination is kernel stack
; restore SP
  dec a
  mov sp, a
  mov c, 20
  rep movsb
; set VM process
  mov al, [active_proc_index]
  setptb
    
  popa
  sysret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; fork a new process
;; D = path of the process file to be forked
;; B = arguments ptr
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmd_fork:
; we save the active process first  
  pusha
  mov ah, 0
  mov al, [active_proc_index]
  shl a              ; x2
  mov a, [proc_table_convert + a]    ; get process state table's start index
  
  mov di, a
  mov a, sp
  inc a
  mov si, a
  mov c, 20
  rep movsb          ; save process state!
; restore kernel stack position to point before interrupt arrived
  add sp, 20
  
  mov si, d        ; copy the file path
  mov di, temp_data
  mov c, 512
  load
  mov a, b
  mov si, a        ; copy the arguments
  mov di, scrap_sector
  mov c, 512
  load
  call loadfile_from_path    ; load the process file from disk by path (path is in temp_data)
                ; the file data is loaded into transient_area
; now we allocate a new process  
  call find_free_proc      ; index in A
  setptb
  call proc_memory_map      ; map process memory pages
; copy arguments into process's memory
  mov si, scrap_sector
  mov di, 0
  mov c, 512
  store
; now copy process binary data into process's memory
  mov si, transient_area
  mov di, PROC_TEXT_ORG    ; code origin address for all user processes
  mov c, FS_FILE_SIZE      ; size of memory space to copy, which is equal to the max file size in disk (for now)
  store            ; copy process data
    
  call find_free_proc      ; index in A
  mov [active_proc_index], al    ; set new active process
  shl a, 5            ; x32
  add a, proc_names
  mov di, a
  mov si, temp_data      ; copy and store process filename
  call strcpy
  
  call find_free_proc      ; index in A
  mov d, a
  mov al, 1
  mov [d + proc_availab_table], al          ; make process busy
  
  mov al, [nbr_active_procs]      ; increase nbr of active processes
  inc al
  mov [nbr_active_procs], al
; launch process
  push word $FFFF 
  push byte %00001110    ; dma_ack = 0, interrupts enabled = 1, mode = user, paging = on, halt=0, display_reg_load=0, dir=0
  push word PROC_TEXT_ORG
  sysret

proc_table_convert:
  .dw proc_state_table + 0
  .dw proc_state_table + 20
  .dw proc_state_table + 40
  .dw proc_state_table + 60
  .dw proc_state_table + 80
  .dw proc_state_table + 100
  .dw proc_state_table + 120
  .dw proc_state_table + 140
  
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
  sub sp, $8000        ; string data block
  mov c, 0
  mov a, sp
  inc a
  mov d, a        ; start of string data block
  call gets        ; get program string
  mov si, a
__load_hex_loop:
  lodsb          ; load from [SI] to AL
  cmp al, 0        ; check if ASCII 0
  jz __load_hex_ret
  mov bh, al
  lodsb
  mov bl, al
  call atoi        ; convert ASCII byte in B to int (to AL)
  stosb          ; store AL to [DI]
  inc c
  jmp __load_hex_loop
__load_hex_ret:
  add sp, $8000
  pop di
  pop si
  pop d
  pop b
  pop a
  mov sp, bp
  pop bp
  ret

; synopsis: look insIDE a certain DIRECTORY for files/directories
; BEFORE CALLING THIS FUNCTION, CD INTO REQUIRED DIRECTORY
; for each entry insIDE DIRECTORY:
;  if entry is a file:
;    compare filename to searched filename
;    if filenames are the same, print filename
;  else if entry is a directory:
;    cd to the given directory
;    recursively call cmd_find
;    cd outsIDE previous directory
;  if current entry == last entry, return
; endfor
;    
;  
f_find:
  
  ret



nbr_active_procs:  .db 0
active_proc_index:  .db 1

index:        .dw 0
buffer_addr:    .dw 0

fifo_pi:      .dw fifo
fifo_pr:      .dw fifo

; file system variables
current_dirID:    .dw 0        ; keep dirID of current directory
s_init_path:    .db "/sbin/init", 0

s_parent_dir:    .db "..", 0
s_current_dir:    .db ".", 0
s_fslash:       .db "/", 0
s_hash:        .db " # ", 0
file_attrib:    .db "-rw x"      ; chars at multiples of 2
file_type:      .db "-dc"
s_ps_header:    .db "PID COMMAND\n", 0
s_host:       .db "Sol-1:", 0
s_uname:      .db "Solarium\n", 0

s_root:        .db "root\n", 0

s_int_en:      .db "interrupts enabled\n", 0
s_kernel_started:  .db "kernel started\n", 0
s_procname:      .db "enter process name: ", 0
s_prompt_init:    .db "starting init\n", 0
s_priviledge:    .db "\nsoftware failure: privilege exception\n", 0
s_divzero:      .db "\nexception: zero division\n", 0

s_set_year:      .db "Year: ", 0
s_set_month:    .db "Month: ", 0
s_set_day:      .db "Day: ", 0
s_set_week:      .db "Weekday: ", 0
s_set_hours:    .db "Hours: ", 0
s_set_minutes:    .db "Minutes: ", 0
s_set_seconds:    .db "Seconds: ", 0
s_months:      .db "   ", 0
          .db "Jan", 0
          .db "Feb", 0
          .db "Mar", 0
          .db "Apr", 0
          .db "May", 0
          .db "Jun", 0
          .db "Jul", 0
          .db "Aug", 0
          .db "Sep", 0
          .db "Oct", 0
          .db "Nov", 0
          .db "Dec", 0
s_week:        .db "Sun", 0 
          .db "Mon", 0 
          .db "Tue", 0 
          .db "Wed", 0 
          .db "Thu", 0 
          .db "Fri", 0 
          .db "Sat", 0

proc_state_table:  .fill 16 * 20, 0  ; for 15 processes max
proc_availab_table:  .fill 16, 0      ; space for 15 processes. 0 = process empty, 1 = process taken
proc_names:      .fill 16 * 32, 0  ; process names
filename:      .fill 512, 0    ; holds a path for file search
temp_data:      .fill 512, 0       ;  user space data
fifo:        .fill FIFO_SIZE

scrap_sector:    .fill 512    ; scrap sector
transient_area:    .db 0      ; beginning of the transient memory area. used for disk reads and other purposes    


.end
