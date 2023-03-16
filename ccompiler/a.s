; --- FILENAME: life.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
  sub sp, 2 ; n
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
  mov b, [__SIZE] ; SIZE
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
  mov b, [__SIZE] ; SIZE
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
  mov b, [__nextState] ; nextState
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 40
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
  mov b, [__currState] ; currState
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 40
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
_for3_init:
_for3_cond:
_for3_block:
_for4_init:
  mov b, 1
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for4_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, [__SIZE] ; SIZE
  push a
  mov a, b
  mov b, -1
  add a, b
  mov b, a
  pop a
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
  mov b, 1
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for5_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, [__SIZE] ; SIZE
  push a
  mov a, b
  mov b, -1
  add a, b
  mov b, a
  pop a
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
  mov b, [bp + -1] ; i
  swp b
  push b
  mov b, [bp + -3] ; j
  swp b
  push b
  call neighbours
  add sp, 4
  push a
  mov a, b
  mov [bp + -5], a ; n
  pop a
_if6_cond:
  mov b, [bp + -5] ; n
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
  push a
  mov a, b
  mov b, [bp + -5] ; n
  push a
  mov a, b
  mov b, 3
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
  or a, b
  mov b, a
  pop a
  cmp b, 0
  je _if6_else
_if6_true:
  mov b, [__nextState] ; nextState
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 40
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
  mov b, ' '
  pop d
  mov [d], bl
  jmp _if6_exit
_if6_else:
_if7_cond:
  mov b, [bp + -5] ; n
  push a
  mov a, b
  mov b, 3
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if7_exit
_if7_true:
  mov b, [__nextState] ; nextState
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 40
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
  mov b, '@'
  pop d
  mov [d], bl
  jmp _if7_exit
_if7_exit:
_if6_exit:
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
_for8_init:
  mov b, 1
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for8_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, [__SIZE] ; SIZE
  push a
  mov a, b
  mov b, -1
  add a, b
  mov b, a
  pop a
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
_for9_init:
  mov b, 1
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for9_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, [__SIZE] ; SIZE
  push a
  mov a, b
  mov b, -1
  add a, b
  mov b, a
  pop a
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
  je _for9_exit
_for9_block:
  mov b, [__currState] ; currState
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 40
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
  mov b, [__nextState] ; nextState
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 40
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
  pop d
  mov [d], bl
_for9_update:
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
  jmp _for9_cond
_for9_exit:
_for8_update:
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
  jmp _for8_cond
_for8_exit:
  call show
_for3_update:
  jmp _for3_cond
_for3_exit:
  mov b, 0
  leave
  syscall sys_terminate_proc

show:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
_for10_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for10_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, [__SIZE] ; SIZE
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
  je _for10_exit
_for10_block:
_for11_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for11_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, [__SIZE] ; SIZE
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
  je _for11_exit
_for11_block:
_ternary12_cond:
  mov b, [__currState] ; currState
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 40
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
  push a
  mov a, b
  mov b, '@'
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _ternary12_false
_ternary12_true:
  mov b, __string_0 ; "@ "
  swp b
  push b
  call print
  add sp, 2
  jmp _ternary12_exit
_ternary12_false:
  mov b, __string_1 ; ". "
  swp b
  push b
  call print
  add sp, 2
_ternary12_exit:
_for11_update:
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
  jmp _for11_cond
_for11_exit:
  mov b, 10
  push bl
  call _putchar
  add sp, 1
_for10_update:
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
  jmp _for10_cond
_for10_exit:
  leave
  ret

alive:
  push bp
  mov bp, sp
_if13_cond:
  mov b, [__currState] ; currState
  push a
  mov d, b
  push d
  mov b, [bp + 7] ; i
  pop d
  mov a, 40
  mul a, b
  add d, b
  push d
  mov b, [bp + 5] ; j
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  mov bl, [d]
  mov bh, 0
  push a
  mov a, b
  mov b, '@'
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if13_else
_if13_true:
  mov b, 1
  leave
  ret
  jmp _if13_exit
