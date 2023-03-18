; --- FILENAME: tree.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
  sub sp, 2 ; initial_angle
  mov b, 90
  push a
  mov a, b
  mov b, 1000
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 180
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  push a
  mov a, b
  mov [bp + -5], a ; initial_angle
  pop a
_for1_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for1_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 22
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl ; < (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for1_exit
_for1_block:
_for2_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for2_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 80
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl ; < (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for2_exit
_for2_block:
  mov b, [__canvas] ; canvas
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -3] ; j
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  push d
  mov b, $20
  pop d
  mov [d], bl
_for2_update:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
  mov b, a
  pop a
  jmp _for2_cond
_for2_exit:
_for1_update:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  mov b, a
  pop a
  jmp _for1_cond
_for1_exit:
  mov b, 40
  swp b
  push b
  mov b, 21
  swp b
  push b
  mov b, [bp + -5] ; initial_angle
  swp b
  push b
  mov b, 5
  swp b
  push b
  mov b, [__canvas] ; canvas
  swp b
  push b
  call draw_tree
  add sp, 10
_for3_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for3_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 22
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl ; < (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for3_exit
_for3_block:
_for4_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for4_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 80
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl ; < (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for4_exit
_for4_block:
  mov b, [__canvas] ; canvas
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -3] ; j
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
  mov b, [bp + -3] ; j
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
  mov b, a
  pop a
  jmp _for4_cond
_for4_exit:
  mov b, $a
  push bl
  call _putchar
  add sp, 1
_for3_update:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  mov b, a
  pop a
  jmp _for3_cond
_for3_exit:
  mov b, 0
  leave
  syscall sys_terminate_proc

draw_tree:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; length_factor
  sub sp, 2 ; angle_factor
  sub sp, 2 ; x_pos
  sub sp, 2 ; y_pos
  sub sp, 2 ; x2
  sub sp, 2 ; y2
  sub sp, 2 ; new_angle_left
  sub sp, 2 ; new_angle_right
_if5_cond:
  mov b, [bp + 7] ; depth
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
  je _if5_exit
_if5_true:
  leave
  ret
  jmp _if5_exit
_if5_exit:
  mov b, 6
  push a
  mov a, b
  mov [bp + -3], a ; length_factor
  pop a
  mov b, 5
  push a
  mov a, b
  mov [bp + -5], a ; angle_factor
  pop a
  mov b, [bp + 13] ; x
  push a
  mov a, b
  mov b, [bp + 7] ; depth
  push a
  mov a, b
  mov b, [bp + -3] ; length_factor
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [bp + 9] ; angle
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1000
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
  mov [bp + -11], a ; x2
  pop a
  mov b, [bp + 11] ; y
  push a
  mov a, b
  mov b, [bp + 7] ; depth
  push a
  mov a, b
  mov b, [bp + -3] ; length_factor
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1000
  push a
  mov a, b
  mov b, [bp + 9] ; angle
  sub a, b
  mov b, a
  pop a
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1000
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -13], a ; y2
  pop a
  mov b, [bp + -11] ; x2
  swp b
  push b
  call print_num
  add sp, 2
  mov b, __string_0 ; ", "
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + -13] ; y2
  swp b
  push b
  call print_num
  add sp, 2
_if6_cond:
  mov b, [bp + -11] ; x2
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl ; < (signed)
  mov ah, 0
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [bp + -11] ; x2
  push a
  mov a, b
  mov b, 80
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl
  xor al, %00000001 ; >= (signed)
  mov ah, 0
  mov b, a
  pop a
  or a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [bp + -13] ; y2
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl ; < (signed)
  mov ah, 0
  mov b, a
  pop a
  or a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [bp + -13] ; y2
  push a
  mov a, b
  mov b, 22
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl
  xor al, %00000001 ; >= (signed)
  mov ah, 0
  mov b, a
  pop a
  or a, b
  mov b, a
  pop a
  cmp b, 0
  je _if6_exit
_if6_true:
  mov b, __string_1 ; "exit"
  swp b
  push b
  call print
  add sp, 2
  leave
  ret
  jmp _if6_exit
_if6_exit:
_for7_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for7_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, [bp + 7] ; depth
  cmp a, b
  lodflgs
  mov bl, al
  mov g, a
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl
  mov b, g
  and bl, %00000001
  or al, bl ; <= (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for7_exit
_for7_block:
  mov b, __string_2 ; "OK"
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + 13] ; x
  push a
  mov a, b
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, [bp + -3] ; length_factor
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [bp + 9] ; angle
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1000
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
  mov [bp + -7], a ; x_pos
  pop a
  mov b, [bp + 11] ; y
  push a
  mov a, b
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, [bp + -3] ; length_factor
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1000
  push a
  mov a, b
  mov b, [bp + 9] ; angle
  sub a, b
  mov b, a
  pop a
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1000
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -9], a ; y_pos
  pop a
