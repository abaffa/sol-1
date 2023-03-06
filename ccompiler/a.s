; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
  sub sp, 2 ; k
  mov b, 100
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  mov b, 50
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
  mov b, 5
  push a
  mov a, b
  mov [bp + -5], a ; k
  pop a
  mov b, 20
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, [bp + -5] ; k
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  swp b
  push b
  call printn
  add sp, 2
  mov b, 0
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
m1_data: 
.dw 123,111,123,
.fill 14, 0
m1: .dw m1_data
m2_data: 
.dw 0,1,2,
.fill 14, 0
m2: .dw m2_data
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
