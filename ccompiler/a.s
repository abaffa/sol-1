; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; m
  mov b, 3
  push a
  mov a, b
  mov [bp + -1], a ; m
  pop a
  sub sp, 2 ; n
  mov b, 3
  push a
  mov a, b
  mov [bp + -3], a ; n
  pop a
  sub sp, 2 ; result
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2

; --- BEGIN INLINE ASM BLOCK
  mov a, sp
  call print_u16d
; --- END INLINE ASM BLOCK

  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + -1] ; m
  swp b
  push b
  mov b, [bp + -3] ; n
  swp b
  push b
  call ackermann
  add sp, 4
  push a
  mov a, b
  mov [bp + -5], a ; result
  pop a
  mov b, __string_1 ; "The result is: "
  swp b
  push b
  mov b, [bp + -5] ; result
  swp b
  push b
  call printn
  add sp, 4
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2

; --- BEGIN INLINE ASM BLOCK
  mov a, sp
  call print_u16d
; --- END INLINE ASM BLOCK

  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 0
  leave
  syscall sys_terminate_proc

ackermann:
  push bp
  mov bp, sp
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2

; --- BEGIN INLINE ASM BLOCK
  mov a, sp
  call print_u16d
; --- END INLINE ASM BLOCK

  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_if1_cond:
  mov b, [bp + 7] ; m
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if1_else
_if1_true:
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  leave
  ret
  jmp _if1_exit
_if1_else:
_if2_cond:
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if2_else
_if2_true:
  mov b, [bp + 7] ; m
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  swp b
  push b
  mov b, 1
  swp b
  push b
  call ackermann
  add sp, 4
  leave
  ret
  jmp _if2_exit
_if2_else:
  mov b, [bp + 7] ; m
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  swp b
  push b
  mov b, [bp + 7] ; m
  swp b
  push b
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  swp b
  push b
  call ackermann
  add sp, 4
  swp b
  push b
  call ackermann
  add sp, 4
  leave
  ret
_if2_exit:
_if1_exit:

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
__string_0: .db "\n", 0
__string_1: .db "The result is: ", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
