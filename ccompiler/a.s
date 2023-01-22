; --- Filename: test.c

.include "lib/kernel.exp"

.org PROC_TEXT_ORG

; --- begin text block
main:
	push bp
	mov bp, sp
  push word 0 ; b
  push word 0 ; c
  mov b, 1
  mov a, b
  swp a
  mov [bp + -1], a ; b
  leave
  syscall sys_terminate_proc
test:
	push bp
	mov bp, sp
  push word 5 ; ii
  push word 67 ; yy
  mov b, [bp + 5] ; a
  swp b
  leave
  ret
; --- end text block

; --- begin data block
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
