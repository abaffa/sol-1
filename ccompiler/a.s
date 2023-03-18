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
_for2_init:
  mov b, 0
  mov [__y], b
_for2_cond:
  mov b, [__y] ; y
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
  mov [__x], b
_for3_cond:
  mov b, [__x] ; x
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
  mov b, [__y] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [__x] ; x
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
_switch4_comparisons:
  cmp b, 0
  je _switch4_case0
  cmp b, 1
  je _switch4_case1
  cmp b, 2
  je _switch4_case2
  cmp b, 3
  je _switch4_case3
_switch4_case0:
  mov b, $20
  mov [__c], bl
  jmp _switch4_exit ; case break
_switch4_case1:
  mov b, $2e
  mov [__c], bl
  jmp _switch4_exit ; case break
_switch4_case2:
  mov b, $40
  mov [__c], bl
  jmp _switch4_exit ; case break
_switch4_case3:
  mov b, $23
  mov [__c], bl
  jmp _switch4_exit ; case break
_switch4_exit:
  mov bl, [__c] ; c
  mov bh, 0
  push bl
  call _putchar
  add sp, 1
_for3_update:
  mov b, [__x] ; x
  inc b
  mov [__x], b
  jmp _for3_cond
_for3_exit:
  mov b, $a
  push bl
  call _putchar
  add sp, 1
_for2_update:
  mov b, [__y] ; y
  inc b
  mov [__y], b
  jmp _for2_cond
_for2_exit:
  leave
  ret

iterate:
  push bp
  mov bp, sp
_for5_init:
  mov b, 0
  mov [__y], b
_for5_cond:
  mov b, [__y] ; y
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
  mov [__x], b
_for6_cond:
  mov b, [__x] ; x
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
  mov [__head_count], b
_for7_init:
  mov b, 1
  neg b
  mov [__dy], b
_for7_cond:
  mov b, [__dy] ; dy
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
  mov [__dx], b
_for8_cond:
  mov b, [__dx] ; dx
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
  mov b, [__dx] ; dx
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
  mov b, [__dy] ; dy
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
  jmp _for8_update ; for continue
  jmp _if9_exit
_if9_exit:
  mov b, [__x] ; x
  push a
  mov a, b
  mov b, [__dx] ; dx
  add a, b
  mov b, a
  pop a
  mov [__nx], b
  mov b, [__y] ; y
  push a
  mov a, b
  mov b, [__dy] ; dy
  add a, b
  mov b, a
  pop a
  mov [__ny], b
_if10_cond:
  mov b, [__nx] ; nx
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
  mov b, [__nx] ; nx
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
  mov b, [__ny] ; ny
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
  mov b, [__ny] ; ny
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
  mov b, [__ny] ; ny
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [__nx] ; nx
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
  mov b, [__head_count] ; head_count
  push a
  mov a, b
  inc b
  mov [__head_count], b
  mov b, a
  pop a
  jmp _if10_exit
_if10_exit:
_for8_update:
  mov b, [__dx] ; dx
  push a
  mov a, b
  inc b
  mov [__dx], b
  mov b, a
  pop a
  jmp _for8_cond
_for8_exit:
_for7_update:
  mov b, [__dy] ; dy
  push a
  mov a, b
  inc b
  mov [__dy], b
  mov b, a
  pop a
  jmp _for7_cond
_for7_exit:
_switch11_expr:
  mov b, [__grid] ; grid
  push a
  mov d, b
  push d
  mov b, [__y] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [__x] ; x
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
_switch11_comparisons:
  cmp b, 0
  je _switch11_case0
  cmp b, 1
  je _switch11_case1
  cmp b, 2
  je _switch11_case2
  cmp b, 3
  je _switch11_case3
_switch11_case0:
  mov b, [__new_grid] ; new_grid
  push a
  mov d, b
  push d
  mov b, [__y] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [__x] ; x
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
_if12_cond:
  mov b, [__head_count] ; head_count
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
  mov b, [__head_count] ; head_count
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
  je _if12_else
_if12_true:
  mov b, [__new_grid] ; new_grid
  push a
  mov d, b
  push d
  mov b, [__y] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [__x] ; x
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 2; ELECTRON_HEAD
  pop d
  mov [d], b
  jmp _if12_exit
_if12_else:
  mov b, [__new_grid] ; new_grid
  push a
  mov d, b
  push d
  mov b, [__y] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [__x] ; x
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 1; CONDUCTOR
  pop d
  mov [d], b
_if12_exit:
  jmp _switch11_exit ; case break
_switch11_case2:
  mov b, [__new_grid] ; new_grid
  push a
  mov d, b
  push d
  mov b, [__y] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [__x] ; x
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
  mov b, [__y] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [__x] ; x
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
  mov b, [__x] ; x
  inc b
  mov [__x], b
  jmp _for6_cond
_for6_exit:
_for5_update:
  mov b, [__y] ; y
  inc b
  mov [__y], b
  jmp _for5_cond
_for5_exit:
_for13_init:
  mov b, 0
  mov [__y], b
_for13_cond:
  mov b, [__y] ; y
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
  mov [__x], b
_for14_cond:
  mov b, [__x] ; x
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
  mov b, [__y] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [__x] ; x
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
  mov b, [__y] ; y
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, [__x] ; x
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for14_update:
  mov b, [__x] ; x
  inc b
  mov [__x], b
  jmp _for14_cond
_for14_exit:
_for13_update:
  mov b, [__y] ; y
  inc b
  mov [__y], b
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
_if15_cond:
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
  je _if15_exit
_if15_true:
  mov b, $30
  push bl
  call _putchar
  add sp, 1
  leave
  ret
  jmp _if15_exit
_if15_exit:
_while16_cond:
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
  je _while16_exit
_while16_block:
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
  mov b, $30
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
  jmp _while16_cond
_while16_exit:
_while17_cond:
  mov b, [bp + -6] ; i
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
  je _while17_exit
_while17_block:
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
  jmp _while17_cond
_while17_exit:
  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
__grid_data: .fill 1600, 0
__grid: .dw __grid_data
__new_grid_data: .fill 1600, 0
__new_grid: .dw __new_grid_data
__x: .fill 2, 0
__y: .fill 2, 0
__dx: .fill 2, 0
__dy: .fill 2, 0
__nx: .fill 2, 0
__ny: .fill 2, 0
__head_count: .fill 2, 0
__c: .fill 1, 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
