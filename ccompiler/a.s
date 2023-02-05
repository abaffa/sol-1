; --- Filename: 1v0.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- begin text block
displaynumber:
  push bp
  mov bp, sp
readint:
  push bp
  mov bp, sp
  mov b, 10
  leave
  ret
main:
  push bp
  mov bp, sp
_while1_cond:
  mov b, 1
  cmp b, 0
  je _while1_exit
_while1_block:
  mov b, 3600
  mov [runlimit], b
_while2_cond:
  mov b, 1
  cmp b, 0
  je _while2_exit
_while2_block:
  mov b, 0
  mov [pc], b
  mov b, 12312
  call displaynumber
  call readint
  mov [cmdadr], b
_if3_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 255
  cmp a, b
  lodflgs
  and al, %00000011
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if3_else_block
_if3_block:
  call readint
  mov [opr], b
  call readint
  mov [datadr1], b
  call readint
  mov [datadr2], b
  call readint
  mov [datadr3], b
  mov b, instruction
  mov d, b
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  add d, b
  mov b, [opr]
  mov b, a
  mov [d], a
  mov b, instruction
  mov d, b
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  add d, b
  mov b, [datadr1]
  mov b, a
  mov [d], a
  mov b, instruction
  mov d, b
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 2
  add a, b
  mov b, a
  pop a
  add d, b
  mov b, [datadr2]
  mov b, a
  mov [d], a
  mov b, instruction
  mov d, b
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 3
  add a, b
  mov b, a
  pop a
  add d, b
  mov b, [datadr3]
  mov b, a
  mov [d], a
_if4_cond:
  mov b, [cmdadr]
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
  je _if4_exit
_if4_block:
  jmp _while2_exit
  jmp _if4_exit
_if4_exit:
  jmp _if3_exit
_if3_else_block:
_if5_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 1111
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if5_else_block
_if5_block:
  call readint
  mov [i], b
  mov b, instruction
  mov d, b
  mov b, [i]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  add d, b
  mov b, [d]
  call displaynumber
  mov b, instruction
  mov d, b
  mov b, [i]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  add d, b
  mov b, [d]
  call displaynumber
  mov b, instruction
  mov d, b
  mov b, [i]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 2
  add a, b
  mov b, a
  pop a
  add d, b
  mov b, [d]
  call displaynumber
  mov b, instruction
  mov d, b
  mov b, [i]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 3
  add a, b
  mov b, a
  pop a
  add d, b
  mov b, [d]
  call displaynumber
  jmp _if5_exit
_if5_else_block:
_if6_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 2222
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if6_else_block
_if6_block:
  call readint
  mov [i], b
  mov b, datum
  mov d, b
  mov b, [i]
  add d, b
  mov b, [d]
  call displaynumber
  jmp _if6_exit
_if6_else_block:
_if7_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 4444
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if7_else_block
_if7_block:
  mov b, datum
  mov d, b
  call readint
  add d, b
  call readint
  mov b, a
  mov [d], a
  jmp _if7_exit
_if7_else_block:
_if8_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 5555
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if8_else_block
_if8_block:
_for9_init:
  mov b, 0
  mov [i], b
_for9_cond:
  mov b, [i]
  push a
  mov a, b
  mov b, 255
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for9_exit
_for9_block:
  mov b, instruction
  mov d, b
  mov b, [i]
  add d, b
  mov b, 0
  mov b, a
  mov [d], a
_for9_update:
  mov b, [i]
  inc b
  mov [i], b
  jmp _for9_cond
_for9_exit:
  jmp _if8_exit
_if8_else_block:
_if10_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 6666
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if10_else_block
_if10_block:
_for11_init:
  mov b, [datadr1]
  mov [i], b
_for11_cond:
  mov b, [i]
  push a
  mov a, b
  mov b, 1023
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for11_exit
_for11_block:
  mov b, datum
  mov d, b
  mov b, [i]
  add d, b
  mov b, 0
  mov b, a
  mov [d], a
_for11_update:
  mov b, [i]
  inc b
  mov [i], b
  jmp _for11_cond
_for11_exit:
  jmp _if10_exit
_if10_else_block:
_if12_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 9999
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if12_exit
_if12_block:
  call readint
  mov [runlimit], b
  jmp _if12_exit
_if12_exit:
_if10_exit:
_if8_exit:
_if7_exit:
_if6_exit:
_if5_exit:
_if3_exit:
  jmp _while2_cond
