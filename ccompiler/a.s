; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
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
  mov b, [__ROWS] ; ROWS
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
  mov b, [__COLS] ; COLS
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
  mov b, [__board] ; board
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
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 2
  div a, b
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
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
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for3_exit
_for3_block:
  mov b, __string_0 ; "Iteration :"
  swp b
  push b
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  swp b
  push b
  call printn
  add sp, 4
  mov b, __string_1 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [__board] ; board
  swp b
  push b
  call display_board
  add sp, 2
  mov b, [__board] ; board
  swp b
  push b
  call update_board
  add sp, 2
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

display_board:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
_for4_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for4_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, [__ROWS] ; ROWS
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for4_exit
_for4_block:
_for5_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for5_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, [__COLS] ; COLS
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
_ternary7_cond:
  lea d, [bp + 5] ; board
  mov b, [d]
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
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  cmp b, 0
  je _ternary7_false
_ternary7_true:
  mov b, __string_2 ; "X"
  jmp _ternary7_exit
_ternary7_false:
  mov b, __string_3 ; " "
_ternary7_exit:
  swp b
  push b
  call print
  add sp, 2
_for5_update:
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
  jmp _for5_cond
_for5_exit:
  mov b, __string_1 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for4_update:
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
  jmp _for4_cond
_for4_exit:

update_board:
  push bp
  mov bp, sp
  sub sp, 2 ; dx
  sub sp, 2 ; dy
  sub sp, 2 ; i
  sub sp, 2 ; j
  sub sp, 2 ; count
  sub sp, 2 ; x
  sub sp, 2 ; y
_for8_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -5], a ; i
  pop a
_for8_cond:
  mov b, [bp + -5] ; i
  push a
  mov a, b
  mov b, [__ROWS] ; ROWS
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for8_exit
_for8_block:
_for9_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -7], a ; j
  pop a
_for9_cond:
  mov b, [bp + -7] ; j
  push a
  mov a, b
  mov b, [__COLS] ; COLS
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for9_exit
_for9_block:
  mov b, 0
  push a
  mov a, b
  mov [bp + -9], a ; count
  pop a
_for10_init:
  mov b, 1
  neg b
  push a
  mov a, b
  mov [bp + -1], a ; dx
  pop a
_for10_cond:
  mov b, [bp + -1] ; dx
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
  je _for10_exit
_for10_block:
_for11_init:
  mov b, 1
  neg b
  push a
  mov a, b
  mov [bp + -3], a ; dy
  pop a
_for11_cond:
  mov b, [bp + -3] ; dy
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
  je _for11_exit
_for11_block:
_if12_cond:
  mov b, [bp + -1] ; dx
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [bp + -3] ; dy
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
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
  je _if12_exit
_if12_true:
  jmp _for11_cond ; for continue
  jmp _if12_exit
_if12_exit:
  mov b, [bp + -5] ; i
  push a
  mov a, b
  mov b, [bp + -1] ; dx
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -11], a ; x
  pop a
  mov b, [bp + -7] ; j
  push a
  mov a, b
  mov b, [bp + -3] ; dy
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -13], a ; y
  pop a
_if13_cond:
  mov b, [bp + -11] ; x
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if13_else
_if13_true:
  mov b, [__ROWS] ; ROWS
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -11], a ; x
  pop a
  jmp _if13_exit
_if13_else:
_if14_cond:
  mov b, [bp + -11] ; x
  push a
  mov a, b
  mov b, [__ROWS] ; ROWS
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
  je _if14_exit
_if14_true:
  mov b, 0
  push a
  mov a, b
  mov [bp + -11], a ; x
  pop a
  jmp _if14_exit
_if14_exit:
_if13_exit:
_if15_cond:
  mov b, [bp + -13] ; y
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if15_else
_if15_true:
  mov b, [__COLS] ; COLS
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -13], a ; y
  pop a
  jmp _if15_exit
_if15_else:
_if16_cond:
  mov b, [bp + -13] ; y
  push a
  mov a, b
  mov b, [__COLS] ; COLS
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
  je _if16_exit
_if16_true:
  mov b, 0
  push a
  mov a, b
  mov [bp + -13], a ; y
  pop a
  jmp _if16_exit
_if16_exit:
_if15_exit:
_if17_cond:
  lea d, [bp + 5] ; board
  mov b, [d]
  push a
  mov d, b
  push d
  mov b, [bp + -11] ; x
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -13] ; y
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  cmp b, 0
  je _if17_exit
_if17_true:
  mov b, [bp + -9] ; count
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -9], a ; count
  pop a
  mov b, a
  pop a
  jmp _if17_exit
_if17_exit:
_for11_update:
  mov b, [bp + -3] ; dy
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; dy
  pop a
  mov b, a
  pop a
  jmp _for11_cond
_for11_exit:
_for10_update:
  mov b, [bp + -1] ; dx
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; dx
  pop a
  mov b, a
  pop a
  jmp _for10_cond
_for10_exit:
_if18_cond:
  lea d, [bp + 5] ; board
  mov b, [d]
  push a
  mov d, b
  push d
  mov b, [bp + -5] ; i
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -7] ; j
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  cmp b, 0
  je _if18_else
_if18_true:
  mov b, [__new_board] ; new_board
  push a
  mov d, b
  push d
  mov b, [bp + -5] ; i
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -7] ; j
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 2
  pop d
  mov [d], b
  jmp _if18_exit
_if18_else:
_if19_cond:
  mov b, [bp + -9] ; count
  push a
  mov a, b
  mov b, 2
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if19_exit
_if19_true:
  mov b, [__new_board] ; new_board
  push a
  mov d, b
  push d
  mov b, [bp + -5] ; i
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -7] ; j
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 1
  pop d
  mov [d], b
  jmp _if19_exit
_if19_exit:
_if18_exit:
_for9_update:
  mov b, [bp + -7] ; j
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -7], a ; j
  pop a
  mov b, a
  pop a
  jmp _for9_cond
_for9_exit:
_for8_update:
  mov b, [bp + -5] ; i
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -5], a ; i
  pop a
  mov b, a
  pop a
  jmp _for8_cond
_for8_exit:
_for20_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -5], a ; i
  pop a
_for20_cond:
  mov b, [bp + -5] ; i
  push a
  mov a, b
  mov b, [__ROWS] ; ROWS
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for20_exit
_for20_block:
_for21_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -7], a ; j
  pop a
_for21_cond:
  mov b, [bp + -7] ; j
  push a
  mov a, b
  mov b, [__COLS] ; COLS
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for21_exit
_for21_block:
  lea d, [bp + 5] ; board
  mov b, [d]
  push a
  mov d, b
  push d
  mov b, [bp + -5] ; i
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -7] ; j
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__new_board] ; new_board
  push a
  mov d, b
  push d
  mov b, [bp + -5] ; i
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -7] ; j
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for21_update:
  mov b, [bp + -7] ; j
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -7], a ; j
  pop a
  mov b, a
  pop a
  jmp _for21_cond
_for21_exit:
_for20_update:
  mov b, [bp + -5] ; i
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -5], a ; i
  pop a
  mov b, a
  pop a
  jmp _for20_cond
_for20_exit:

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
__ROWS: .dw 20
__COLS: .dw 40
__new_board_data: .fill 1600, 0
__new_board: .dw __new_board_data
__board_data: .fill 1600, 0
__board: .dw __board_data
__string_0: .db "Iteration :", 0
__string_1: .db "\n", 0
__string_2: .db "X", 0
__string_3: .db " ", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
