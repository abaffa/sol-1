; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; a
  sub sp, 2 ; b
  sub sp, 2 ; c
  mov b, 1
  push a
  mov a, b
  mov [bp + -1], a ; a
  pop a
  mov b, 100
  push a
  mov a, b
  mov [bp + -3], a ; b
  pop a
  mov b, [bp + -3] ; b
  push a
  mov a, b
  mov b, [bp + -1] ; a
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -5], a ; c
  pop a
  mov b, [bp + -5] ; c
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
__aarr_data: 
.dw 1,1,1,1,1,1,1,1,1,1,
.fill 0, 0
__aarr: .dw __aarr_data
__barr_data: 
.dw 2,2,2,2,2,2,2,2,2,2,
.fill 0, 0
__barr: .dw __barr_data
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