_while2_exit:
_while13_cond:
  mov b, [pc]
  push a
  mov a, b
  mov b, 255
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while13_exit
_while13_block:
_if14_cond:
  mov b, [runlimit]
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if14_else_block
_if14_block:
  jmp _while13_exit
  jmp _if14_exit
_if14_else_block:
_if15_cond:
  mov b, [runlimit]
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000011
  mov b, a
  pop a
  cmp b, 0
  je _if15_exit
_if15_block:
  mov b, [runlimit]
  dec b
  mov [runlimit], b
  jmp _if15_exit
_if15_exit:
_if14_exit:
  mov b, datum
  mov d, b
  mov b, 0
  add d, b
  mov b, 0
  mov b, a
  mov [d], a
  mov b, instruction
  mov d, b
  mov b, [pc]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  add d, b
  mov b, [d]
  mov [opr], b
  mov b, instruction
  mov d, b
  mov b, [pc]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  add d, b
  mov b, [d]
  mov [datadr1], b
  mov b, instruction
  mov d, b
  mov b, [pc]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 2
  add a, b
  mov b, a
  pop a
  add d, b
  mov b, [d]
  mov [datadr2], b
  mov b, instruction
  mov d, b
  mov b, [pc]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 3
  add a, b
  mov b, a
  pop a
  add d, b
  mov b, [d]
  mov [datadr3], b
_if16_cond:
  mov b, [h]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000011
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [k]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000011
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
  or a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [l]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000011
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
  or a, b
  mov b, a
  pop a
  cmp b, 0
  je _if16_exit
_if16_block:
  mov b, [h]
  mov [datadr1], b
  mov b, [k]
  mov [datadr2], b
  mov b, [l]
  mov [datadr3], b
  mov b, 0
  mov [h], b
  mov b, 0
  mov [k], b
  mov b, 0
  mov [l], b
  jmp _if16_exit
_if16_exit:
  mov b, [pc]
  push a
  mov a, b
  mov b, 100
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [opr]
  add a, b
  mov b, a
  pop a
  call displaynumber
_if17_cond:
  mov b, [opr]
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
  je _if17_else_block
_if17_block:
  jmp _if17_exit
_if17_else_block:
_if18_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if18_else_block
_if18_block:
  mov b, 0
  mov [k], b
_if19_cond:
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 6
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000011
  mov b, a
  pop a
  cmp b, 0
  je _if19_exit
_if19_block:
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 7
  sub a, b
  mov b, a
  pop a
  mov [datadr3], b
  mov b, 64
  mov [k], b
  jmp _if19_exit
_if19_exit:
_if20_cond:
  mov b, datum
  mov d, b
  mov b, [datadr1]
  add d, b
  mov b, [d]
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
  mov b, [datadr3]
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
  push a
  mov a, b
  mov b, datum
  mov d, b
  mov b, [datadr1]
  add d, b
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000011
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 1
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
  or a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, datum
  mov d, b
  mov b, [datadr1]
  add d, b
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000010
  mov ah, 0
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 2
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
  or a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, datum
  mov d, b
  mov b, [datadr1]
  add d, b
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000010
  xor al, %00000010
  mov ah, 0
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 3
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
  or a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, datum
  mov d, b
  mov b, [datadr1]
  add d, b
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  mov ah, 0
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 4
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
  or a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, datum
  mov d, b
  mov b, [datadr1]
  add d, b
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 5
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
  or a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 6
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
  or a, b
  mov b, a
  pop a
  cmp b, 0
  je _if20_else_block
_if20_block:
  mov b, [datadr2]
  push a
  mov a, b
  mov b, [k]
  add a, b
  mov b, a
  pop a
  mov [pc], b
  mov b, 0
  mov [k], b
  jmp _if20_exit
_if20_else_block:
  mov b, [pc]
  inc b
  mov [pc], b
_if20_exit:
  jmp _if18_exit
_if18_else_block:
_if21_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 2
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if21_else_block
_if21_block:
  mov b, datum
  mov d, b
  mov b, [datadr1]
  add d, b
  mov b, [d]
  mov [h], b
  mov b, datum
  mov d, b
  mov b, [datadr2]
  add d, b
  mov b, [d]
  mov [k], b
  mov b, datum
  mov d, b
  mov b, [datadr3]
  add d, b
  mov b, [d]
  mov [l], b
  jmp _if21_exit
