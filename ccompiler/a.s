; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
  sub sp, 2 ; k
  mov b, __string_0 ; "Matrix1:\n"
  swp b
  push b
  call print
  add sp, 2
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
  mov b, 3
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
  mov b, 3
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
  mov b, __string_1 ; " "
  swp b
  push b
  mov b, [__matrix1]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
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
  swp b
  push b
  call printn
  add sp, 4
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
  mov b, __string_2 ; "\n"
  swp b
  push b
  call print
  add sp, 2
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
  mov b, __string_2 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, __string_3 ; "Matrix2:\n"
  swp b
  push b
  call print
  add sp, 2
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
  mov b, 3
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
_for4_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for4_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 3
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
  mov b, __string_1 ; " "
  swp b
  push b
  mov b, [__matrix2]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
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
  swp b
  push b
  call printn
  add sp, 4
_for4_update:
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
  jmp _for4_cond
_for4_exit:
  mov b, __string_2 ; "\n"
  swp b
  push b
  call print
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
  mov b, __string_2 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for5_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for5_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 3
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
_for6_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for6_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 3
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
  mov b, [__result1]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
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
  mov b, 0
  pop d
  mov [d], b
_for7_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -5], a ; k
  pop a
_for7_cond:
  mov b, [bp + -5] ; k
  push a
  mov a, b
  mov b, 3
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
  mov b, [__result1]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
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
  mov b, [__result1]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
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
  push a
  mov a, b
  mov b, [__matrix1]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
  mul a, b
  add d, b
  push d
  mov b, [bp + -5] ; k
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__matrix2]
  push a
  mov d, b
  push d
  mov b, [bp + -5] ; k
  pop d
  mov a, 6
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
  mul a, b
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for7_update:
  mov b, [bp + -5] ; k
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -5], a ; k
  pop a
  mov b, a
  pop a
  jmp _for7_cond
_for7_exit:
_for6_update:
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
  jmp _for6_cond
_for6_exit:
_for5_update:
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
  jmp _for5_cond
_for5_exit:
_for8_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for8_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 3
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
  mov [bp + -3], a ; j
  pop a
_for9_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 3
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
  mov b, [__result2]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
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
  mov b, [__matrix1]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
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
  push a
  mov a, b
  mov b, [__matrix2]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
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
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
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
  mov b, 3
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
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
  mov b, 3
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for11_exit
_for11_block:
  mov b, [__result3]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
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
  mov b, [__matrix2]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
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
  push a
  mov a, b
  mov b, [__matrix1]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
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
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
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
  mov b, __string_4 ; "Result1 (matrix1 * matrix2):\n"
  swp b
  push b
  call print
  add sp, 2
_for12_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for12_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 3
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for12_exit
_for12_block:
_for13_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for13_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 3
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for13_exit
_for13_block:
  mov b, __string_1 ; " "
  swp b
  push b
  mov b, [__result1]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
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
  swp b
  push b
  call printn
  add sp, 4
_for13_update:
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
  jmp _for13_cond
_for13_exit:
  mov b, __string_2 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for12_update:
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
  jmp _for12_cond
_for12_exit:
  mov b, __string_2 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, __string_5 ; "Result2 (matrix1 + matrix2):\n"
  swp b
  push b
  call print
  add sp, 2
_for14_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for14_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 3
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for14_exit
_for14_block:
_for15_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for15_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 3
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for15_exit
_for15_block:
  mov b, __string_1 ; " "
  swp b
  push b
  mov b, [__result2]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
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
  swp b
  push b
  call printn
  add sp, 4
_for15_update:
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
  jmp _for15_cond
_for15_exit:
  mov b, __string_2 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for14_update:
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
  jmp _for14_cond
_for14_exit:
  mov b, __string_2 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, __string_6 ; "Result3 (matrix2 - matrix1):\n"
  swp b
  push b
  call print
  add sp, 2
_for16_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for16_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 3
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for16_exit
_for16_block:
_for17_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for17_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 3
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for17_exit
_for17_block:
  mov b, __string_1 ; " "
  swp b
  push b
  mov b, [__result3]
  push a
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 6
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
  swp b
  push b
  call printn
  add sp, 4
_for17_update:
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
  jmp _for17_cond
_for17_exit:
  mov b, __string_2 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for16_update:
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
  jmp _for16_cond
_for16_exit:
  mov b, __string_2 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 0
  leave
  syscall sys_terminate_proc

assert:
  push bp
  mov bp, sp
_if18_cond:
  mov b, [bp + 5] ; i
  cmp b, 0
  je _if18_else
_if18_true:
  mov b, __string_7 ; "Passed."
  swp b
  push b
  call print
  add sp, 2
  jmp _if18_exit
_if18_else:
  mov b, __string_8 ; "FAILED."
  swp b
  push b
  call print
  add sp, 2
_if18_exit:
  mov b, __string_9 ; "Index: "
  swp b
  push b
  mov b, [__index] ; index
  swp b
  push b
  call printn
  add sp, 4
  mov b, __string_2 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [__index] ; index
  push a
  mov a, b
  inc b
  mov [__index], b
  mov b, a
  pop a
  leave
  ret

add:
  push bp
  mov bp, sp
  mov b, [bp + 7] ; x
  push a
  mov a, b
  mov b, [bp + 5] ; y
  add a, b
  mov b, a
  pop a
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
__index: .dw 0
__matrix1_data: 
.dw 1,2,3,4,5,6,7,8,9,
.fill 0, 0
__matrix1: .dw __matrix1_data
__matrix2_data: 
.dw 9,8,7,6,5,4,3,2,1,
.fill 0, 0
__matrix2: .dw __matrix2_data
__result1_data: .fill 18, 0
__result1: .dw __result1_data
__result2_data: .fill 18, 0
__result2: .dw __result2_data
__result3_data: .fill 18, 0
__result3: .dw __result3_data
__string_0: .db "Matrix1:\n", 0
__string_1: .db " ", 0
__string_2: .db "\n", 0
__string_3: .db "Matrix2:\n", 0
__string_4: .db "Result1 (matrix1 * matrix2):\n", 0
__string_5: .db "Result2 (matrix1 + matrix2):\n", 0
__string_6: .db "Result3 (matrix2 - matrix1):\n", 0
__string_7: .db "Passed.", 0
__string_8: .db "FAILED.", 0
__string_9: .db "Index: ", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
