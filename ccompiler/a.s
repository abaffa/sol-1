; --- FILENAME: snake.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
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
  mov b, 8
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
  mov b, [__snake_x] ; snake_x
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 20
  push a
  mov a, b
  mov b, [bp + -1] ; i
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, [__snake_y] ; snake_y
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 10
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
_while2_cond:
  mov b, 1
  cmp b, 0
  je _while2_exit
_while2_block:
  call draw_board
  call update_snake
  jmp _while2_cond
_while2_exit:
  mov b, 0
  leave
  syscall sys_terminate_proc

draw_board:
  push bp
  mov bp, sp
  sub sp, 2 ; x
  sub sp, 2 ; y
  sub sp, 2 ; i
  sub sp, 1 ; c
  mov b, [__s] ; s
  swp b
  push b
  call print
  add sp, 2
  call rand
  swp b
  push b
  call print_num
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for3_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; y
  pop a
_for3_cond:
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
  je _for3_exit
_for3_block:
_for4_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; x
  pop a
_for4_cond:
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
  je _for4_exit
_for4_block:
  mov b, $20
  push al
  mov al, bl
  mov [bp + -6], al ; c
  pop al
_if5_cond:
  mov b, [bp + -1] ; x
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [bp + -1] ; x
  push a
  mov a, b
  mov b, 39
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  or a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [bp + -3] ; y
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  or a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [bp + -3] ; y
  push a
  mov a, b
  mov b, 19
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
  je _if5_else
_if5_true:
  mov b, $23
  push al
  mov al, bl
  mov [bp + -6], al ; c
  pop al
  jmp _if5_exit
_if5_else:
_for6_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -5], a ; i
  pop a
_for6_cond:
  mov b, [bp + -5] ; i
  push a
  mov a, b
  mov b, 8
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
_if7_cond:
  mov b, [bp + -1] ; x
  push a
  mov a, b
  mov b, [__snake_x] ; snake_x
  push a
  mov d, b
  push d
  mov b, [bp + -5] ; i
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [bp + -3] ; y
  push a
  mov a, b
  mov b, [__snake_y] ; snake_y
  push a
  mov d, b
  push d
  mov b, [bp + -5] ; i
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
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
  je _if7_exit
_if7_true:
  mov b, $6f
  push al
  mov al, bl
  mov [bp + -6], al ; c
  pop al
  jmp _for6_exit ; for break
  jmp _if7_exit
_if7_exit:
_for6_update:
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
  jmp _for6_cond
_for6_exit:
_if5_exit:
  mov bl, [bp + -6] ; c
  mov bh, 0
  push bl
  call _putchar
  add sp, 1
_for4_update:
  mov b, [bp + -1] ; x
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; x
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
  mov b, [bp + -3] ; y
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; y
  pop a
  mov b, a
  pop a
  jmp _for3_cond
_for3_exit:
  leave
  ret

update_snake:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; snkx
  sub sp, 2 ; snky
_for8_init:
  mov b, 8
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for8_cond:
  mov b, [bp + -1] ; i
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
  je _for8_exit
_for8_block:
  mov b, [__snake_x] ; snake_x
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__snake_x] ; snake_x
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
  mov b, [__snake_y] ; snake_y
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__snake_y] ; snake_y
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for8_update:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  dec b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  mov b, a
  pop a
  jmp _for8_cond
_for8_exit:
  mov b, [__snake_x] ; snake_x
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__snake_x] ; snake_x
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__dx] ; dx
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, [__snake_y] ; snake_y
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__snake_y] ; snake_y
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__dy] ; dy
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_if9_cond:
  call rand
  push a
  mov a, b
  mov b, 10
  div a, b
  pop a
  push a
  mov a, b
  mov b, 2
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
  je _if9_exit
_if9_true:
_if10_cond:
  mov b, [__dx] ; dx
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if10_else
_if10_true:
_ternary11_cond:
  call rand
  push a
  mov a, b
  mov b, 2
  div a, b
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
  cmp b, 0
  je _ternary11_false
