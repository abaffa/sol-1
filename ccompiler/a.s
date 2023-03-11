; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  mov b, [__m]
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 2
  pop d
  mov [d], b
  mov b, [__m]
  push a
  mov d, b
  push d
  mov b, 1
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 1
  pop d
  mov [d], b
  mov b, [__m]
  push a
  mov d, b
  push d
  mov b, [__m]
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 55
  pop d
  mov [d], b
  mov b, [__m]
  push a
  mov d, b
  push d
  mov b, [__m]
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__m]
  push a
  mov d, b
  push d
  mov b, 1
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 77
  pop d
  mov [d], b
  mov b, [__m]
  push a
  mov d, b
  push d
  mov b, [__m]
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [__m]
  push a
  mov d, b
  push d
  mov b, [__m]
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__m]
  push a
  mov d, b
  push d
  mov b, 1
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
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
__m_data: .fill 20, 0
__m: .dw __m_data
__string_0: .db "\n", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
