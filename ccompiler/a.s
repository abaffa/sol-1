; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  mov b, 1
  push a
  mov a, b
  mov b, 3
  mov c, b
  mov b, a
  shl b, cl
  pop a
  mov a, b
  swp a
  mov [bp + -1], a ; i
; --- begin inline asm block
    mov a, [bp + -1]
    swp a
    call print_u16d
  ; --- end inline asm block
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
  leave
  ret
f1:
  push bp
  mov bp, sp
; --- begin inline asm block
    mov al, [bp + 5];
    mov ah, al
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
