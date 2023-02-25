; --- FILENAME: count.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov d, s_data
  call puts
  call scan_u16d
  mov [num], a
; --- END INLINE ASM BLOCK

_for1_init:
  mov b, 1
  mov [i], b
_for1_cond:
  mov b, [i]
  push a
  mov a, b
  mov b, [num]
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for1_exit
_for1_block:

; --- BEGIN INLINE ASM BLOCK
  mov a, [i]
  call print_u16d
  mov d, nl_data
  call puts
; --- END INLINE ASM BLOCK

_for1_update:
  mov b, [i]
  inc b
  mov [i], b
  jmp _for1_cond
_for1_exit:
  leave
  syscall sys_terminate_proc
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
s_data: .db "Enter a positive integer: ", 0
s: .dw s_data
nl_data: .db "\n", 0
nl: .dw nl_data
i: .fill 2, 0
num: .fill 2, 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
