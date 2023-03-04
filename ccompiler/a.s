; --- FILENAME: strcat.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  leave
  syscall sys_terminate_proc
_strlen:
  push bp
  mov bp, sp
  sub sp, 2 ; length
; TEST
  mov b, [s2]
  mov d, b
  mov bl, [d]
  mov bh, 0
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
s1_data: 
.dw 'H', 'e', 'l', 'l', 'o', 0,
.fill 44, 0
s1: .dw s1_data
s2_data: .db ". My name is Sol-1.", 0
s2: .dw s2_data
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
