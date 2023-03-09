; --- FILENAME: life2.c
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
_for1_cond:
_for1_block:
  call show
_for2_init:
  mov b, 1
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for2_cond:
  mov b, [bp + -1] ; i
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
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for2_exit
_for2_block:
_for3_init:
  mov b, 1
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for3_cond:
  mov b, [bp + -3] ; j
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
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for3_exit
_for3_block:
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
_if4_cond:
  mov b, [bp + -5] ; n
  push a
  mov a, b
  mov b, 2
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [bp + -5] ; n
  push a
  mov a, b
  mov b, 4
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, %00000000
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  or a, b
  mov b, a
  pop a
  cmp b, 0
  je _if4_else
_if4_true:
  mov b, [cells]
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
  push d
  mov b, ' '
  pop d
  mov al, bl
  mov [d], al
  jmp _if4_exit
_if4_else:
_if5_cond:
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
  je _if5_exit
_if5_true:
  mov b, [cells]
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
  push d
  mov b, '@'
  pop d
  mov al, bl
  mov [d], al
  jmp _if5_exit
_if5_exit:
_if4_exit:
_for3_update:
  mov b, [bp + -3] ; j
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
  mov b, a
  jmp _for3_cond
_for3_exit:
_for2_update:
  mov b, [bp + -1] ; i
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  mov b, a
  jmp _for2_cond
_for2_exit:
_for1_update:
  jmp _for1_cond
_for1_exit:
  mov b, 0
  leave
  syscall sys_terminate_proc

show:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
_for6_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for6_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 40
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for6_exit
_for6_block:
_for7_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for7_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 40
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for7_exit
_for7_block:
  mov b, [cells]
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
  mov bl, [d]
  mov bh, 0
  pop a
  push bl
  call _putchar
  add sp, 1
_for7_update:
  mov b, [bp + -3] ; j
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
  mov b, a
  jmp _for7_cond
_for7_exit:
  mov b, 10
  push bl
  call _putchar
  add sp, 1
_for6_update:
  mov b, [bp + -1] ; i
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  mov b, a
  jmp _for6_cond
_for6_exit:
  leave
  ret

alive:
  push bp
  mov bp, sp
_if8_cond:
  mov b, [cells]
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
  mov bl, [d]
  mov bh, 0
  pop a
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
  je _if8_else
_if8_true:
  mov b, 1
  leave
  ret
  jmp _if8_exit
_if8_else:
  mov b, 0
  leave
  ret
_if8_exit:

neighbours:
  push bp
  mov bp, sp
  sub sp, 2 ; count
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
_if9_cond:
  mov b, [bp + 7] ; i
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  swp b
  push b
  mov b, [bp + 5] ; j
  swp b
  push b
  call alive
  add sp, 4
  cmp b, 0
  je _if9_exit
_if9_true:
  mov b, [bp + -1] ; count
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  jmp _if9_exit
_if9_exit:
_if10_cond:
  mov b, [bp + 7] ; i
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  swp b
  push b
  mov b, [bp + 5] ; j
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  swp b
  push b
  call alive
  add sp, 4
  cmp b, 0
  je _if10_exit
_if10_true:
  mov b, [bp + -1] ; count
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  jmp _if10_exit
_if10_exit:
_if11_cond:
  mov b, [bp + 7] ; i
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  swp b
  push b
  mov b, [bp + 5] ; j
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  swp b
  push b
  call alive
  add sp, 4
  cmp b, 0
  je _if11_exit
_if11_true:
  mov b, [bp + -1] ; count
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  jmp _if11_exit
_if11_exit:
_if12_cond:
  mov b, [bp + 7] ; i
  swp b
  push b
  mov b, [bp + 5] ; j
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  swp b
  push b
  call alive
  add sp, 4
  cmp b, 0
  je _if12_exit
_if12_true:
  mov b, [bp + -1] ; count
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  jmp _if12_exit
_if12_exit:
_if13_cond:
  mov b, [bp + 7] ; i
  swp b
  push b
  mov b, [bp + 5] ; j
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  swp b
  push b
  call alive
  add sp, 4
  cmp b, 0
  je _if13_exit
_if13_true:
  mov b, [bp + -1] ; count
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  jmp _if13_exit
_if13_exit:
_if14_cond:
  mov b, [bp + 7] ; i
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  swp b
  push b
  mov b, [bp + 5] ; j
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  swp b
  push b
  call alive
  add sp, 4
  cmp b, 0
  je _if14_exit
_if14_true:
  mov b, [bp + -1] ; count
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  jmp _if14_exit
_if14_exit:
_if15_cond:
  mov b, [bp + 7] ; i
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  swp b
  push b
  mov b, [bp + 5] ; j
  swp b
  push b
  call alive
  add sp, 4
  cmp b, 0
  je _if15_exit
_if15_true:
  mov b, [bp + -1] ; count
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  jmp _if15_exit
_if15_exit:
_if16_cond:
  mov b, [bp + 7] ; i
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  swp b
  push b
  mov b, [bp + 5] ; j
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  swp b
  push b
  call alive
  add sp, 4
  cmp b, 0
  je _if16_exit
_if16_true:
  mov b, [bp + -1] ; count
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; count
  pop a
  mov b, a
  jmp _if16_exit
_if16_exit:
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
cells_data: 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '@', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', '@', ' ', '@', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', '@', '@', ' ', ' ', ' ', ' ', ' ', ' ', '@', '@', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '@', '@', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '@', ' ', ' ', ' ', '@', ' ', ' ', ' ', ' ', '@', '@', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', '@', '@', ' ', ' ', ' ', ' ', '@', '@', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '@', ' ', ' ', ' ', ' ', ' ', '@', 
.db ' ', ' ', ' ', '@', '@', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '@', '@', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', '@', ' ', ' ', ' ', '@', ' ', '@', '@', ' ', ' ', ' ', ' ', '@', ' ', '@', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '@', ' ', ' ', ' ', ' ', ' ', '@', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '@', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '@', ' ', ' ', ' ', '@', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', '@', '@', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
.fill 800, 0
cells: .dw cells_data
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
