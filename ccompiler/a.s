; --- FILENAME: ivosol1a.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
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
  swp b
  push b
  call displaynumber
  add sp, 2
  call readint
  mov [cmdadr], b
_if3_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 30
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
  je _if3_else
_if3_true:
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
_if4_cond:
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
  je _if4_exit
_if4_true:
  jmp _while2_exit ; while break
  jmp _if4_exit
_if4_exit:
  jmp _if3_exit
_if3_else:
_if5_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 1111
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
  je _if5_else
_if5_true:
  call readint
  mov [i], b
  mov b, [instruction]
  push a
  mov d, b
  mov b, [i]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  swp b
  push b
  call displaynumber
  add sp, 2
  mov b, [instruction]
  push a
  mov d, b
  mov b, [i]
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
  mov b, [d]
  pop a
  swp b
  push b
  call displaynumber
  add sp, 2
  mov b, [instruction]
  push a
  mov d, b
  mov b, [i]
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
  mov b, [d]
  pop a
  swp b
  push b
  call displaynumber
  add sp, 2
  mov b, [instruction]
  push a
  mov d, b
  mov b, [i]
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
  mov b, [d]
  pop a
  swp b
  push b
  call displaynumber
  add sp, 2
  jmp _if5_exit
_if5_else:
_if6_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 2222
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
  je _if6_else
_if6_true:
  call readint
  mov [i], b
  mov b, [datum]
  push a
  mov d, b
  mov b, [i]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  swp b
  push b
  call displaynumber
  add sp, 2
  jmp _if6_exit
_if6_else:
_if7_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 4444
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
  je _if7_else
_if7_true:
  mov b, [datum]
  mov d, b
  call readint
  mov a, 2
  mul a, b
  add d, b
  push d
  call readint
  pop d
  mov a, b
  mov [d], a
  jmp _if7_exit
_if7_else:
_if8_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 5555
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
  je _if8_else
_if8_true:
_for9_init:
  mov b, 0
  mov [i], b
_for9_cond:
  mov b, [i]
  push a
  mov a, b
  mov b, 30
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
  je _for9_exit
_for9_block:
  mov b, [instruction]
  mov d, b
  mov b, [i]
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for9_update:
  mov b, [i]
  inc b
  mov [i], b
  jmp _for9_cond
_for9_exit:
  jmp _if8_exit
_if8_else:
_if10_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 6666
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
  je _if10_else
_if10_true:
_for11_init:
  mov b, [datadr1]
  mov [i], b
_for11_cond:
  mov b, [i]
  push a
  mov a, b
  mov b, 123
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
  je _for11_exit
_for11_block:
  mov b, [datum]
  mov d, b
  mov b, [i]
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for11_update:
  mov b, [i]
  inc b
  mov [i], b
  jmp _for11_cond
_for11_exit:
  jmp _if10_exit
_if10_else:
_if12_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 9999
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
  je _if12_else
_if12_true:
  call readint
  mov [runlimit], b
  jmp _if12_exit
_if12_else:
_if13_cond:
  mov b, [cmdadr]
  push a
  mov a, b
  mov b, 8888
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
  je _if13_exit
_if13_true:
  mov b, 1
  mov [exitflag], b
  jmp _if13_exit
_if13_exit:
_if12_exit:
_if10_exit:
_if8_exit:
_if7_exit:
_if6_exit:
_if5_exit:
_if3_exit:
  jmp _while2_cond
_while2_exit:
_if14_cond:
  mov b, [exitflag]
  push a
  mov a, b
  mov b, 1
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
  je _if14_exit
_if14_true:
  jmp _while1_exit ; while break
  jmp _if14_exit
_if14_exit:
_while15_cond:
  mov b, [pc]
  push a
  mov a, b
  mov b, 30
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
  je _while15_exit
_while15_block:
_if16_cond:
  mov b, [runlimit]
  push a
  mov a, b
  mov b, 1
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
  je _if16_else
_if16_true:
  jmp _while15_exit ; while break
  jmp _if16_exit
