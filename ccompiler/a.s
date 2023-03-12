; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; swappos
_for1_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; swappos
  pop a
_for1_cond:
  mov b, [bp + -1] ; swappos
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for1_exit
_for1_block:
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; swappos
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
  mov [d], b
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for1_update:
  mov b, [bp + -1] ; swappos
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; swappos
  pop a
  mov b, a
  pop a
  jmp _for1_cond
_for1_exit:
_for2_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; swappos
  pop a
_for2_cond:
  mov b, [bp + -1] ; swappos
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for2_exit
_for2_block:
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; swappos
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
  mov b, __string_0 ; " : "
  swp b
  push b
  call print
  add sp, 2
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; swappos
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
  mov b, __string_1 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for2_update:
  mov b, [bp + -1] ; swappos
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; swappos
  pop a
  mov b, a
  pop a
  jmp _for2_cond
_for2_exit:
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
__anarr_data: 
.dw 1,1,1,1,1,1,1,1,1,1,
.fill 0, 0
__anarr: .dw __anarr_data
__bnarr_data: 
.dw 2,2,2,2,2,2,2,2,2,2,
.fill 0, 0
__bnarr: .dw __bnarr_data
__string_0: .db " : ", 0
__string_1: .db "\n", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
