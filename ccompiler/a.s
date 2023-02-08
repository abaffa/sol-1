; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
_for1_init:
  mov b, 2
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for1_cond:
  mov b, 1
  cmp b, 0
  je _for1_exit
_for1_block:
  mov b, [bp + -1] ; i
  swp b
  push b
  call fact
  add sp, 2
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
; --- begin inline asm block
      mov a, [bp + -3]
      call print_u16d

      mov a, [s]
      mov d, a
      call puts
    ; --- end inline asm block
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
fact:
  push bp
  mov bp, sp
  sub sp, 2 ; nn
_if2_cond:
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if2_else_block
_if2_block:
  mov b, 1
  leave
  ret
  jmp _if2_exit
_if2_else_block:
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  swp b
  push b
  call fact
  add sp, 2
  mul a, b
  pop a
  push a
  mov a, b
  mov [bp + -1], a ; nn
  pop a
  mov b, [bp + -1] ; nn
  leave
  ret
_if2_exit:
; --- end text block

; --- begin data block
s_data: .db "\n", 0
s: .dw s_data
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