_if16_else:
_if17_cond:
  mov b, [runlimit]
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, %00000000
  lodflgs
  and al, %00000001 ; >
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if17_exit
_if17_true:
  mov b, [runlimit]
  dec b
  mov [runlimit], b
  jmp _if17_exit
_if17_exit:
_if16_exit:
  mov b, [datum]
  mov d, b
  mov b, 0
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
  mov b, [instruction]
  push a
  mov d, b
  mov b, [pc]
  push a
  mov a, b
  mov b, 4
  mul a, b
  pop a
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  mov [opr], b
  mov b, [instruction]
  push a
  mov d, b
  mov b, [pc]
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
  mov b, [d]
  pop a
  mov [datadr1], b
  mov b, [instruction]
  push a
  mov d, b
  mov b, [pc]
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
  mov b, [d]
  pop a
  mov [datadr2], b
  mov b, [instruction]
  push a
  mov d, b
  mov b, [pc]
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
  mov b, [d]
  pop a
  mov [datadr3], b
_if18_cond:
  mov b, [h]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, %00000000
  lodflgs
  and al, %00000001 ; >
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  mov a, b
  mov b, [k]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, %00000000
  lodflgs
  and al, %00000001 ; >
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  or a, b
  mov b, a
  mov a, b
  mov b, [l]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, %00000000
  lodflgs
  and al, %00000001 ; >
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  or a, b
  mov b, a
  pop a
  cmp b, 0
  je _if18_exit
_if18_true:
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
  jmp _if18_exit
_if18_exit:
  mov b, [pc]
  push a
  mov a, b
  mov b, 100
  mul a, b
  mov a, b
  mov b, [opr]
  add a, b
  mov b, a
  pop a
  swp b
  push b
  call displaynumber
  add sp, 2
_if19_cond:
  mov b, [opr]
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
  je _if19_else
_if19_true:
  jmp _if19_exit
_if19_else:
_if20_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 1
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
  je _if20_else
_if20_true:
  mov b, 0
  mov [k], b
_if21_cond:
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 6
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, %00000000
  lodflgs
  and al, %00000001 ; >
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if21_exit
_if21_true:
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
  jmp _if21_exit
_if21_exit:
_if22_cond:
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr1]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
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
  mov a, b
  cmp a, 0
  lodflgs
  not al
  and al, %00000001 ; transform logical AND condition result into a single bit
  mov b, [datadr3]
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
  cmp b, 0
  lodflgs
  not al
  and al, %00000001 ; transform logical AND condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  and a, b
  mov b, a
  mov a, b
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr1]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  mov a, b
  mov b, 37767
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, %00000000
  lodflgs
  and al, %00000001 ; >
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  mov a, b
  cmp a, 0
  lodflgs
  not al
  and al, %00000001 ; transform logical AND condition result into a single bit
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 2
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  cmp b, 0
  lodflgs
  not al
  and al, %00000001 ; transform logical AND condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  and a, b
  mov b, a
  pop a
  or a, b
  mov b, a
  mov a, b
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr1]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  mov a, b
  mov b, 32767
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000010 ; >=
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  mov a, b
  cmp a, 0
  lodflgs
  not al
  and al, %00000001 ; transform logical AND condition result into a single bit
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 4
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  cmp b, 0
  lodflgs
  not al
  and al, %00000001 ; transform logical AND condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  and a, b
  mov b, a
  pop a
  or a, b
  mov b, a
  mov a, b
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr1]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, %00000000
  lodflgs
  and al, %00000001 ; >
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  mov a, b
  cmp a, 0
  lodflgs
  not al
  and al, %00000001 ; transform logical AND condition result into a single bit
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  cmp b, 0
  lodflgs
  not al
  and al, %00000001 ; transform logical AND condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  and a, b
  mov b, a
  pop a
  or a, b
  mov b, a
  mov a, b
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr1]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000010 ; >=
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  mov a, b
  cmp a, 0
  lodflgs
  not al
  and al, %00000001 ; transform logical AND condition result into a single bit
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 3
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  cmp b, 0
  lodflgs
  not al
  and al, %00000001 ; transform logical AND condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  and a, b
  mov b, a
  pop a
  or a, b
  mov b, a
  mov a, b
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr1]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
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
  mov a, b
  cmp a, 0
  lodflgs
  not al
  and al, %00000001 ; transform logical AND condition result into a single bit
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 5
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  cmp b, 0
  lodflgs
  not al
  and al, %00000001 ; transform logical AND condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  and a, b
  mov b, a
  pop a
  or a, b
  mov b, a
  mov a, b
  mov b, [datadr3]
  push a
  mov a, b
  mov b, 6
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
  or a, b
  mov b, a
  pop a
  cmp b, 0
  je _if22_else
