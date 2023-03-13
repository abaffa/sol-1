; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
_for1_init:
  mov b, 100
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for1_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000010 ; >=
  cmp al, 0
  lodflgs
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for1_exit
_for1_block:
  mov b, [bp + -1] ; i
  swp b
  push b
  call print_num
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for1_update:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  dec b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  mov b, a
  pop a
  jmp _for1_cond
_for1_exit:
  leave
  syscall sys_terminate_proc
  mov b, 12
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 1126
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 65535
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 0
  leave
  syscall sys_terminate_proc

printn:
  push bp
  mov bp, sp
  sub sp, 5 ; buffer
  sub sp, 2 ; index
  sub sp, 2 ; i
_if2_cond:
  mov b, [bp + 5] ; number
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
  je _if2_exit
_if2_true:
  mov b, '0'
  push bl
  call _putchar
  add sp, 1
  leave
  ret
  jmp _if2_exit
_if2_exit:
  mov b, 0
  push a
  mov a, b
  mov [bp + -6], a ; index
  pop a
_while3_cond:
  mov b, [bp + 5] ; number
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while3_exit
_while3_block:
  lea d, [bp + -4] ; buffer beginning on the stack
  mov b, d
  push a
  mov d, b
  push d
  mov b, [bp + -6] ; index
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -6], a ; index
  pop a
  mov b, a
  pop a
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  push d
  mov b, [bp + 5] ; number
  push a
  mov a, b
  mov b, 10
  div a, b
  pop a
  push a
  mov a, b
  mov b, '0'
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], bl
  mov b, [bp + 5] ; number
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  push a
  mov a, b
  mov [bp + 5], a ; number
  pop a
  jmp _while3_cond
_while3_exit:
_for4_init:
  mov b, [bp + -6] ; index
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -8], a ; i
  pop a
_for4_cond:
  mov b, [bp + -8] ; i
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000010 ; >=
  cmp al, 0
  lodflgs
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for4_exit
_for4_block:
  lea d, [bp + -4] ; buffer beginning on the stack
  mov b, d
  push a
  mov d, b
  push d
  mov b, [bp + -8] ; i
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  mov bl, [d]
  mov bh, 0
  push bl
  call _putchar
  add sp, 1
_for4_update:
  mov b, [bp + -8] ; i
  push a
  mov a, b
  dec b
  push a
  mov a, b
  mov [bp + -8], a ; i
  pop a
  mov b, a
  pop a
  jmp _for4_cond
_for4_exit:
  leave
  ret

print_num:
  push bp
  mov bp, sp
  sub sp, 5 ; digits
  sub sp, 2 ; i
  mov b, 0
  push a
  mov a, b
  mov [bp + -6], a ; i
  pop a
_while5_cond:
  mov b, [bp + 5] ; num
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while5_exit
_while5_block:
  lea d, [bp + -4] ; digits beginning on the stack
  mov b, d
  push a
  mov d, b
  push d
  mov b, [bp + -6] ; i
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  push d
  mov b, '0'
  push a
  mov a, b
  mov b, [bp + 5] ; num
  push a
  mov a, b
  mov b, 10
  div a, b
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], bl
  mov b, [bp + 5] ; num
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  push a
  mov a, b
  mov [bp + 5], a ; num
  pop a
  mov b, [bp + -6] ; i
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -6], a ; i
  pop a
  mov b, a
  pop a
  jmp _while5_cond
_while5_exit:
_while6_cond:
  mov b, [bp + -6] ; i
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while6_exit
_while6_block:
  mov b, [bp + -6] ; i
  push a
  mov a, b
  dec b
  push a
  mov a, b
  mov [bp + -6], a ; i
  pop a
  mov b, a
  pop a
  lea d, [bp + -4] ; digits beginning on the stack
  mov b, d
  push a
  mov d, b
  push d
  mov b, [bp + -6] ; i
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  mov bl, [d]
  mov bh, 0
  push bl
  call _putchar
  add sp, 1
  jmp _while6_cond
_while6_exit:
  leave
  ret

_putchar:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov al, [bp + 5]
  mov ah, al
  call putchar
; --- END INLINE ASM BLOCK

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
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