_if13_else:
  mov b, 0
  leave
  ret
_if13_exit:

neighbours:
  push bp
  mov bp, sp
  sub sp, 2 ; count
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
_if14_cond:
  mov b, [__currState] ; currState
  push a
  mov d, b
  push d
  mov b, [bp + 7] ; i
  push a
  mov a, b
  mov b, -1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 40
  mul a, b
  add d, b
  push d
  mov b, [bp + 5] ; j
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  mov bl, [d]
  mov bh, 0
  push a
  mov a, b
  mov b, '@'
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if14_exit
_if14_true:
  mov b, [bp + -1] ; count
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  pop a
  jmp _if14_exit
_if14_exit:
_if15_cond:
  mov b, [__currState] ; currState
  push a
  mov d, b
  push d
  mov b, [bp + 7] ; i
  push a
  mov a, b
  mov b, -1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 40
  mul a, b
  add d, b
  push d
  mov b, [bp + 5] ; j
  push a
  mov a, b
  mov b, -1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  mov bl, [d]
  mov bh, 0
  push a
  mov a, b
  mov b, '@'
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if15_exit
_if15_true:
  mov b, [bp + -1] ; count
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  pop a
  jmp _if15_exit
_if15_exit:
_if16_cond:
  mov b, [__currState] ; currState
  push a
  mov d, b
  push d
  mov b, [bp + 7] ; i
  push a
  mov a, b
  mov b, -1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 40
  mul a, b
  add d, b
  push d
  mov b, [bp + 5] ; j
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  mov bl, [d]
  mov bh, 0
  push a
  mov a, b
  mov b, '@'
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if16_exit
_if16_true:
  mov b, [bp + -1] ; count
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  pop a
  jmp _if16_exit
_if16_exit:
_if17_cond:
  mov b, [__currState] ; currState
  push a
  mov d, b
  push d
  mov b, [bp + 7] ; i
  pop d
  mov a, 40
  mul a, b
  add d, b
  push d
  mov b, [bp + 5] ; j
  push a
  mov a, b
  mov b, -1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  mov bl, [d]
  mov bh, 0
  push a
  mov a, b
  mov b, '@'
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if17_exit
_if17_true:
  mov b, [bp + -1] ; count
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  pop a
  jmp _if17_exit
_if17_exit:
_if18_cond:
  mov b, [__currState] ; currState
  push a
  mov d, b
  push d
  mov b, [bp + 7] ; i
  pop d
  mov a, 40
  mul a, b
  add d, b
  push d
  mov b, [bp + 5] ; j
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  mov bl, [d]
  mov bh, 0
  push a
  mov a, b
  mov b, '@'
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if18_exit
_if18_true:
  mov b, [bp + -1] ; count
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  pop a
  jmp _if18_exit
_if18_exit:
_if19_cond:
  mov b, [__currState] ; currState
  push a
  mov d, b
  push d
  mov b, [bp + 7] ; i
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 40
  mul a, b
  add d, b
  push d
  mov b, [bp + 5] ; j
  push a
  mov a, b
  mov b, -1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  mov bl, [d]
  mov bh, 0
  push a
  mov a, b
  mov b, '@'
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if19_exit
_if19_true:
  mov b, [bp + -1] ; count
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  pop a
  jmp _if19_exit
_if19_exit:
_if20_cond:
  mov b, [__currState] ; currState
  push a
  mov d, b
  push d
  mov b, [bp + 7] ; i
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 40
  mul a, b
  add d, b
  push d
  mov b, [bp + 5] ; j
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  mov bl, [d]
  mov bh, 0
  push a
  mov a, b
  mov b, '@'
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if20_exit
_if20_true:
  mov b, [bp + -1] ; count
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  pop a
  jmp _if20_exit
