; --- Filename: test.c

.include "lib/kernel.exp"

.org PROC_TEXT_ORG

; --- begin text block
main:
	push bp
	mov bp, sp
; --- begin asm block

    mov [g], a
    mov a, [g]
  ; --- end asm block
test:
	push bp
	mov bp, sp
; --- begin asm block

    mov a, [bp + 5]
    mov [bp + 5], a
  ; --- end asm block
; --- end text block

; --- begin data block
g: .dw 0
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
