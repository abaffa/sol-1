.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; -----begin text block-----
main:
  mov b, 5
  push bl
  mov b, 10
  push b
  mov b, 15
  push b
  call test
  add sp, 5
; -----begin inline asm block-----
  syscall sys_terminate_proc
; -----end inline asm block-----
test:
  push bp
  mov bp, sp
  push word 0
  push byte 0
  push word 0
  mov a, 0
  mov b, 56
  mov a, b
  swp a
  mov [bp + -1], a
  mov a, 0
  mov bl, 'a'
  mov bh, 0
  mov al, bl
  mov [bp + -2], al
  mov a, 0
  mov b, 11
  mov a, b
  swp a
  mov [bp + -4], a
  mov a, 0
  mov b, 1
  mov al, bl
  mov [bp + 9], al
  mov a, 0
  mov b, 2
  mov a, b
  swp a
  mov [bp + 7], a
  mov a, 0
  mov b, 3
  mov a, b
  swp a
  mov [bp + 5], a
  leave
  ret

; -----end text block-----


; -----begin data block-----


; -----end data block-----


; -----begin include block-----

.include "lib/stdio.asm"


; -----end include block-----


.end
