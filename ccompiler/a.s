; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  mov b, -2
  push a
  mov a, b
  mov b, -1
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call print_num
  add sp, 2
  mov b, 0
  leave
  syscall sys_terminate_proc

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
_if1_cond:
  mov b, [bp + 5] ; num
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
  je _if1_exit
_if1_true:
  mov b, '0'
  push bl
  call _putchar
  add sp, 1
  leave
  ret
  jmp _if1_exit
_if1_exit:
_while2_cond:
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
  je _while2_exit
_while2_block:
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
  jmp _while2_cond
_while2_exit:
_while3_cond:
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
  je _while3_exit
_while3_block:
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
  jmp _while3_cond
_while3_exit:
  leave
  ret

integer_square_root:
  push bp
  mov bp, sp
_if4_cond:
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000011 ; <=
  cmp al, 0
  lodflgs
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if4_exit
_if4_true:
  mov b, [bp + 5] ; n
  leave
  ret
  jmp _if4_exit
_if4_exit:
  sub sp, 2 ; x
  sub sp, 2 ; y
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov [bp + -1], a ; x
  pop a
  mov b, [bp + -1] ; x
  push a
  mov a, b
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov b, [bp + -1] ; x
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  push a
  mov a, b
  mov [bp + -3], a ; y
  pop a
_while5_cond:
  mov b, [bp + -3] ; y
  push a
  mov a, b
  mov b, [bp + -1] ; x
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while5_exit
_while5_block:
  mov b, [bp + -3] ; y
  push a
  mov a, b
  mov [bp + -1], a ; x
  pop a
  mov b, [bp + -1] ; x
  push a
  mov a, b
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov b, [bp + -1] ; x
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  push a
  mov a, b
  mov [bp + -3], a ; y
  pop a
  jmp _while5_cond
_while5_exit:
  mov b, [bp + -1] ; x
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
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
