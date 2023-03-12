; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 20 ; m
  lea d, [bp + -19] ; m beginning on the stack
  mov b, d
  mov b, 0
  leave
  syscall sys_terminate_proc

add:
  push bp
  mov bp, sp
  mov b, [bp + 7] ; x
  push a
  mov a, b
  mov b, [bp + 5] ; y
  add a, b
  mov b, a
  pop a
  leave
  ret

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
  push a
  mov a, b
  mov [d], a
  pop a
  leave
  ret

printn:
  push bp
  mov bp, sp
  lea d, [bp + 7] ; s
  mov b, [d]
  swp b
  push b
  call print
  add sp, 2

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
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
