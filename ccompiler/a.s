; --- FILENAME: life2.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  sub sp, 2 ; row
  sub sp, 2 ; col
  sub sp, 2 ; gen
_for1_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; row
  pop a
_for1_cond:
  mov b, [bp + -1] ; row
  push a
  mov a, b
  mov b, [ROWS]
  cmp a, b
  lodflgs
  and al, %00000010
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
  mov [bp + -3], a ; col
  pop a
_for2_cond:
  mov b, [bp + -3] ; col
  push a
  mov a, b
  mov b, [COLS]
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for2_exit
_for2_block:
  mov b, [current_gen]
  mov d, b
  mov b, [bp + -1] ; row
  mov a, 100
  mul a, b
  add d, b
  mov b, [bp + -3] ; col
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [bp + -1] ; row
  push a
  mov a, b
  mov b, [bp + -3] ; col
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  div a, b
  pop a
  pop d
  mov a, b
  mov [d], a
_for2_update:
  mov b, [bp + -3] ; col
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; col
  pop a
  jmp _for2_cond
_for2_exit:
_for1_update:
  mov b, [bp + -1] ; row
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; row
  pop a
  jmp _for1_cond
_for1_exit:
_for3_init:
  mov b, 1
  push a
  mov a, b
  mov [bp + -5], a ; gen
  pop a
_for3_cond:
  mov b, [bp + -5] ; gen
  push a
  mov a, b
  mov b, 100
  cmp a, b
  lodflgs
  and al, %00000011
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for3_exit
_for3_block:
  call compute_next_gen
  call copy_next_gen
  call print_cells
_for3_update:
  mov b, [bp + -5] ; gen
  inc b
  push a
  mov a, b
  mov [bp + -5], a ; gen
  pop a
  jmp _for3_cond
_for3_exit:
  mov b, 0
  leave
  syscall sys_terminate_proc
count_neighbors:
  push bp
  mov bp, sp
  sub sp, 2 ; count
  sub sp, 2 ; i
  sub sp, 2 ; j
  sub sp, 2 ; r
  sub sp, 2 ; c
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
_for4_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; i
  pop a
_for4_cond:
  mov b, [bp + -3] ; i
  push a
  mov a, b
  mov b, 3
  cmp a, b
  lodflgs
  and al, %00000010
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
  mov [bp + -5], a ; j
  pop a
_for5_cond:
  mov b, [bp + -5] ; j
  push a
  mov a, b
  mov b, 3
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for5_exit
_for5_block:
  mov b, [bp + 7] ; row
  push a
  mov a, b
  mov b, [bp + -3] ; i
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [ROWS]
  div a, b
  pop a
  push a
  mov a, b
  mov [bp + -7], a ; r
  pop a
  mov b, [bp + 5] ; col
  push a
  mov a, b
  mov b, [bp + -5] ; j
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [COLS]
  div a, b
  pop a
  push a
  mov a, b
  mov [bp + -9], a ; c
  pop a
_if6_cond:
  mov b, [bp + -7] ; r
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if6_exit
_if6_true:
  mov b, [bp + -7] ; r
  push a
  mov a, b
  mov b, [ROWS]
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -7], a ; r
  pop a
  jmp _if6_exit
_if6_exit:
_if7_cond:
  mov b, [bp + -9] ; c
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if7_exit
_if7_true:
  mov b, [bp + -9] ; c
  push a
  mov a, b
  mov b, [COLS]
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -9], a ; c
  pop a
  jmp _if7_exit
_if7_exit:
  mov b, [bp + -1] ; count
  push a
  mov a, b
  mov b, [current_gen]
  mov d, b
  mov b, [bp + -7] ; r
  mov a, 100
  mul a, b
  add d, b
  mov b, [bp + -9] ; c
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
_for5_update:
  mov b, [bp + -5] ; j
  inc b
  push a
  mov a, b
  mov [bp + -5], a ; j
  pop a
  jmp _for5_cond
_for5_exit:
_for4_update:
  mov b, [bp + -3] ; i
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; i
  pop a
  jmp _for4_cond
_for4_exit:
  mov b, [bp + -1] ; count
  push a
  mov a, b
  mov b, [current_gen]
  mov d, b
  mov b, [bp + 7] ; row
  mov a, 100
  mul a, b
  add d, b
  mov b, [bp + 5] ; col
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, [bp + -1] ; count
  leave
  ret
compute_next_gen:
  push bp
  mov bp, sp
  sub sp, 2 ; row
  sub sp, 2 ; col
  sub sp, 2 ; neighbors
_for8_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; row
  pop a
_for8_cond:
  mov b, [bp + -1] ; row
  push a
  mov a, b
  mov b, [ROWS]
  cmp a, b
  lodflgs
  and al, %00000010
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
  mov [bp + -3], a ; col
  pop a
_for9_cond:
  mov b, [bp + -3] ; col
  push a
  mov a, b
  mov b, [COLS]
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for9_exit
_for9_block:
  mov b, [bp + -1] ; row
  swp b
  push b
  mov b, [bp + -3] ; col
  swp b
  push b
  call count_neighbors
  add sp, 4
  push a
  mov a, b
  mov [bp + -5], a ; neighbors
  pop a
