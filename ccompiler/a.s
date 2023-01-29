; --- Filename: test.c

.include "lib/kernel.exp"

.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
_do1_block:
  mov b, [i]
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  mov [i], b
; --- begin asm block
      mov a, [i]
      call print_u16d

      mov a, [nl]
      mov d, a
      call puts
    ; --- end asm block
_do1_cond:
  mov b, [i]
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 1
  je _do1_block
_do1_exit:
  leave
  syscall sys_terminate_proc
; --- end text block

; --- begin data block
nl_data: .db "\n\r", 0
nl: .dw nl_data
i: .dw 0
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
