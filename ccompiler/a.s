; --- Filename: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
  mov b, [j]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [i]
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
  push a
  lodflgs
  mov b, a
  pop a
  not bl
  and bl, %00000001
  mov bh, 0
  cmp a, 0
  lodflgs
  not al
  and al, %00000001
  mov ah, 0
  and a, b
  mov b, a
  pop a
  leave
  syscall sys_terminate_proc
; --- end text block

; --- begin data block
s_data: .db "Enter the number of rows: ", 0
s: .dw s_data
ss_data: .db "     ", 0
ss: .dw ss_data
coef: .fill 2, 00
rows: .fill 2, 00
space: .fill 2, 00
i: .fill 2, 00
j: .fill 2, 00
nl_data: .db "\n\r", 0
nl: .dw nl_data
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
