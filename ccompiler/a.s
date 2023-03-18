; --- FILENAME: wireworld.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
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
  mov b, 10
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
  mov b, 10
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
  mov b, 10
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
  mov b, 11
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
  mov b, 12
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 1; CONDUCTOR
  pop d
  mov [d], b
_for1_init:
  mov b, 8
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for1_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 14
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
  je _for1_exit
_for1_block:
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
  mov b, [bp + -1] ; i
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 1; CONDUCTOR
  pop d
  mov [d], b
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
  mov b, 15
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
  mov b, 15
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
  mov b, 8
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, 15
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
  mov b, 16
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
  mov b, 8
  pop d
  mov a, 80
  mul a, b
  add d, b
  push d
  mov b, 16
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 1; CONDUCTOR
  pop d
  mov [d], b
_for2_init:
  mov b, 17
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for2_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 25
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
  je _for2_exit
_for2_block:
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
  mov b, [bp + -1] ; i
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 1; CONDUCTOR
  pop d
  mov [d], b
_for2_update:
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
  jmp _for2_cond
_for2_exit:
_while3_cond:
  mov b, 1
  cmp b, 0
  je _while3_exit
_while3_block:
  call print_grid
  call iterate
  jmp _while3_cond
_while3_exit:
  mov b, 0
  leave
  syscall sys_terminate_proc

print_grid:
  push bp
  mov bp, sp
_for4_init:
  mov b, 0
  mov [__y], b
_for4_cond:
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
  je _for4_exit
_for4_block:
_for5_init:
  mov b, 0
  mov [__x], b
_for5_cond:
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
  je _for5_exit
_for5_block:
_switch6_expr:
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
_switch6_comparisons:
  cmp b, 0
  je _switch6_case0
  cmp b, 1
  je _switch6_case1
  cmp b, 2
  je _switch6_case2
  cmp b, 3
  je _switch6_case3
_switch6_case0:
  mov b, $20
  mov [__c], bl
  jmp _switch6_exit ; case break
_switch6_case1:
  mov b, $2a
  mov [__c], bl
  jmp _switch6_exit ; case break
_switch6_case2:
  mov b, $48
  mov [__c], bl
  jmp _switch6_exit ; case break
_switch6_case3:
  mov b, $54
  mov [__c], bl
  jmp _switch6_exit ; case break
_switch6_exit:
  mov bl, [__c] ; c
  mov bh, 0
  push bl
  call _putchar
  add sp, 1
_for5_update:
  mov b, [__x] ; x
  inc b
  mov [__x], b
  jmp _for5_cond
_for5_exit:
  mov b, $a
  push bl
  call _putchar
  add sp, 1
_for4_update:
  mov b, [__y] ; y
  inc b
  mov [__y], b
  jmp _for4_cond
_for4_exit:
  leave
  ret

iterate:
  push bp
  mov bp, sp
_for7_init:
  mov b, 0
  mov [__y], b
_for7_cond:
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
  je _for7_exit
_for7_block:
_for8_init:
  mov b, 0
  mov [__x], b
_for8_cond:
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
  je _for8_exit
_for8_block:
  mov b, 0
  mov [__head_count], b
_for9_init:
  mov b, 1
  neg b
  mov [__dy], b
_for9_cond:
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
  je _for9_exit
_for9_block:
_for10_init:
  mov b, 1
  neg b
  mov [__dx], b
_for10_cond:
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
  je _for10_exit
_for10_block:
_if11_cond:
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
  je _if11_exit
_if11_true:
  jmp _for10_update ; for continue
  jmp _if11_exit
_if11_exit:
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
_if12_cond:
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
  je _if12_exit
_if12_true:
  mov b, [__head_count] ; head_count
  push a
  mov a, b
  inc b
  mov [__head_count], b
  mov b, a
  pop a
  jmp _if12_exit
_if12_exit:
_for10_update:
  mov b, [__dx] ; dx
  push a
  mov a, b
  inc b
  mov [__dx], b
  mov b, a
  pop a
  jmp _for10_cond
_for10_exit:
_for9_update:
  mov b, [__dy] ; dy
  push a
  mov a, b
  inc b
  mov [__dy], b
  mov b, a
  pop a
  jmp _for9_cond
_for9_exit:
_switch13_expr:
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
_switch13_comparisons:
  cmp b, 0
  je _switch13_case0
  cmp b, 1
  je _switch13_case1
  cmp b, 2
  je _switch13_case2
  cmp b, 3
  je _switch13_case3
_switch13_case0:
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
  jmp _switch13_exit ; case break
_switch13_case1:
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
_ternary14_cond:
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
  je _ternary14_false
_ternary14_true:
  mov b, 2; ELECTRON_HEAD
  jmp _ternary14_exit
_ternary14_false:
  mov b, 1; CONDUCTOR
_ternary14_exit:
  pop d
  mov [d], b
  jmp _switch13_exit ; case break
_switch13_case2:
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
  jmp _switch13_exit ; case break
_switch13_case3:
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
  jmp _switch13_exit ; case break
_switch13_exit:
_for8_update:
  mov b, [__x] ; x
  inc b
  mov [__x], b
  jmp _for8_cond
_for8_exit:
_for7_update:
  mov b, [__y] ; y
  inc b
  mov [__y], b
  jmp _for7_cond
_for7_exit:
_for15_init:
  mov b, 0
  mov [__y], b
_for15_cond:
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
  je _for15_exit
_for15_block:
_for16_init:
  mov b, 0
  mov [__x], b
_for16_cond:
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
  je _for16_exit
_for16_block:
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
_for16_update:
  mov b, [__x] ; x
  inc b
  mov [__x], b
  jmp _for16_cond
_for16_exit:
_for15_update:
  mov b, [__y] ; y
  inc b
  mov [__y], b
  jmp _for15_cond
_for15_exit:
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
_if17_cond:
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
  je _if17_exit
_if17_true:
  mov b, $30
  push bl
  call _putchar
  add sp, 1
  leave
  ret
  jmp _if17_exit
_if17_exit:
_while18_cond:
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
  je _while18_exit
_while18_block:
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
  jmp _while18_cond
_while18_exit:
_while19_cond:
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
  je _while19_exit
_while19_block:
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
  jmp _while19_cond
_while19_exit:
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