_ternary11_true:
  mov b, 1
  jmp _ternary11_exit
_ternary11_false:
  mov b, 1
  neg b
_ternary11_exit:
  mov [__dy], b
  mov b, 0
  mov [__dx], b
  jmp _if10_exit
_if10_else:
_if12_cond:
  mov b, [__dy] ; dy
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if12_exit
_if12_true:
_ternary13_cond:
  call rand
  push a
  mov a, b
  mov b, 2
  div a, b
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
  cmp b, 0
  je _ternary13_false
_ternary13_true:
  mov b, 1
  jmp _ternary13_exit
_ternary13_false:
  mov b, 1
  neg b
_ternary13_exit:
  mov [__dx], b
  mov b, 0
  mov [__dy], b
  jmp _if12_exit
_if12_exit:
_if10_exit:
  jmp _if9_exit
_if9_exit:
  mov b, [__snake_x] ; snake_x
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov [bp + -3], a ; snkx
  pop a
  mov b, [__snake_y] ; snake_y
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov [bp + -5], a ; snky
  pop a
_if14_cond:
  mov b, [bp + -3] ; snkx
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
  or al, bl ; <= (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if14_else
_if14_true:
  mov b, [__snake_x] ; snake_x
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 1
  pop d
  mov [d], b
  mov b, 1
  mov [__dx], b
  mov b, 0
  mov [__dy], b
  jmp _if14_exit
_if14_else:
_if15_cond:
  mov b, [bp + -3] ; snkx
  push a
  mov a, b
  mov b, 39
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
  je _if15_else
_if15_true:
  mov b, [__snake_x] ; snake_x
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 38
  pop d
  mov [d], b
  mov b, 1
  neg b
  mov [__dx], b
  mov b, 0
  mov [__dy], b
  jmp _if15_exit
_if15_else:
_if16_cond:
  mov b, [bp + -5] ; snky
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
  or al, bl ; <= (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if16_else
_if16_true:
  mov b, [__snake_y] ; snake_y
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 1
  pop d
  mov [d], b
  mov b, 1
  mov [__dy], b
  mov b, 0
  mov [__dx], b
  jmp _if16_exit
_if16_else:
_if17_cond:
  mov b, [bp + -5] ; snky
  push a
  mov a, b
  mov b, 19
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
  je _if17_exit
_if17_true:
  mov b, [__snake_y] ; snake_y
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 18
  pop d
  mov [d], b
  mov b, 1
  neg b
  mov [__dy], b
  mov b, 0
  mov [__dx], b
  jmp _if17_exit
_if17_exit:
_if16_exit:
_if15_exit:
_if14_exit:
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
_if18_cond:
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
  je _if18_exit
_if18_true:
  mov b, $30
  push bl
  call _putchar
  add sp, 1
  leave
  ret
  jmp _if18_exit
_if18_exit:
_while19_cond:
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
  je _while19_exit
_while19_block:
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
  jmp _while19_cond
_while19_exit:
_while20_cond:
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
  je _while20_exit
_while20_block:
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
  jmp _while20_cond
_while20_exit:
  leave
  ret

rand:
  push bp
  mov bp, sp
  sub sp, 1 ; sec

; --- BEGIN INLINE ASM BLOCK
  mov al, 0
  syscall sys_rtc					; get seconds
  mov al, ah
  mov [bp + 0], al
; --- END INLINE ASM BLOCK

  mov bl, [bp + 0] ; sec
  mov bh, 0
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
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
__s_data: 
.db 27,$5b,$32,$4a,27,$5b,$48,0,
.fill 0, 0
__s: .dw __s_data
__snake_x_data: .fill 16, 0
__snake_x: .dw __snake_x_data
__snake_y_data: .fill 16, 0
__snake_y: .dw __snake_y_data
__dx: .dw 1
__dy: .dw 0
__string_0: .db "\n", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
