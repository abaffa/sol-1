; --- Filename: test.c

.include "lib/kernel.exp"

.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  mov b, s1
  mov [p], b
  mov b, [p]
  mov d, b
  mov b, [d]
  mov [s2], b
; --- begin asm block
    mov a, [s2]
    mov d, a
    call puts
  ; --- end asm block
  leave
  syscall sys_terminate_proc
; --- end text block

; --- begin data block
s1_data: .db "Hello World", 0
s1: .dw s1_data
p: .dw 0
s2: .dw 0
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
