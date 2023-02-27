; --- FILENAME: test2.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
_for1_init:
  mov b, 0
  mov [infi], b
_for1_cond:
  mov b, [infi]
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for1_exit
_for1_block:
  mov b, 0
  mov [pc], b
  mov b, 12312
  swp b
  push b
  call displaynumber
  add sp, 2
  call readint
  mov [cmdadr], b
_if2_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 120
  cmp a, b
  lodflgs
  and al, %00000011 ; <=
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if2_exit
_if2_true:
  call readint
  mov [opr], b
  call readint
  mov [datadr1], b
  call readint
  mov [datadr2], b
  call readint
  mov [datadr3], b
  mov b, [instruction]
  mov d, b
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [opr]
  pop d
  mov a, b
  mov [d], a
  mov b, [instruction]
  mov d, b
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 4
  mul a, b
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [datadr1]
  pop d
  mov a, b
  mov [d], a
  mov b, [instruction]
  mov d, b
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 4
  mul a, b
  mov a, b
  mov b, 2
  add a, b
  mov b, a
  pop a
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [datadr2]
  pop d
  mov a, b
  mov [d], a
  mov b, [instruction]
  mov d, b
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 4
  mul a, b
  mov a, b
  mov b, 3
  add a, b
  mov b, a
  pop a
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [datadr3]
  pop d
  mov a, b
  mov [d], a
  mov b, [cmdadr]
  swp b
  push b
  call displaynumber
  add sp, 2
  mov b, [opr]
  swp b
  push b
  call displaynumber
  add sp, 2
  mov b, [datadr1]
  swp b
  push b
  call displaynumber
  add sp, 2
  mov b, [datadr2]
  swp b
  push b
  call displaynumber
  add sp, 2
  mov b, [datadr3]
  swp b
  push b
  call displaynumber
  add sp, 2
_if3_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if3_exit
_if3_true:
  jmp _for3_exit
  jmp _if3_exit
_if3_exit:
  jmp _if2_exit
_if2_exit:
_for1_update:
  mov b, [infi]
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  mov [infi], b
  jmp _for1_cond
_for1_exit:
  leave
  syscall sys_terminate_proc
readint:
  push bp
  mov bp, sp
  sub sp, 2 ; n

; --- BEGIN INLINE ASM BLOCK
  call scan_u16d
  mov [bp + -1], a
; --- END INLINE ASM BLOCK

  mov b, [bp + -1] ; n
  leave
  ret
displaynumber:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [bp + 5]
  call print_u16d
  mov a, [ss]
  mov d, a
  call puts
; --- END INLINE ASM BLOCK

  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
ss_data: .db "\n", 0
ss: .dw ss_data
datum_data: .fill 246, 0
datum: .dw datum_data
instruction_data: .fill 240, 0
instruction: .dw instruction_data
cmdadr: .dw 0
opr: .dw 0
datadr1: .dw 0
datadr2: .dw 0
datadr3: .dw 0
pc: .dw 0
h: .dw 0
i: .dw 0
j: .dw 0
k: .dw 0
l: .dw 0
p: .dw 0
infi: .dw 0
runlimit: .dw 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