_if10_cond:
  mov b, [current_gen]
  mov d, b
  mov b, [bp + -1] ; row
  mov a, 100
  mul a, b
  add d, b
  mov b, [bp + -3] ; col
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if10_else
_if10_true:
_if11_cond:
  mov b, [bp + -5] ; neighbors
  push a
  mov a, b
  mov b, 2
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [bp + -5] ; neighbors
  push a
  mov a, b
  mov b, 3
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, %00000000
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  or a, b
  mov b, a
  pop a
  cmp b, 0
  je _if11_else
_if11_true:
  mov b, [next_gen]
  mov d, b
  mov b, [bp + -1] ; row
  mov a, 100
  mul a, b
  add d, b
  mov b, [bp + -3] ; col
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
  jmp _if11_exit
_if11_else:
  mov b, [next_gen]
  mov d, b
  mov b, [bp + -1] ; row
  mov a, 100
  mul a, b
  add d, b
  mov b, [bp + -3] ; col
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 1
  pop d
  mov a, b
  mov [d], a
_if11_exit:
  jmp _if10_exit
_if10_else:
_if12_cond:
  mov b, [bp + -5] ; neighbors
  push a
  mov a, b
  mov b, 3
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if12_else
_if12_true:
  mov b, [next_gen]
  mov d, b
  mov b, [bp + -1] ; row
  mov a, 100
  mul a, b
  add d, b
  mov b, [bp + -3] ; col
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 1
  pop d
  mov a, b
  mov [d], a
  jmp _if12_exit
_if12_else:
  mov b, [next_gen]
  mov d, b
  mov b, [bp + -1] ; row
  mov a, 100
  mul a, b
  add d, b
  mov b, [bp + -3] ; col
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_if12_exit:
_if10_exit:
_for9_update:
  mov b, [bp + -3] ; col
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; col
  pop a
  jmp _for9_cond
_for9_exit:
_for8_update:
  mov b, [bp + -1] ; row
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; row
  pop a
  jmp _for8_cond
_for8_exit:
  leave
  ret
copy_next_gen:
  push bp
  mov bp, sp
  sub sp, 2 ; row
  sub sp, 2 ; col
_for13_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; row
  pop a
_for13_cond:
  mov b, [bp + -1] ; row
  push a
  mov a, b
  mov b, [ROWS]
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for13_exit
_for13_block:
_for14_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; col
  pop a
_for14_cond:
  mov b, [bp + -3] ; col
  push a
  mov a, b
  mov b, [COLS]
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for14_exit
_for14_block:
  mov b, [current_gen]
  mov d, b
  mov b, [bp + -1] ; row
  mov a, 100
  mul a, b
  add d, b
  mov b, [bp + -3] ; col
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [next_gen]
  mov d, b
  mov b, [bp + -1] ; row
  mov a, 100
  mul a, b
  add d, b
  mov b, [bp + -3] ; col
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop d
  mov a, b
  mov [d], a
_for14_update:
  mov b, [bp + -3] ; col
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; col
  pop a
  jmp _for14_cond
_for14_exit:
_for13_update:
  mov b, [bp + -1] ; row
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; row
  pop a
  jmp _for13_cond
_for13_exit:
  leave
  ret
prints:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [bp + 5]
  mov d, a
  call puts
; --- END INLINE ASM BLOCK

  leave
  ret
print_cells:
  push bp
  mov bp, sp
  sub sp, 2 ; row
  sub sp, 2 ; col
  mov b, _string_0
  swp b
  push b
  call prints
  add sp, 2
_for15_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; row
  pop a
_for15_cond:
  mov b, [bp + -1] ; row
  push a
  mov a, b
  mov b, [ROWS]
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for15_exit
_for15_block:
_for16_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; col
  pop a
_for16_cond:
  mov b, [bp + -3] ; col
  push a
  mov a, b
  mov b, [COLS]
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for16_exit
_for16_block:
_if17_cond:
  mov b, [current_gen]
  mov d, b
  mov b, [bp + -1] ; row
  mov a, 100
  mul a, b
  add d, b
  mov b, [bp + -3] ; col
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if17_else
_if17_true:
  mov b, _string_1
  swp b
  push b
  call prints
  add sp, 2
  jmp _if17_exit
_if17_else:
  mov b, _string_2
  swp b
  push b
  call prints
  add sp, 2
_if17_exit:
_for16_update:
  mov b, [bp + -3] ; col
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; col
  pop a
  jmp _for16_cond
_for16_exit:
  mov b, _string_3
  swp b
  push b
  call prints
  add sp, 2
_for15_update:
  mov b, [bp + -1] ; row
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; row
  pop a
  jmp _for15_cond
_for15_exit:
  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
ROWS: .dw 50
COLS: .dw 50
current_gen_data: .fill 2500, 0
current_gen: .dw current_gen_data
next_gen_data: .fill 2500, 0
next_gen: .dw next_gen_data
_string_0: .db "\033[2J", 0
_string_1: .db "#", 0
_string_2: .db ".", 0
_string_3: .db "\n", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
