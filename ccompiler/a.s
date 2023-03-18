; --- FILENAME: snake.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
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
  mov b, 40
  push a
  mov a, b
  mov b, 2
  div a, b
  mov g, a
  mov a, b
  mov b, g
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
  mov b, 20
  push a
  mov a, b
  mov b, 2
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  pop d
  mov [d], b
_while1_cond:
  mov b, 1
  cmp b, 0
  je _while1_exit
_while1_block:
  call draw_board
  call update_snake
  jmp _while1_cond
_while1_exit:
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
_for2_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; y
  pop a
_for2_cond:
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
  je _for2_exit
_for2_block:
_for3_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; x
  pop a
_for3_cond:
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
  je _for3_exit
_for3_block:
  mov b, $20
  push al
  mov al, bl
  mov [bp + -6], al ; c
  pop al
_if4_cond:
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
  mov b, 40
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
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
  mov b, 20
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
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
  je _if4_else
_if4_true:
  mov b, $23
  push al
  mov al, bl
  mov [bp + -6], al ; c
  pop al
  jmp _if4_exit
_if4_else:
_for5_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -5], a ; i
  pop a
_for5_cond:
  mov b, [bp + -5] ; i
  push a
  mov a, b
  mov b, [__snake_len] ; snake_len
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
_if6_cond:
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
  je _if6_exit
_if6_true:
_ternary7_cond:
  mov b, [bp + -5] ; i
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
  je _ternary7_false
_ternary7_true:
  mov b, $4f
  jmp _ternary7_exit
_ternary7_false:
  mov b, $6f
_ternary7_exit:
  push al
  mov al, bl
  mov [bp + -6], al ; c
  pop al
  jmp _for5_exit ; for break
  jmp _if6_exit
_if6_exit:
_for5_update:
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
  jmp _for5_cond
_for5_exit:
_if4_exit:
  mov bl, [bp + -6] ; c
  mov bh, 0
  push bl
  call _putchar
  add sp, 1
_for3_update:
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
  jmp _for3_cond
_for3_exit:
  mov b, $a
  push bl
  call _putchar
  add sp, 1
_for2_update:
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
  jmp _for2_cond
_for2_exit:
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

update_snake:
  push bp
  mov bp, sp
  sub sp, 2 ; i
_for8_init:
  mov b, [__snake_len] ; snake_len
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
  push a
  mov a, b
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
  mov b, 40
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
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
  or a, b
  mov b, a
  pop a
  push a
  mov a, b
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
  mov b, 20
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
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
  je _if9_exit
_if9_true:
_if10_cond:
  mov b, [__dx] ; dx
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if10_else
_if10_true:
  mov b, 0
  mov [__dx], b
  mov b, 1
  mov [__dy], b
  jmp _if10_exit
_if10_else:
_if11_cond:
  mov b, [__dy] ; dy
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if11_else
_if11_true:
  mov b, 1
  neg b
  mov [__dx], b
  mov b, 0
  mov [__dy], b
  jmp _if11_exit
_if11_else:
_if12_cond:
  mov b, [__dx] ; dx
  push a
  mov a, b
  mov b, 1
  neg b
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if12_else
_if12_true:
  mov b, 0
  mov [__dx], b
  mov b, 1
  neg b
  mov [__dy], b
  jmp _if12_exit
_if12_else:
_if13_cond:
  mov b, [__dy] ; dy
  push a
  mov a, b
  mov b, 1
  neg b
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if13_exit
_if13_true:
  mov b, 1
  mov [__dx], b
  mov b, 0
  mov [__dy], b
  jmp _if13_exit
_if13_exit:
_if12_exit:
_if11_exit:
_if10_exit:
  jmp _if9_exit
_if9_exit:
  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
__s_data: 
.db 27,$5b,$32,$4a,27,$5b,$48,0,
.fill 0, 0
__s: .dw __s_data
__snake_x_data: .fill 200, 0
__snake_x: .dw __snake_x_data
__snake_y_data: .fill 200, 0
__snake_y: .dw __snake_y_data
__snake_len: .dw 1
__dx: .dw 1
__dy: .dw 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
