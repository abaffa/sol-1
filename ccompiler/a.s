; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; k
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
  mov b, 4
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for1_exit
_for1_block:
  mov b, cc
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  push a
  mov a, b
  mov [bp + -3], a ; k
  pop a
; --- begin inline asm block
      mov a, [bp + -3]
      call print_u16d
      mov a, [m]
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
; --- end text block

; --- begin data block
cc: .dw 11, 22, 33, 44, 
mp: .dw 222, 123, 44, 0, 0, 
matrix: .dw 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 
m_data: .db "\n", 0
m: .dw m_data
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
