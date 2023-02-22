; --- FILENAME: auto.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  call initialize
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
  mov b, 100
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for1_exit
_for1_block:
  call compute_next
  call update_current
  call display
_for1_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for1_cond
_for1_exit:
  leave
  syscall sys_terminate_proc
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
initialize:
  push bp
  mov bp, sp
  mov b, current
  mov d, b
  mov b, 25
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 1
  pop d
  mov a, b
  mov [d], a
  leave
  ret
compute_next:
  push bp
  mov bp, sp
  sub sp, 2 ; left
  sub sp, 2 ; right
  sub sp, 2 ; i
_for2_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -5], a ; i
  pop a
_for2_cond:
  mov b, [bp + -5] ; i
  push a
  mov a, b
  mov b, [SIZE]
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for2_exit
_for2_block:
_ternary3_cond:
  mov b, [bp + -5] ; i
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _ternary3_false
_ternary3_true:
  mov b, current
  mov d, b
  mov b, [SIZE]
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  jmp _ternary3_exit
_ternary3_false:
  mov b, current
  mov d, b
  mov b, [bp + -5] ; i
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
_ternary3_exit:
  push a
  mov a, b
  mov [bp + -1], a ; left
  pop a
_ternary4_cond:
  mov b, [bp + -5] ; i
  push a
  mov a, b
  mov b, [SIZE]
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _ternary4_false
_ternary4_true:
  mov b, current
  mov d, b
  mov b, 0
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  jmp _ternary4_exit
_ternary4_false:
  mov b, current
  mov d, b
  mov b, [bp + -5] ; i
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
_ternary4_exit:
  push a
  mov a, b
  mov [bp + -3], a ; right
  pop a
_if5_cond:
  mov b, [bp + -1] ; left
  push a
  mov a, b
  mov b, [bp + -3] ; right
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if5_else
_if5_true:
  mov b, next
  mov d, b
  mov b, [bp + -5] ; i
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
  jmp _if5_exit
_if5_else:
  mov b, next
  mov d, b
  mov b, [bp + -5] ; i
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 1
  pop d
  mov a, b
  mov [d], a
_if5_exit:
_for2_update:
  mov b, [bp + -5] ; i
  inc b
  push a
  mov a, b
  mov [bp + -5], a ; i
  pop a
  jmp _for2_cond
_for2_exit:
  leave
  ret
update_current:
  push bp
  mov bp, sp
  sub sp, 2 ; i
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
  mov b, [SIZE]
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for6_exit
_for6_block:
  mov b, current
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, next
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop d
  mov a, b
  mov [d], a
_for6_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for6_cond
_for6_exit:
  leave
  ret
display:
  push bp
  mov bp, sp
  sub sp, 1 ; c
  sub sp, 2 ; i
_for7_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -2], a ; i
  pop a
_for7_cond:
  mov b, [bp + -2] ; i
  push a
  mov a, b
  mov b, [SIZE]
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for7_exit
_for7_block:
_if8_cond:
  mov b, current
  mov d, b
  mov b, [bp + -2] ; i
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if8_else
_if8_true:
  mov b, ast
  swp b
  push b
  call print
  add sp, 2
  jmp _if8_exit
_if8_else:
  mov b, space
  swp b
  push b
  call print
  add sp, 2
_if8_exit:
_for7_update:
  mov b, [bp + -2] ; i
  inc b
  push a
  mov a, b
  mov [bp + -2], a ; i
  pop a
  jmp _for7_cond
_for7_exit:
  mov b, line
  swp b
  push b
  call print
  add sp, 2
  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
SIZE: .dw 50
line_data: .db "\n", 0
line: .dw line_data
ast_data: .db "*", 0
ast: .dw ast_data
space_data: .db " ", 0
space: .dw space_data
current: .dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
next: .dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
