; --- FILENAME: auto2.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
  mov b, [state]
  mov d, b
  mov b, 20
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
  mov b, [state]
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  swp b
  push b
  call printn
  add sp, 2
_for1_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for1_cond
_for1_exit:
  mov b, _string_0
  swp b
  push b
  call print
  add sp, 2
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
_for3_init:
  mov b, 1
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for3_cond:
  mov b, [bp + -1] ; i
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
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for3_exit
_for3_block:
  mov b, [next_state]
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [state]
  mov d, b
  mov b, [bp + -1] ; i
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
  push a
  mov a, b
  mov b, [state]
  mov d, b
  mov b, [bp + -1] ; i
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
  xor a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
_for3_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for3_cond
_for3_exit:
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
  mov b, 20
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for4_exit
_for4_block:
  mov b, [state]
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [next_state]
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop d
  mov a, b
  mov [d], a
_for4_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for4_cond
_for4_exit:
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
  mov b, 20
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for5_exit
_for5_block:
  mov b, [state]
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  swp b
  push b
  call printn
  add sp, 2
_for5_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for5_cond
_for5_exit:
  mov b, _string_0
  swp b
  push b
  call print
  add sp, 2
_for2_update:
  mov b, [bp + -3] ; j
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
  jmp _for2_cond
_for2_exit:
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
printn:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [bp + 5]
  call print_u8d
; --- END INLINE ASM BLOCK

  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
state_data: .fill 40, 0
state: .dw state_data
next_state_data: .fill 40, 0
next_state: .dw next_state_data
_string_0: .db "\n", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
