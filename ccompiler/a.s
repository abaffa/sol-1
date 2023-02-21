; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
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
  mov b, 10
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
  mov [bp + -3], a ; j
  pop a
_for2_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for2_exit
_for2_block:
  mov b, m
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 10
  mul a, b
  add d, b
  mov b, [bp + -3] ; j
  mov a, 1
  mul a, b
  add d, b
  push d
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, [bp + -3] ; j
  add a, b
  mov b, a
  pop a
  pop d
  mov al, bl
  mov [d], al
_for2_update:
  mov b, [bp + -3] ; j
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
  jmp _for2_cond
_for2_exit:
_for1_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for1_cond
_for1_exit:
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
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010
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
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for4_exit
_for4_block:
  mov b, m
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 10
  mul a, b
  add d, b
  mov b, [bp + -3] ; j
  mov a, 1
  mul a, b
  add d, b
  mov bl, [d]
  swp b
  push b
  call print_nbr
  add sp, 2
_for4_update:
  mov b, [bp + -3] ; j
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
  jmp _for4_cond
_for4_exit:
_for3_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for3_cond
_for3_exit:
  leave
  syscall sys_terminate_proc
print_nbr:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [bp + 5]
  call print_u16d
  mov a, [ss]
  mov d, a
  call puts
; --- END INLINE ASM BLOCK

  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
m: .db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
ss_data: .db "\n", 0
ss: .dw ss_data
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
