; --- FILENAME: sort.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; n
  sub sp, 2 ; i
  sub sp, 100 ; s
  mov b, __string_0 ; "Enter the elements of the array as a string: "
  swp b
  push b
  call print
  add sp, 2
  lea d, [bp + -103] ; s beginning on the stack
  mov b, d
  swp b
  push b
  call _gets
  add sp, 2
  mov b, __string_1 ; "OK.\n"
  swp b
  push b
  call print
  add sp, 2
  lea d, [bp + -103] ; s beginning on the stack
  mov b, d
  swp b
  push b
  call _strlen
  add sp, 2
  push a
  mov a, b
  mov [bp + -1], a ; n
  pop a
  mov b, __string_2 ; "Now sorting...\n"
  swp b
  push b
  call print
  add sp, 2
  lea d, [bp + -103] ; s beginning on the stack
  mov b, d
  swp b
  push b
  mov b, [bp + -1] ; n
  swp b
  push b
  call bubble_sort
  add sp, 4
  mov b, __string_3 ; "Sorted array: "
  swp b
  push b
  call print
  add sp, 2
_for1_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; i
  pop a
_for1_cond:
  mov b, [bp + -3] ; i
  push a
  mov a, b
  mov b, [bp + -1] ; n
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
  lea d, [bp + -103] ; s beginning on the stack
  mov b, d
  push a
  mov d, b
  push d
  mov b, [bp + -3] ; i
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
_for1_update:
  mov b, [bp + -3] ; i
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; i
  pop a
  mov b, a
  pop a
  jmp _for1_cond
_for1_exit:
  mov b, __string_4 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 0
  leave
  syscall sys_terminate_proc

bubble_sort:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
  sub sp, 1 ; temp
_for2_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for2_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, [bp + 5] ; n
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
  mov [bp + -3], a ; j
  pop a
_for3_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov b, [bp + -1] ; i
  sub a, b
  mov b, a
  pop a
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
  xor al, bl ; < (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for3_exit
_for3_block:
_if4_cond:
  lea d, [bp + 7] ; arr
  mov b, [d]
  push a
  mov d, b
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
  lea d, [bp + 7] ; arr
  mov b, [d]
  push a
  mov d, b
  push d
  mov b, [bp + -3] ; j
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
  je _if4_exit
_if4_true:
  lea d, [bp + 7] ; arr
  mov b, [d]
  push a
  mov d, b
  push d
  mov b, [bp + -3] ; j
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  mov bl, [d]
  mov bh, 0
  push al
  mov al, bl
  mov [bp + -4], al ; temp
  pop al
  lea d, [bp + 7] ; arr
  mov b, [d]
  push a
  mov d, b
  push d
  mov b, [bp + -3] ; j
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  push d
  lea d, [bp + 7] ; arr
  mov b, [d]
  push a
  mov d, b
  push d
  mov b, [bp + -3] ; j
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
  pop d
  mov [d], bl
  lea d, [bp + 7] ; arr
  mov b, [d]
  push a
  mov d, b
  push d
  mov b, [bp + -3] ; j
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
  push d
  mov bl, [bp + -4] ; temp
  mov bh, 0
  pop d
  mov [d], bl
  jmp _if4_exit
_if4_exit:
_for3_update:
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
  jmp _for3_cond
_for3_exit:
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
  leave
  ret

_gets:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [bp + 5]
  mov d, a
  call gets
; --- END INLINE ASM BLOCK

  leave
  ret

_strlen:
  push bp
  mov bp, sp
  sub sp, 2 ; length
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; length
  pop a
_while5_cond:
  lea d, [bp + 5] ; str
  mov b, [d]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; length
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  mov bl, [d]
  mov bh, 0
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
  je _while5_exit
_while5_block:
  mov b, [bp + -1] ; length
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; length
  pop a
  mov b, a
  pop a
  jmp _while5_cond
_while5_exit:
  mov b, [bp + -1] ; length
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
_if6_cond:
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
  je _if6_exit
_if6_true:
  mov b, '0'
  push bl
  call _putchar
  add sp, 1
  leave
  ret
  jmp _if6_exit
_if6_exit:
_while7_cond:
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
  je _while7_exit
_while7_block:
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
  mov b, '0'
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
  jmp _while7_cond
_while7_exit:
_while8_cond:
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
  je _while8_exit
_while8_block:
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
  jmp _while8_cond
_while8_exit:
  leave
  ret

integer_square_root:
  push bp
  mov bp, sp
_if9_cond:
  mov b, [bp + 5] ; n
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
  je _if9_exit
_if9_true:
  mov b, [bp + 5] ; n
  leave
  ret
  jmp _if9_exit
_if9_exit:
  sub sp, 2 ; x
  sub sp, 2 ; y
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov [bp + -1], a ; x
  pop a
  mov b, [bp + -1] ; x
  push a
  mov a, b
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov b, [bp + -1] ; x
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
  mov b, 2
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  push a
  mov a, b
  mov [bp + -3], a ; y
  pop a
_while10_cond:
  mov b, [bp + -3] ; y
  push a
  mov a, b
  mov b, [bp + -1] ; x
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
  je _while10_exit
_while10_block:
  mov b, [bp + -3] ; y
  push a
  mov a, b
  mov [bp + -1], a ; x
  pop a
  mov b, [bp + -1] ; x
  push a
  mov a, b
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov b, [bp + -1] ; x
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
  mov b, 2
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  push a
  mov a, b
  mov [bp + -3], a ; y
  pop a
  jmp _while10_cond
_while10_exit:
  mov b, [bp + -1] ; x
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
__string_0: .db "Enter the elements of the array as a string: ", 0
__string_1: .db "OK.\n", 0
__string_2: .db "Now sorting...\n", 0
__string_3: .db "Sorted array: ", 0
__string_4: .db "\n", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
