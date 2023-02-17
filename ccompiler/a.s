; --- Filename: clock.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  call gen_clk
  leave
  syscall sys_terminate_proc
gen_clk:
  push bp
  mov bp, sp
  sub sp, 2 ; clk
  sub sp, 2 ; count
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; clk
  pop a
_for1_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; count
  pop a
_for1_cond:
  mov b, [bp + -3] ; count
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
_if2_cond:
  mov b, [bp + -1] ; clk
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
  je _if2_else
_if2_true:
  mov b, 1
  push a
  mov a, b
  mov [bp + -1], a ; clk
  pop a
  jmp _if2_exit
_if2_else:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; clk
  pop a
_if2_exit:
  mov b, [bp + -1] ; clk
  swp b
  push b
  call print
  add sp, 2
_for1_update:
  mov b, [bp + -3] ; count
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; count
  pop a
  jmp _for1_cond
_for1_exit:
  leave
  ret
print:
  push bp
  mov bp, sp
; --- begin inline asm block
    mov a, [bp + 5]
    call print_u16d
    mov ah, $0A
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
