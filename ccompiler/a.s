; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  swp b
  push b
  call prints
  add sp, 2
  swp b
  push b
  call prints
  add sp, 2
  swp b
  push b
  call prints
  add sp, 2
  leave
  syscall sys_terminate_proc
prints:
  push bp
  mov bp, sp
  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK


_string_0: .db "Hello World", 0
_string_1: .db "Hello World2", 0
_string_2: .db "Hello World3", 0

; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
