; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
_while1_cond:
  mov b, 1
  cmp b, 0
  je _while1_exit
_while1_block:
  mov b, __string_0 ; "Number: "
  swp b
  push b
  call print
  add sp, 2
  call scann
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_if2_cond:
  mov b, [bp + -1] ; i
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
  mov b, 0
  leave
  syscall sys_terminate_proc
  jmp _if2_exit
_if2_else:
  mov b, [bp + -1] ; i
  swp b
  push b
  call integer_square_root
  add sp, 2
  swp b
  push b
  call print_num
  add sp, 2
_if2_exit:
  mov b, __string_1 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  jmp _while1_cond
_while1_exit:
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
_if3_cond:
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
  je _if3_exit
_if3_true:
  mov b, '0'
  push bl
  call _putchar
  add sp, 1
  leave
  ret
  jmp _if3_exit
_if3_exit:
_while4_cond:
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
  je _while4_exit
_while4_block:
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
  jmp _while4_cond
_while4_exit:
_while5_cond:
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
  je _while5_exit
_while5_block:
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
  jmp _while5_cond
_while5_exit:
  leave
  ret

integer_square_root:
  push bp
  mov bp, sp
_if6_cond:
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
  je _if6_exit
_if6_true:
  mov b, [bp + 5] ; n
  leave
  ret
  jmp _if6_exit
_if6_exit:
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
_while7_cond:
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
  je _while7_exit
_while7_block:
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
  jmp _while7_cond
_while7_exit:
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

  mov b, [bp + -1] ; m
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
__string_0: .db "Number: ", 0
__string_1: .db "\n", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