_if21_else_block:
_if22_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 5
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if22_else_block
_if22_block:
  mov b, datum
  mov d, b
  mov b, [datadr3]
  add d, b
  mov b, [datadr2]
  push a
  mov a, b
  mov b, [datadr1]
  add a, b
  mov b, a
  pop a
  mov b, a
  mov [d], a
  jmp _if22_exit
_if22_else_block:
_if23_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 6
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if23_else_block
_if23_block:
  mov b, datum
  mov d, b
  mov b, [datadr3]
  add d, b
  mov b, datum
  mov d, b
  mov b, [datadr2]
  add d, b
  mov b, [d]
  mov b, a
  mov [d], a
  jmp _if23_exit
_if23_else_block:
_if24_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 8
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if24_else_block
_if24_block:
  mov b, datum
  mov d, b
  mov b, datum
  mov d, b
  add d, b
  mov b, [d]
  add d, b
  mov b, datum
  mov d, b
  mov b, [datadr2]
  add d, b
  mov b, [d]
  mov b, a
  mov [d], a
  jmp _if24_exit
_if24_else_block:
_if25_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 9
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if25_else_block
_if25_block:
  mov b, datum
  mov d, b
  mov b, [datadr3]
  add d, b
  mov b, datum
  mov d, b
  mov b, [datadr1]
  add d, b
  mov b, [d]
  push a
  mov a, b
  mov b, datum
  mov d, b
  mov b, [datadr2]
  add d, b
  mov b, [d]
  add a, b
  mov b, a
  pop a
  mov b, a
  mov [d], a
  jmp _if25_exit
_if25_else_block:
_if26_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if26_else_block
_if26_block:
  mov b, datum
  mov d, b
  mov b, [datadr3]
  add d, b
  mov b, datum
  mov d, b
  mov b, [datadr1]
  add d, b
  mov b, [d]
  push a
  mov a, b
  mov b, datum
  mov d, b
  mov b, [datadr2]
  add d, b
  mov b, [d]
  sub a, b
  mov b, a
  pop a
  mov b, a
  mov [d], a
  jmp _if26_exit
_if26_else_block:
_if27_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 11
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if27_else_block
_if27_block:
  mov b, datum
  mov d, b
  mov b, [datadr3]
  add d, b
  mov b, datum
  mov d, b
  mov b, [datadr1]
  add d, b
  mov b, [d]
  push a
  mov a, b
  mov b, datum
  mov d, b
  mov b, [datadr2]
  add d, b
  mov b, [d]
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 100
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov b, a
  mov [d], a
  jmp _if27_exit
_if27_else_block:
_if28_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if28_exit
_if28_block:
_if29_cond:
  mov b, datum
  mov d, b
  mov b, [datadr2]
  add d, b
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if29_else_block
_if29_block:
  mov b, datum
  mov d, b
  mov b, [datadr3]
  add d, b
  mov b, datum
  mov d, b
  mov b, [datadr1]
  add d, b
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  mul a, b
  pop a
  push a
  mov a, b
  mov b, datum
  mov d, b
  mov b, [datadr2]
  add d, b
  mov b, [d]
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov b, a
  mov [d], a
  jmp _if29_exit
_if29_else_block:
  mov b, datum
  mov d, b
  mov b, [datadr3]
  add d, b
  mov b, 0
  mov b, a
  mov [d], a
_if29_exit:
  jmp _if28_exit
_if28_exit:
_if27_exit:
_if26_exit:
_if25_exit:
_if24_exit:
_if23_exit:
_if22_exit:
_if21_exit:
_if18_exit:
_if17_exit:
_if30_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if30_exit
_if30_block:
_if31_cond:
  mov b, [pc]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000011
  mov b, a
  pop a
  cmp b, 0
  je _if31_else_block
_if31_block:
  mov b, [pc]
  inc b
  mov [pc], b
  jmp _if31_exit
_if31_else_block:
_if32_cond:
  mov b, [pc]
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
  je _if32_exit
_if32_block:
  jmp _while13_exit
  jmp _if32_exit
_if32_exit:
_if31_exit:
  jmp _if30_exit
_if30_exit:
  jmp _while13_cond
_while13_exit:
  jmp _while1_cond
_while1_exit:
; --- end text block

; --- begin data block
datum: .dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
instruction: .dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0
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
runlimit: .dw 0
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
