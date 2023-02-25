; --- FILENAME: life2.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  call update_game
  mov b, 0
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
update_game:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
  sub sp, 2 ; ni
  sub sp, 2 ; nj
  sub sp, 2 ; count
_for1_init:
  mov b, 1
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for1_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 20
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
  mov b, 1
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for2_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 20
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for2_exit
_for2_block:
  mov b, 0
  push a
  mov a, b
  mov [bp + -9], a ; count
  pop a
_for3_init:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -5], a ; ni
  pop a
_for3_cond:
  mov b, [bp + -5] ; ni
  push a
  mov a, b
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  cmp a, b
  lodflgs
  and al, %00000011
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for3_exit
_for3_block:
_for4_init:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -7], a ; nj
  pop a
_for4_cond:
  mov b, [bp + -7] ; nj
  push a
  mov a, b
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  cmp a, b
  lodflgs
  and al, %00000011
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for4_exit
_for4_block:
_if5_cond:
  mov b, [bp + -5] ; ni
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000010
  mov ah, 0
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [bp + -5] ; ni
  push a
  mov a, b
  mov b, 20
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  and a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [bp + -7] ; nj
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000010
  mov ah, 0
  mov b, a
  pop a
  and a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [bp + -7] ; nj
  push a
  mov a, b
  mov b, 20
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  and a, b
  mov b, a
  pop a
  cmp b, 0
  je _if5_exit
_if5_true:
_if6_cond:
  mov b, [bp + -5] ; ni
  push a
  mov a, b
  mov b, [bp + -1] ; i
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [bp + -7] ; nj
  push a
  mov a, b
  mov b, [bp + -3] ; j
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  or a, b
  mov b, a
  pop a
  cmp b, 0
  je _if6_exit
_if6_true:
  mov b, [bp + -9] ; count
  push a
  mov a, b
  mov b, [curr_state]
  mov d, b
  mov b, [bp + -5] ; ni
  mov a, 40
  mul a, b
  add d, b
  mov b, [bp + -7] ; nj
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov [bp + -9], a ; count
  pop a
  jmp _if6_exit
_if6_exit:
  jmp _if5_exit
_if5_exit:
_for4_update:
  mov b, [bp + -7] ; nj
  inc b
  push a
  mov a, b
  mov [bp + -7], a ; nj
  pop a
  jmp _for4_cond
_for4_exit:
_for3_update:
  mov b, [bp + -5] ; ni
  inc b
  push a
  mov a, b
  mov [bp + -5], a ; ni
  pop a
  jmp _for3_cond
_for3_exit:
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
  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
curr_state_data: .fill 800, 0
curr_state: .dw curr_state_data
next_state_data: .fill 800, 0
next_state: .dw next_state_data
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
