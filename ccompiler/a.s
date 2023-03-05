; --- FILENAME: strcat.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  mov b, [s1]
  swp b
  push b
  call _strlen
  add sp, 2
  mov b, 0
  leave
  syscall sys_terminate_proc
_strlen:
  push bp
  mov bp, sp
  sub sp, 2 ; length
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; length
  pop a
_while1_cond:
  lea d, [bp + 5] ; str
  mov b, [d]
  push a
  mov a, b
  mov b, [bp + -1] ; length
  add a, b
  mov b, a
  pop a
  mov d, b
  mov bl, [d]
  mov bh, 0
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while1_exit
_while1_block:
  mov b, [bp + -1] ; length
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; length
  pop a
  jmp _while1_cond
_while1_exit:
  mov b, [bp + -1] ; length
  leave
  ret
_strcat:
  push bp
  mov bp, sp
  sub sp, 2 ; dest_len
  sub sp, 2 ; i
  lea d, [bp + 7] ; dest
  mov b, [d]
  swp b
  push b
  call _strlen
  add sp, 2
  push a
  mov a, b
  mov [bp + -1], a ; dest_len
  pop a
_for2_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; i
  pop a
_for2_cond:
  lea d, [bp + 5] ; src
  mov b, [d]
  push a
  mov a, b
  mov b, [bp + -3] ; i
  add a, b
  mov b, a
  pop a
  mov d, b
  mov bl, [d]
  mov bh, 0
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for2_exit
_for2_block:
  lea d, [bp + 7] ; dest
  mov b, [d]
  push a
  mov a, b
  mov b, [bp + -1] ; dest_len
  add a, b
  mov b, a
  mov a, b
  mov b, [bp + -3] ; i
  add a, b
  mov b, a
  pop a
  mov d, b
  lea d, [bp + 5] ; src
  mov b, [d]
  push a
  mov a, b
  mov b, [bp + -3] ; i
  add a, b
  mov b, a
  pop a
  mov d, b
  mov bl, [d]
  mov bh, 0
  mov a, b
  mov [d], a
_for2_update:
  mov b, [bp + -3] ; i
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; i
  pop a
  jmp _for2_cond
_for2_exit:
  lea d, [bp + 7] ; dest
  mov b, [d]
  push a
  mov a, b
  mov b, [bp + -1] ; dest_len
  add a, b
  mov b, a
  mov a, b
  mov b, [bp + -3] ; i
  add a, b
  mov b, a
  pop a
  mov d, b
  mov b, 0
  mov a, b
  mov [d], a
  lea d, [bp + 7] ; dest
  mov b, [d]
  leave
  ret
scann:
  push bp
  mov bp, sp
  sub sp, 2 ; m

; --- BEGIN INLINE ASM BLOCK
  call scan_u16d
  mov [bp + -1], a
; --- END INLINE ASM BLOCK

  lea d, [bp + 5] ; n
  mov b, [d]
  mov d, b
  mov b, [bp + -1] ; m
  mov a, b
  mov [d], a
  leave
  ret
printn:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [bp + 5]
  call print_u16d
; --- END INLINE ASM BLOCK

  leave
  ret
print:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [bp + 5]
  mov d, a
  call puts
; --- END INLINE ASM BLOCK

  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
s1_data: 
.dw 'H', 'e', 'l', 'l', 'o', 0,
.fill 88, 0
s1: .dw s1_data
s2_data: .db ". My name is Sol-1.", 0
s2: .dw s2_data
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
