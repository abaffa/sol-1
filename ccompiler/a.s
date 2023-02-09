; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  sub sp, 2 ; j
  sub sp, 2 ; i
  sub sp, 2 ; k
  mov b, 5
  push a
  mov a, b
  mov [bp + -5], a ; k
  pop a
  mov b, 10
  push a
  mov a, b
  mov [bp + -1], a ; j
  pop a
_ternary1_cond:
  mov b, [bp + -1] ; j
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, %00000000
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _ternary1_false
_ternary1_true:
_ternary2_cond:
  mov b, [bp + -5] ; k
  push a
  mov a, b
  mov b, 2
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _ternary3_false
_ternary3_true:
  mov b, 11
  jmp _ternary3_exit
_ternary3_false:
  mov b, 23
_ternary3_exit:
  jmp _ternary1_exit
_ternary1_false:
  mov b, 66
_ternary1_exit:
; --- begin inline asm block
    mov a, [bp + -3]
    call print_u16d
  ; --- end inline asm block
  leave
  syscall sys_terminate_proc
; --- end text block

; --- begin data block
s_data: .db "\n", 0
s: .dw s_data
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
