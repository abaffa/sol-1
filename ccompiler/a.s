; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [h]
  mov d, a
  call puts
; --- END INLINE ASM BLOCK

  leave
  syscall sys_terminate_proc
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
h_data: .db "Hello World", 0
h: .dw h_data
kk: .db 0
mp: .dw 10, 0, 0, 0, 0, 
matrix: .dw 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