_if20_exit:
_if21_cond:
  mov b, [__currState] ; currState
  push a
  mov d, b
  push d
  mov b, [bp + 7] ; i
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 40
  mul a, b
  add d, b
  push d
  mov b, [bp + 5] ; j
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  mov bl, [d]
  mov bh, 0
  push a
  mov a, b
  mov b, '@'
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if21_exit
_if21_true:
  mov b, [bp + -1] ; count
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  pop a
  jmp _if21_exit
_if21_exit:
  mov b, [bp + -1] ; count
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
__SIZE: .dw 40
__nextState_data: .fill 1600, 0
__nextState: .dw __nextState_data
__currState_data: 
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$40,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$40,$20,$40,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$40,$40,$20,$20,$20,$20,$20,$20,$40,$40,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$40,$40,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$40,$20,$20,$20,$40,$20,$20,$20,$20,$40,$40,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$40,$40,$20,$20,$20,$20,$40,$40,$20,$20,$20,$20,$20,$20,$20,$20,$40,$20,$20,$20,$20,$20,$40,
.db $20,$20,$20,$40,$40,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$40,$40,$20,$20,$20,$20,$20,
.db $20,$20,$20,$40,$20,$20,$20,$40,$20,$40,$40,$20,$20,$20,$20,$40,$20,$40,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$40,$20,$20,$20,$20,$20,$40,$20,$20,$20,$20,$20,$20,$20,$40,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$40,$20,$20,$20,$40,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$40,$40,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$40,$40,$40,$20,
.db $20,$20,$40,$40,$40,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$40,$40,$40,$20,$20,$20,$40,$40,$40,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$40,$20,$20,$20,$20,$40,$20,$40,$20,$20,$20,$20,$40,$20,$20,$20,
.db $20,$20,$20,$20,$20,$40,$20,$20,$20,$20,$40,$20,$40,$20,$20,$20,$20,$40,$20,$20,$20,$20,$20,$20,$40,$20,$20,$20,$20,$40,
.db $20,$40,$20,$20,$20,$20,$40,$20,$20,$20,$20,$20,$20,$20,$20,$40,$20,$20,$20,$20,$40,$20,$40,$20,$20,$20,$20,$40,$20,$20,
.db $20,$20,$20,$20,$40,$20,$20,$20,$20,$40,$20,$40,$20,$20,$20,$20,$40,$20,$20,$20,$20,$20,$20,$20,$20,$40,$20,$20,$20,$20,
.db $40,$20,$40,$20,$20,$20,$20,$40,$20,$20,$20,$20,$20,$20,$20,$20,$40,$40,$40,$20,$20,$20,$40,$40,$40,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$40,$40,$40,$20,$20,$20,$40,$40,$40,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$40,$40,$40,$20,$20,$20,$40,$40,$40,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$40,$40,$40,
.db $20,$20,$20,$40,$40,$40,$20,$20,$20,$20,$20,$20,$20,$20,$40,$20,$20,$20,$20,$40,$20,$40,$20,$20,$20,$20,$40,$20,$20,$20,
.db $20,$20,$20,$20,$20,$40,$20,$20,$20,$20,$40,$20,$40,$20,$20,$20,$20,$40,$20,$20,$20,$20,$20,$20,$40,$20,$20,$20,$20,$40,
.db $20,$40,$20,$20,$20,$20,$40,$20,$20,$20,$20,$20,$20,$20,$20,$40,$20,$20,$20,$20,$40,$20,$40,$20,$20,$20,$20,$40,$20,$20,
.db $20,$20,$20,$20,$40,$20,$20,$20,$20,$40,$20,$40,$20,$20,$20,$20,$40,$20,$20,$20,$20,$20,$20,$20,$20,$40,$20,$20,$20,$20,
.db $40,$20,$40,$20,$20,$20,$20,$40,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$40,$40,$40,$20,
.db $20,$20,$40,$40,$40,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$40,$40,$40,$20,$20,$20,$40,$40,$40,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
.fill 80, 0
__currState: .dw __currState_data
__string_0: .db "@ ", 0
__string_1: .db ". ", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
