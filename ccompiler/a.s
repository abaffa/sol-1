; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  sub sp, 2 ; j
  mov b, 6
  swp b
  push b
  call fact
  add sp, 2
  push a
  mov a, b
  mov [bp + -1], a ; j
  pop a
; --- begin inline asm block
      mov a, [bp + -1]
      call print_u16d

    ; --- end inline asm block
  leave
  syscall sys_terminate_proc
fact:
  push bp
  mov bp, sp
  sub sp, 2 ; nn
_if1_cond:
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
  je _if1_else
_if1_true:
  mov b, 1
  leave
  ret
  jmp _if1_exit
_if1_else:
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
_if1_exit:
; --- end text block

; --- begin data block
s_data: .db "\n", 0
s: .dw s_data
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
