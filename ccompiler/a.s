; --- FILENAME: wireworld.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  mov b, [__grid] ; grid
  push a
  mov d, b
  push d
  mov b, 5
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, 5
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 1; CONDUCTOR
  pop d
  mov [d], b
  mov b, [__grid] ; grid
  push a
  mov d, b
  push d
  mov b, 6
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, 5
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 2; ELECTRON_HEAD
  pop d
  mov [d], b
  mov b, [__grid] ; grid
  push a
  mov d, b
  push d
  mov b, 7
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, 5
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 1; CONDUCTOR
  pop d
  mov [d], b
  mov b, [__grid] ; grid
  push a
  mov d, b
  push d
  mov b, 6
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, 6
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 3; ELECTRON_TAIL
  pop d
  mov [d], b
  mov b, [__grid] ; grid
  push a
  mov d, b
  push d
  mov b, 6
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, 7
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 1; CONDUCTOR
  pop d
  mov [d], b
_while1_cond:
  mov b, 1
  cmp b, 0
  je _while1_exit
_while1_block:
  call print_grid
  call iterate
  jmp _while1_cond
_while1_exit:
  mov b, 0
  leave
  syscall sys_terminate_proc

print_grid:
  push bp
  mov bp, sp
  sub sp, 2 ; y
  sub sp, 2 ; x
  sub sp, 1 ; c
_for2_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; y
  pop a
_for2_cond:
  mov b, [bp + -1] ; y
  push a
  mov a, b
  mov b, 20
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
_for3_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; x
  pop a
_for3_cond:
  mov b, [bp + -3] ; x
  push a
  mov a, b
  mov b, 40
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
_switch4_expr:
  mov b, [__grid] ; grid
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -3] ; x
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
_switch4_comparisons:
  je _switch4_case0
  je _switch4_case1
  je _switch4_case2
  je _switch4_case3
_switch4_case0:
  mov b, 0
  push al
  mov al, bl
  mov [bp + -4], al ; c
  pop al
  jmp _switch4_exit ; case break
_switch4_case1:
  mov b, 0
  push al
  mov al, bl
  mov [bp + -4], al ; c
  pop al
  jmp _switch4_exit ; case break
_switch4_case2:
  mov b, 0
  push al
  mov al, bl
  mov [bp + -4], al ; c
  pop al
  jmp _switch4_exit ; case break
_switch4_case3:
  mov b, 0
  push al
  mov al, bl
  mov [bp + -4], al ; c
  pop al
  jmp _switch4_exit ; case break
_switch4_exit:
  mov bl, [bp + -4] ; c
  mov bh, 0
  push bl
  call _putchar
  add sp, 1
_for3_update:
  mov b, [bp + -3] ; x
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; x
  pop a
  jmp _for3_cond
_for3_exit:
  mov b, 0
  push bl
  call _putchar
  add sp, 1
_for2_update:
  mov b, [bp + -1] ; y
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; y
  pop a
  jmp _for2_cond
_for2_exit:
  leave
  ret

iterate:
  push bp
  mov bp, sp
  sub sp, 2 ; x
  sub sp, 2 ; y
  sub sp, 2 ; dx
  sub sp, 2 ; dy
  sub sp, 2 ; nx
  sub sp, 2 ; ny
  sub sp, 2 ; head_count
_for5_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; y
  pop a
_for5_cond:
  mov b, [bp + -3] ; y
  push a
  mov a, b
  mov b, 20
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
  je _for5_exit
_for5_block:
_for6_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; x
  pop a
_for6_cond:
  mov b, [bp + -1] ; x
  push a
  mov a, b
  mov b, 40
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
  je _for6_exit
_for6_block:
  mov b, 0
  push a
  mov a, b
  mov [bp + -13], a ; head_count
  pop a
_for7_init:
  mov b, 1
  neg b
  push a
  mov a, b
  mov [bp + -7], a ; dy
  pop a
_for7_cond:
  mov b, [bp + -7] ; dy
  push a
  mov a, b
  mov b, 1
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
_for8_init:
  mov b, 1
  neg b
  push a
  mov a, b
  mov [bp + -5], a ; dx
  pop a
_for8_cond:
  mov b, [bp + -5] ; dx
  push a
  mov a, b
  mov b, 1
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
  je _for8_exit
_for8_block:
_if9_cond:
  mov b, [bp + -5] ; dx
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
  mov b, [bp + -7] ; dy
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
  je _if9_exit
_if9_true:
  jmp _for8_cond ; for continue
  jmp _if9_exit
