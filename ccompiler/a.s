; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  sub sp, 100 ; m
  sub sp, 2 ; i
  sub sp, 2 ; j
_for1_init:
  mov b, 0
  mov a, b
  swp a
  mov [bp + -101], a ; i
_for1_cond:
  mov b, [bp + -101] ; i
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
_for2_init:
  mov b, 0
  mov a, b
  swp a
  mov [bp + -103], a ; j
_for2_cond:
  mov b, [bp + -103] ; j
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
  je _for2_exit
_for2_block:
  lea d, [bp + -99] ; m
  mov b, d
  mov d, b
  mov b, [bp + -101] ; i
  swp b
  mov a, 10
  mul a, b
  add d, b
  mov b, [bp + -103] ; j
  swp b
  add d, b
  mov bl, 'A'
  mov bl, al
  mov [d], al
_for2_update:
  mov b, [bp + -103] ; j
  swp b
  inc b
  mov a, b
  swp a
  mov [bp + -103], a ; j
  jmp _for2_cond
_for2_exit:
_for1_update:
  mov b, [bp + -101] ; i
  swp b
  inc b
  mov a, b
  swp a
  mov [bp + -101], a ; i
  jmp _for1_cond
_for1_exit:
  leave
  syscall sys_terminate_proc
_puts:
  push bp
  mov bp, sp
; --- begin inline asm block
    mov a, [bp + 5]
    mov d, a
    swp a
    call puts
  ; --- end inline asm block
f1:
  push bp
  mov bp, sp
  sub sp, 1 ; cc
  lea d, [bp + 5] ; c
  mov b, [d]
  swp b
  mov d, b
  mov b, 1
  mov a, 10
  mul a, b
  add d, b
  mov b, 0
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
