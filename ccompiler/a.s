; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  mov b, __i
  mov [__p], b
  mov b, __p
  mov [__pp], b
  mov b, [__pp] ; pp
  mov d, b
  mov b, [d]
  mov d, b
  mov b, [d]
  swp b
  push b
  call printn
  add sp, 2
  leave
  syscall sys_terminate_proc

scann:
  push bp
  mov bp, sp
  sub sp, 2 ; m

; --- BEGIN INLINE ASM BLOCK
  call scan_u16d
  mov [bp + -1], a
; --- END INLINE ASM BLOCK

  lea d, [bp + 5] ; n
  mov b, [d]
  push b
  mov b, [bp + -1] ; m
  pop d
  mov a, b
  mov [d], a
  leave
  ret

printn:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [bp + 5]
  call print_u16d
; --- END INLINE ASM BLOCK

  leave
  ret

print:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [bp + 5]
  mov d, a
  call puts
; --- END INLINE ASM BLOCK

  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
__i: .dw 5
__p: .fill 2, 0
__pp: .fill 2, 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
