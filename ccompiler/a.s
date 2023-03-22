; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, sp
  mov b, a
  call print_u16x
  push word $FFFF
  mov a, sp
  mov b, a
  call print_u16x
  push byte $FF
  mov a, sp
  mov b, a
  call print_u16x
; --- END INLINE ASM BLOCK

  leave
  syscall sys_terminate_proc
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
