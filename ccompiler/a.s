; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  sub sp, 10 ; c1
  sub sp, 2 ; p
  lea d, [bp + -9] ; c1
  mov b, d
  mov a, b
  swp a
  mov [bp + -11], a ; p
  sub sp, 2 ; i
_for1_init:
  mov b, 0
  mov a, b
  swp a
  mov [bp + -13], a ; i
_for1_cond:
  mov b, [bp + -13] ; i
  swp b
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
  lea d, [bp + -11] ; p
  mov b, [d]
  swp b
  mov d, b
  mov bl, 'A'
  push a
  mov a, b
  mov b, [bp + -13] ; i
  swp b
  add a, b
  mov b, a
  pop a
  mov al, bl
  mov [d], al
_for1_update:
  mov b, [bp + -13] ; i
  swp b
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  mov a, b
  swp a
  mov [bp + -13], a ; i
  jmp _for1_cond
_for1_exit:
  lea d, [bp + -11] ; p
  mov b, [d]
  swp b
  push b
  call f1
  add sp, 2
  leave
  syscall sys_terminate_proc
f1:
  push bp
  mov bp, sp
  sub sp, 1 ; cc
  lea d, [bp + 5] ; c
  mov b, [d]
  swp b
  mov d, b
  mov b, 1
  add d, b
  mov bl, [d]
  mov al, bl
  mov [bp + 0], al ; cc
; --- begin inline asm block
    mov a, [bp + 0];
    swp a
    call putchar
  ; --- end inline asm block
  leave
  ret
; --- end text block

; --- begin data block
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
