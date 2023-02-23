; --- FILENAME: _matrix.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  sub sp, 1 ; c
  sub sp, 2 ; i
  sub sp, 2 ; w
  sub sp, 2 ; h
  sub sp, 2 ; ii
  sub sp, 2 ; start
_while1_cond:
  mov b, 1
  cmp b, 0
  je _while1_exit
_while1_block:
  mov b, [bp + -4] ; w
  inc b
  push a
  mov a, b
  mov [bp + -4], a ; w
  pop a
_if2_cond:
  mov b, [bp + -4] ; w
  push a
  mov a, b
  mov b, 80
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if2_exit
_if2_true:
  mov b, 0
  push a
  mov a, b
  mov [bp + -4], a ; w
  pop a
  jmp _if2_exit
_if2_exit:
  mov b, [bp + -6] ; h
  inc b
  push a
  mov a, b
  mov [bp + -6], a ; h
  pop a
_if3_cond:
  mov b, [bp + -6] ; h
  push a
  mov a, b
  mov b, 24
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if3_exit
_if3_true:
  mov b, [bp + -8] ; ii
  push a
  mov a, b
  mov [bp + -6], a ; h
  pop a
_if4_cond:
  mov b, [bp + -8] ; ii
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if4_else
_if4_true:
  mov b, 1
  push a
  mov a, b
  mov [bp + -8], a ; ii
  pop a
  jmp _if4_exit
_if4_else:
  mov b, 0
  push a
  mov a, b
  mov [bp + -8], a ; ii
  pop a
_if4_exit:
  jmp _if3_exit
_if3_exit:
  mov b, [bp + -2] ; i
  inc b
  push a
  mov a, b
  mov [bp + -2], a ; i
  pop a
_if5_cond:
  mov b, [bp + -2] ; i
  push a
  mov a, b
  mov b, 33
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if5_exit
_if5_true:
  mov b, 0
  push a
  mov a, b
  mov [bp + -2], a ; i
  pop a
  jmp _if5_exit
_if5_exit:
_if6_cond:
  mov b, [bp + -10] ; start
  push a
  mov a, b
  mov b, 100
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if6_exit
_if6_true:
  mov b, 0
  push a
  mov a, b
  mov [bp + -10], a ; start
  pop a
  jmp _if6_exit
_if6_exit:
  jmp _while1_cond
_while1_exit:
  mov b, 0
  leave
  syscall sys_terminate_proc
print:
  push bp
  mov bp, sp
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
str_data: .db "\033[38;2;8;202;40m", 0
str: .dw str_data
strWhite_data: .db "\033[38;2;255;255;255m", 0
strWhite: .dw strWhite_data
rnd_w_data: .dw 15, 65, 1, 39, 11, 8, 76, 27, 22, 31, 7, 33, 21, 49, 58, 53, 12, 79, 16, 4, 62, 30, 46, 67, 60, 35, 28, 47, 29, 57, 42, 23, 43, 54, 19, 34, 56, 41, 3, 5, 48, 71, 36, 32, 40, 25, 51, 55, 20, 14, 72, 26, 6, 70, 18, 77, 38, 73, 74, 13, 80, 75, 45, 10, 69, 24, 63, 52, 50, 61, 59, 66, 2, 37, 17, 68, 9, 78, 64, 44, 
rnd_w: .dw rnd_w_data
rnd_h_data: .dw 13, 24, 19, 16, 15, 21, 22, 23, 10, 3, 8, 14, 5, 6, 7, 17, 2, 11, 18, 1, 20, 9, 12, 4, 
rnd_h: .dw rnd_h_data
ii: .dw 100
c_ref_data: .db '9', ''', '.', '3', '5', '#', ',', ':', '%', ';', '"', ')', '2', '/', '<', '(', '*', '7', '$', '!', '1', '6', '4', '&', '-', '8', '=', '0', '+', '>', '\', ' ', 
c_ref: .dw c_ref_data
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
