; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
_for1_init:
  mov b, 0
  mov [i], b
_for1_cond:
  mov b, 1
  cmp b, 0
  je _for1_exit
_for1_block:
; --- begin inline asm block
      mov a, [s]
      mov d, a
      call puts

      mov a, [i]
      call print_u16d

      mov a, [NL]
      mov d, a
      call puts
    ; --- end inline asm block
_for1_update:
  mov b, [i]
  inc b
  mov [i], b
  jmp _for1_cond
_for1_exit:
  leave
  syscall sys_terminate_proc
; --- end text block

; --- begin data block
s_data: .db "Baffa Emulator is the best!!! >>> ", 0
s: .dw s_data
i: .fill 2, 00
NL_data: .db "\n", 0
NL: .dw NL_data
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