_if22_true:
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
  jmp _if22_exit
_if22_else:
  mov b, [pc]
  inc b
  mov [pc], b
_if22_exit:
  jmp _if20_exit
_if20_else:
_if23_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 2
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
  je _if23_else
_if23_true:
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr1]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  mov [h], b
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr2]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  mov [k], b
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr3]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  mov [l], b
  jmp _if23_exit
_if23_else:
_if24_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 5
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
  je _if24_else
_if24_true:
  mov b, [datum]
  mov d, b
  mov b, [datadr3]
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [datadr2]
  push a
  mov a, b
  mov b, [datadr1]
  add a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
  jmp _if24_exit
_if24_else:
_if25_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 6
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
  je _if25_else
_if25_true:
  mov b, [datum]
  mov d, b
  mov b, [datadr3]
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr2]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
  jmp _if25_exit
_if25_else:
_if26_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 8
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
  je _if26_else
_if26_true:
  mov b, [datum]
  mov d, b
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr3]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr2]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
  jmp _if26_exit
_if26_else:
_if27_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 9
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
  je _if27_else
_if27_true:
  mov b, [datum]
  mov d, b
  mov b, [datadr3]
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr1]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  mov a, b
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr2]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
  jmp _if27_exit
_if27_else:
_if28_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 10
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
  je _if28_else
_if28_true:
  mov b, [datum]
  mov d, b
  mov b, [datadr3]
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr1]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  mov a, b
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr2]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
  jmp _if28_exit
_if28_else:
_if29_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 11
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
  je _if29_else
_if29_true:
  mov b, [datum]
  mov d, b
  mov b, [datadr3]
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr1]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  mov a, b
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr2]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  mul a, b
  mov a, b
  mov b, 100
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  pop d
  mov a, b
  mov [d], a
  jmp _if29_exit
_if29_else:
_if30_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 12
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
  je _if30_exit
_if30_true:
_if31_cond:
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr2]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
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
  je _if31_else
_if31_true:
  mov b, [datum]
  mov d, b
  mov b, [datadr3]
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr1]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  mov a, b
  mov b, 100
  mul a, b
  mov a, b
  mov b, [datum]
  push a
  mov d, b
  mov b, [datadr2]
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  pop d
  mov a, b
  mov [d], a
  jmp _if31_exit
_if31_else:
  mov b, [datum]
  mov d, b
  mov b, [datadr3]
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_if31_exit:
  jmp _if30_exit
_if30_exit:
_if29_exit:
_if28_exit:
_if27_exit:
_if26_exit:
_if25_exit:
_if24_exit:
_if23_exit:
_if20_exit:
_if19_exit:
_if32_cond:
  mov b, [opr]
  push a
  mov a, b
  mov b, 1
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
  je _if32_exit
_if32_true:
_if33_cond:
  mov b, [pc]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, %00000000
  lodflgs
  and al, %00000001 ; >
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if33_else
_if33_true:
  mov b, [pc]
  inc b
  mov [pc], b
  jmp _if33_exit
_if33_else:
_if34_cond:
  mov b, [pc]
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
  je _if34_exit
_if34_true:
  jmp _while15_exit ; while break
  jmp _if34_exit
_if34_exit:
_if33_exit:
  jmp _if32_exit
_if32_exit:
  jmp _while15_cond
_while15_exit:
  jmp _while1_cond
_while1_exit:
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
runlimit: .dw 0
exitflag: .dw 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
