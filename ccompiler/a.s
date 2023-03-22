; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  mov b, 1
  push a
  mov a, b
  mov b, 2
  cmp a, b
  lodflgs
  mov g, a
  mov bl, al
  shr al
  xor bl, al
  shr al, 2
  mov b, g
  and bl, %00000001
  or al, bl
  xor al, %00000001 ; > (signed)
  mov ah, 0
  mov b, a
  pop a
  mov b, 1
  push a
  mov a, b
  mov b, 2
  cmp a, b
  lodflgs
  mov bl, al
  shr al
  xor al, bl
  shr al, 2
  xor al, %00000001 ; >= (signed)
  mov ah, 0
  mov b, a
  pop a
  mov b, 1
  push a
  mov a, b
  mov b, 2
  cmp a, b
  lodflgs
  mov bl, al
  shr al
  xor al, bl
  shr al, 2
  xor al, bl ; < (signed)
  mov ah, 0
  mov b, a
  pop a
  mov b, 1
  push a
  mov a, b
  mov b, 2
  cmp a, b
  lodflgs
  mov g, a
  mov bl, al
  shr al
  xor al, bl
  shr al, 2
  mov b, g
  and bl, %00000001
  or al, bl ; <= (signed)
  mov ah, 0
  mov b, a
  pop a
  leave
  syscall sys_terminate_proc
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