_if9_exit:
  mov b, [bp + -1] ; x
  push a
  mov a, b
  mov b, [bp + -5] ; dx
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -9], a ; nx
  pop a
  mov b, [bp + -3] ; y
  push a
  mov a, b
  mov b, [bp + -7] ; dy
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -11], a ; ny
  pop a
_if10_cond:
  mov b, [bp + -9] ; nx
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
  mov b, [bp + -9] ; nx
  push a
  mov a, b
  mov b, 40
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
  mov b, [bp + -11] ; ny
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
  mov b, [bp + -11] ; ny
  push a
  mov a, b
  mov b, 20
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
  mov b, [__grid] ; grid
  push a
  mov d, b
  push d
  mov b, [bp + -11] ; ny
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -9] ; nx
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 2; ELECTRON_HEAD
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
  je _if10_exit
_if10_true:
  mov b, [bp + -13] ; head_count
  inc b
  push a
  mov a, b
  mov [bp + -13], a ; head_count
  pop a
  jmp _if10_exit
_if10_exit:
_for8_update:
  mov b, [bp + -5] ; dx
  inc b
  push a
  mov a, b
  mov [bp + -5], a ; dx
  pop a
  jmp _for8_cond
_for8_exit:
_for7_update:
  mov b, [bp + -7] ; dy
  inc b
  push a
  mov a, b
  mov [bp + -7], a ; dy
  pop a
  jmp _for7_cond
_for7_exit:
_switch11_expr:
  mov b, [__grid] ; grid
  push a
  mov d, b
  push d
  mov b, [bp + -3] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -1] ; x
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
_switch11_comparisons:
  je _switch11_case0
  je _switch11_case1
  je _switch11_case2
  je _switch11_case3
_switch11_case0:
  mov b, [__new_grid] ; new_grid
  push a
  mov d, b
  push d
  mov b, [bp + -3] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -1] ; x
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0; EMPTY
  pop d
  mov [d], b
  jmp _switch11_exit ; case break
_switch11_case1:
  mov b, [__new_grid] ; new_grid
  push a
  mov d, b
  push d
  mov b, [bp + -3] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -1] ; x
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
_ternary12_cond:
  mov b, [bp + -13] ; head_count
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [bp + -13] ; head_count
  push a
  mov a, b
  mov b, 2
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  or a, b
  mov b, a
  pop a
  cmp b, 0
  je _ternary12_false
_ternary12_true:
  mov b, 2; ELECTRON_HEAD
  jmp _ternary12_exit
_ternary12_false:
  mov b, 1; CONDUCTOR
_ternary12_exit:
  pop d
  mov [d], b
  jmp _switch11_exit ; case break
_switch11_case2:
  mov b, [__new_grid] ; new_grid
  push a
  mov d, b
  push d
  mov b, [bp + -3] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -1] ; x
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 3; ELECTRON_TAIL
  pop d
  mov [d], b
  jmp _switch11_exit ; case break
_switch11_case3:
  mov b, [__new_grid] ; new_grid
  push a
  mov d, b
  push d
  mov b, [bp + -3] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -1] ; x
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 1; CONDUCTOR
  pop d
  mov [d], b
  jmp _switch11_exit ; case break
_switch11_exit:
_for6_update:
  mov b, [bp + -1] ; x
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; x
  pop a
  jmp _for6_cond
_for6_exit:
_for5_update:
  mov b, [bp + -3] ; y
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; y
  pop a
  jmp _for5_cond
_for5_exit:
_for13_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; y
  pop a
_for13_cond:
  mov b, [bp + -3] ; y
  push a
  mov a, b
  mov b, 20
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
  je _for13_exit
_for13_block:
_for14_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; x
  pop a
_for14_cond:
  mov b, [bp + -1] ; x
  push a
  mov a, b
  mov b, 40
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
  je _for14_exit
_for14_block:
  mov b, [__grid] ; grid
  push a
  mov d, b
  push d
  mov b, [bp + -3] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -1] ; x
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__new_grid] ; new_grid
  push a
  mov d, b
  push d
  mov b, [bp + -3] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [bp + -1] ; x
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for14_update:
  mov b, [bp + -1] ; x
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; x
  pop a
  jmp _for14_cond
_for14_exit:
_for13_update:
  mov b, [bp + -3] ; y
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; y
  pop a
  jmp _for13_cond
_for13_exit:
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
__grid_data: .fill 1600, 0
__grid: .dw __grid_data
__new_grid_data: .fill 1600, 0
__new_grid: .dw __new_grid_data
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
