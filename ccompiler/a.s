; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; a
  mov b, 5
  push a
  mov a, b
  mov [bp + -1], a ; a
  pop a
  sub sp, 2 ; b
  mov b, 10
  push a
  mov a, b
  mov [bp + -3], a ; b
  pop a
  sub sp, 2 ; c
  mov b, 0
  push a
  mov a, b
  mov [bp + -5], a ; c
  pop a
  sub sp, 1 ; d
  mov b, 'X'
  push al
  mov al, bl
  mov [bp + -6], al ; d
  pop al
  mov b, [bp + -1] ; a
  push a
  mov a, b
  mov b, [bp + -3] ; b
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 15
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -3] ; b
  push a
  mov a, b
  mov b, [bp + -1] ; a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 5
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -1] ; a
  push a
  mov a, b
  mov b, [bp + -3] ; b
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 50
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -3] ; b
  push a
  mov a, b
  mov b, [bp + -1] ; a
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  push a
  mov a, b
  mov b, 2
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -1] ; a
  push a
  mov a, b
  mov b, [bp + -3] ; b
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -3] ; b
  push a
  mov a, b
  mov b, [bp + -1] ; a
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -1] ; a
  push a
  mov a, b
  mov b, 5
  cmp a, b
  lodflgs
  and al, %00000011 ; <=
  cmp al, 0
  lodflgs
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -3] ; b
  push a
  mov a, b
  mov b, 10
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
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -1] ; a
  push a
  mov a, b
  mov b, 5
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -3] ; b
  push a
  mov a, b
  mov b, 5
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -1] ; a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [bp + -3] ; b
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -1] ; a
  push a
  mov a, b
  mov b, [bp + -5] ; c
  or a, b
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -5] ; c
  push al
  cmp b, 0
  lodflgs
  and al, %00000001 ; transform logical not condition result into a single bit
  mov bl, al
  mov bh, 0
  pop al
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -1] ; a
  push a
  mov a, b
  mov b, [bp + -3] ; b
  and a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -1] ; a
  push a
  mov a, b
  mov b, [bp + -3] ; b
  or a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 15
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -1] ; a
  push a
  mov a, b
  mov b, [bp + -3] ; b
  xor a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 15
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -1] ; a
  not b
  push a
  mov a, b
  mov b, 6
  neg b
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -1] ; a
  push a
  mov a, b
  mov b, 1
  push c
  mov c, b
  mov b, a
  shl b, cl
  pop c
  pop a
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -3] ; b
  push a
  mov a, b
  mov b, 1
  push c
  mov c, b
  mov b, a
  shr b, cl
  pop c
  pop a
  push a
  mov a, b
  mov b, 5
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -1] ; a
  push a
  mov a, b
  mov [bp + -5], a ; c
  pop a
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, 5
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, [bp + -1] ; a
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -5], a ; c
  pop a
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, [bp + -1] ; a
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -5], a ; c
  pop a
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, 15
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, [bp + -1] ; a
  mul a, b
  pop a
  push a
  mov a, b
  mov [bp + -5], a ; c
  pop a
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, 75
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, [bp + -1] ; a
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  push a
  mov a, b
  mov [bp + -5], a ; c
  pop a
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, 15
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, [bp + -1] ; a
  div a, b
  pop a
  push a
  mov a, b
  mov [bp + -5], a ; c
  pop a
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, 1
  push c
  mov c, b
  mov b, a
  shl b, cl
  pop c
  pop a
  push a
  mov a, b
  mov [bp + -5], a ; c
  pop a
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, 1
  or a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -5], a ; c
  pop a
  mov b, [bp + -5] ; c
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
_if1_cond:
  mov b, [bp + -1] ; a
  push a
  mov a, b
  mov b, [bp + -3] ; b
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if1_else
_if1_true:
  mov b, 1
  swp b
  push b
  call assert
  add sp, 2
  jmp _if1_exit
_if1_else:
  mov b, 0
  swp b
  push b
  call assert
  add sp, 2
_if1_exit:
_switch2_expr:
  mov bl, [bp + -6] ; d
  mov bh, 0
_switch2_comparisons:
  cmp bl, 'X'
  je _switch2_case0
  cmp bl, 'Y'
  je _switch2_case1
  jmp _switch2_default
_switch2_case0:
  mov b, 1
  swp b
  push b
  call assert
  add sp, 2
  jmp _switch2_exit ; case break
_switch2_case1:
  mov b, 0
  swp b
  push b
  call assert
  add sp, 2
  jmp _switch2_exit ; case break
_switch2_default:
  mov b, 0
  swp b
  push b
  call assert
  add sp, 2
  jmp _switch2_exit ; case break
_switch2_exit:
  sub sp, 2 ; i
  mov b, 0
  push a
  mov a, b
  mov [bp + -8], a ; i
  pop a
_while3_cond:
  mov b, [bp + -8] ; i
  push a
  mov a, b
  mov b, 5
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while3_exit
_while3_block:
  mov b, [bp + -8] ; i
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -8], a ; i
  pop a
  mov b, a
  pop a
  jmp _while3_cond
_while3_exit:
  mov b, [bp + -8] ; i
  push a
  mov a, b
  mov b, 5
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  sub sp, 2 ; j
  mov b, 0
  push a
  mov a, b
  mov [bp + -10], a ; j
  pop a
_do4_block:
  mov b, [bp + -10] ; j
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -10], a ; j
  pop a
  mov b, a
  pop a
_do4_cond:
  mov b, [bp + -10] ; j
  push a
  mov a, b
  mov b, 5
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 1
  je _do4_block
_do4_exit:
  mov b, [bp + -10] ; j
  push a
  mov a, b
  mov b, 5
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  sub sp, 2 ; k
_for5_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -12], a ; k
  pop a
_for5_cond:
  mov b, [bp + -12] ; k
  push a
  mov a, b
  mov b, 5
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for5_exit
_for5_block:
  mov b, [bp + -12] ; k
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
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [bp + -12] ; k
  push a
  mov a, b
  mov b, 5
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  swp b
  push b
  call assert
  add sp, 2
_for5_update:
  mov b, [bp + -12] ; k
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -12], a ; k
  pop a
  mov b, a
  pop a
  jmp _for5_cond
_for5_exit:
  mov b, [bp + -1] ; a
  swp b
  push b
  mov b, [bp + -3] ; b
  swp b
  push b
  call add
  add sp, 4
  push a
  mov a, b
  mov b, 15
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call assert
  add sp, 2
  mov b, 0
  leave
  syscall sys_terminate_proc

assert:
  push bp
  mov bp, sp
_if6_cond:
  mov b, [bp + 5] ; i
  cmp b, 0
  je _if6_else
_if6_true:
  mov b, __string_0 ; "Passed."
  swp b
  push b
  call print
  add sp, 2
  jmp _if6_exit
_if6_else:
  mov b, __string_1 ; "FAILED."
  swp b
  push b
  call print
  add sp, 2
_if6_exit:
  mov b, __string_2 ; "Index: "
  swp b
  push b
  mov b, [__index] ; index
  swp b
  push b
  call printn
  add sp, 4
  mov b, __string_3 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [__index] ; index
  push a
  mov a, b
  inc b
  mov [__index], b
  mov b, a
  pop a
  leave
  ret

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
__index: .dw 0
__string_0: .db "Passed.", 0
__string_1: .db "FAILED.", 0
__string_2: .db "Index: ", 0
__string_3: .db "\n", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
