; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  mov b, _string_0
  call prints
  leave
  syscall sys_terminate_proc
prints:
  push bp
  mov bp, sp
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK


_string_0: .db "Hello World: ", 0

; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
