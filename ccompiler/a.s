; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; i1
  sub sp, 2 ; i2
  sub sp, 2 ; i3
  sub sp, 2 ; i4
  mov b, 1
  push a
  mov a, b
  mov [bp + -1], a ; i1
  pop a
  mov b, 1
  push a
  mov a, b
  mov [bp + -3], a ; i2
  pop a
  mov b, 1
  push a
  mov a, b
  mov [bp + -5], a ; i3
  pop a
  mov b, 1
  push a
  mov a, b
  mov [bp + -7], a ; i4
  pop a
  mov b, [bp + -1] ; i1
  dec b
  push a
  mov a, b
  mov [bp + -1], a ; i1
  pop a
  swp b
  push b
  call printn
  add sp, 2
  mov b, _string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + -1] ; i1
  swp b
  push b
  call printn
  add sp, 2
  mov b, _string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + -3] ; i2
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; i2
  pop a
  swp b
  push b
  call printn
  add sp, 2
  mov b, _string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + -3] ; i2
  swp b
  push b
  call printn
  add sp, 2
  mov b, _string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + -5] ; i3
  mov a, b
  dec b
  push a
  mov a, b
  mov [bp + -5], a ; i3
  pop a
  mov b, a
  swp b
  push b
  call printn
  add sp, 2
  mov b, _string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + -5] ; i3
  swp b
  push b
  call printn
  add sp, 2
  mov b, _string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + -7] ; i4
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -7], a ; i4
  pop a
  mov b, a
  swp b
  push b
  call printn
  add sp, 2
  mov b, _string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + -7] ; i4
  swp b
  push b
  call printn
  add sp, 2
  mov b, _string_0 ; "\n"
  swp b
  push b
  call print
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
m1_data: 
.dw 123,111,123,
.fill 14, 0
m1: .dw m1_data
m2_data: 
.dw 0,1,2,
.fill 14, 0
m2: .dw m2_data
_string_0: .db "\n", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
