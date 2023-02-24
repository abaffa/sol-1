; --- FILENAME: auto.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
_while1_cond:
  mov b, 1
  cmp b, 0
  je _while1_exit
_while1_block:
  call initialize
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
  call compute_next
  call update_current
  call display
_for2_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for2_cond
_for2_exit:
  jmp _while1_cond
_while1_exit:
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
  mov b, [current]
  mov d, b
  mov b, [SIZE]
  push a
  mov a, b
  mov b, 2
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
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
_for3_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -5], a ; i
  pop a
_for3_cond:
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
  je _for3_exit
_for3_block:
_ternary4_cond:
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
  je _ternary4_false
_ternary4_true:
  mov b, [current]
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
  jmp _ternary4_exit
_ternary4_false:
  mov b, [current]
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
_ternary4_exit:
  push a
  mov a, b
  mov [bp + -1], a ; left
  pop a
_ternary5_cond:
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
  je _ternary5_false
_ternary5_true:
  mov b, [current]
  mov d, b
  mov b, 0
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  jmp _ternary5_exit
_ternary5_false:
  mov b, [current]
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
_ternary5_exit:
  push a
  mov a, b
  mov [bp + -3], a ; right
  pop a
_if6_cond:
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
  je _if6_else
_if6_true:
  mov b, [next]
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
  jmp _if6_exit
_if6_else:
  mov b, [next]
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
_if6_exit:
_for3_update:
  mov b, [bp + -5] ; i
  inc b
  push a
  mov a, b
  mov [bp + -5], a ; i
  pop a
  jmp _for3_cond
_for3_exit:
  leave
  ret
update_current:
  push bp
  mov bp, sp
  sub sp, 2 ; i
_for7_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for7_cond:
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
  je _for7_exit
_for7_block:
  mov b, [current]
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [next]
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop d
  mov a, b
  mov [d], a
_for7_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for7_cond
_for7_exit:
  leave
  ret
display:
  push bp
  mov bp, sp
  sub sp, 1 ; c
  sub sp, 2 ; i
_for8_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -2], a ; i
  pop a
_for8_cond:
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
  je _for8_exit
_for8_block:
_if9_cond:
  mov b, [current]
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
  je _if9_else
_if9_true:
  mov b, [ast]
  swp b
  push b
  call print
  add sp, 2
  jmp _if9_exit
_if9_else:
  mov b, [space]
  swp b
  push b
  call print
  add sp, 2
_if9_exit:
_for8_update:
  mov b, [bp + -2] ; i
  inc b
  push a
  mov a, b
  mov [bp + -2], a ; i
  pop a
  jmp _for8_cond
_for8_exit:
  mov b, [line]
  swp b
  push b
  call print
  add sp, 2
  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
SIZE: .dw 100
line_data: .db "\n", 0
line: .dw line_data
ast_data: .db "*", 0
ast: .dw ast_data
space_data: .db " ", 0
space: .dw space_data
current_data: .dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
current: .dw current_data
next_data: .dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
next: .dw next_data
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