_if8_cond:
  mov b, [bp + -7] ; x_pos
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl
  xor al, %00000001 ; >= (signed)
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [bp + -7] ; x_pos
  push a
  mov a, b
  mov b, 80
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl ; < (signed)
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
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [bp + -9] ; y_pos
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl
  xor al, %00000001 ; >= (signed)
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
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [bp + -9] ; y_pos
  push a
  mov a, b
  mov b, 22
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl ; < (signed)
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
  cmp b, 0
  je _if8_exit
_if8_true:
  lea d, [bp + 5] ; canvas
  mov b, [d]
  push a
  mov d, b
  push d
  mov b, [bp + -9] ; y_pos
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -7] ; x_pos
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  push d
  mov b, $2a
  pop d
  mov [d], bl
  jmp _if8_exit
_if8_exit:
_for7_update:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  mov b, a
  pop a
  jmp _for7_cond
_for7_exit:
  mov b, [bp + 9] ; angle
  push a
  mov a, b
  mov b, [bp + -5] ; angle_factor
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -15], a ; new_angle_left
  pop a
  mov b, [bp + 9] ; angle
  push a
  mov a, b
  mov b, [bp + -5] ; angle_factor
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -17], a ; new_angle_right
  pop a
  mov b, [bp + -11] ; x2
  swp b
  push b
  mov b, [bp + -13] ; y2
  swp b
  push b
  mov b, [bp + -15] ; new_angle_left
  swp b
  push b
  mov b, [bp + 7] ; depth
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  swp b
  push b
  lea d, [bp + 5] ; canvas
  mov b, [d]
  swp b
  push b
  call draw_tree
  add sp, 10
  mov b, [bp + -11] ; x2
  swp b
  push b
  mov b, [bp + -13] ; y2
  swp b
  push b
  mov b, [bp + -17] ; new_angle_right
  swp b
  push b
  mov b, [bp + 7] ; depth
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  swp b
  push b
  lea d, [bp + 5] ; canvas
  mov b, [d]
  swp b
  push b
  call draw_tree
  add sp, 10
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

print_num:
  push bp
  mov bp, sp
  sub sp, 10 ; digits
  sub sp, 2 ; i
  sub sp, 2 ; j
  mov b, 0
  push a
  mov a, b
  mov [bp + -11], a ; i
  pop a
_if9_cond:
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
  je _if9_exit
_if9_true:
  mov b, $30
  push bl
  call _putchar
  add sp, 1
  leave
  ret
  jmp _if9_exit
_if9_exit:
_if10_cond:
  mov b, [bp + 5] ; num
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl ; < (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if10_exit
_if10_true:
  mov b, $2d
  push bl
  call _putchar
  add sp, 1
  mov b, [bp + 5] ; num
  neg b
  push a
  mov a, b
  mov [bp + 5], a ; num
  pop a
  jmp _if10_exit
_if10_exit:
_while11_cond:
  mov b, [bp + 5] ; num
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  mov bl, al
  mov g, a
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl
  mov b, g
  and bl, %00000001
  or al, bl
  xor al, %00000001 ; > (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while11_exit
_while11_block:
  lea d, [bp + -9] ; digits beginning on the stack
  mov b, d
  push a
  mov d, b
  push d
  mov b, [bp + -11] ; i
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [bp + 5] ; num
  push a
  mov a, b
  mov b, 10
  div a, b
  pop a
  pop d
  mov [d], b
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
  mov b, [bp + -11] ; i
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -11], a ; i
  pop a
  mov b, a
  pop a
  jmp _while11_cond
_while11_exit:
_for12_init:
  mov b, [bp + -11] ; i
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -13], a ; j
  pop a
_for12_cond:
  mov b, [bp + -13] ; j
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl
  xor al, %00000001 ; >= (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for12_exit
_for12_block:
  lea d, [bp + -9] ; digits beginning on the stack
  mov b, d
  push a
  mov d, b
  push d
  mov b, [bp + -13] ; j
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, $30
  add a, b
  mov b, a
  pop a
  push bl
  call _putchar
  add sp, 1
_for12_update:
  mov b, [bp + -13] ; j
  push a
  mov a, b
  dec b
  push a
  mov a, b
  mov [bp + -13], a ; j
  pop a
  mov b, a
  pop a
  jmp _for12_cond
_for12_exit:
  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
__canvas_data: .fill 1760, 0
__canvas: .dw __canvas_data
__string_0: .db ", ", 0
__string_1: .db "exit", 0
__string_2: .db "OK", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
