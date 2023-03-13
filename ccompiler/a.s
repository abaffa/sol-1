; --- FILENAME: largenumtSol1a.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
_for1_init:
  mov b, 0
  mov [__pos], b
_for1_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 60
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for1_exit
_for1_block:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
_for1_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for1_cond
_for1_exit:
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for2_init:
  mov b, 6
  mov [__pos], b
_for2_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for2_exit
_for2_block:
  call readint
  mov [__ionr], b
  mov b, [__ionr] ; ionr
  push a
  mov a, b
  mov b, 10000
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__ioshift], b
  mov b, [__ioshift] ; ioshift
  push a
  mov a, b
  mov b, 10000
  mul a, b
  pop a
  mov [__ioshift], b
  mov b, [__ionr] ; ionr
  push a
  mov a, b
  mov b, [__ioshift] ; ioshift
  sub a, b
  mov b, a
  pop a
  mov [__ionr], b
  mov b, [__ionum] ; ionum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__ionr] ; ionr
  pop d
  mov [d], b
_for3_init:
  mov b, 6
  mov [__datumpos], b
_for3_cond:
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, [__pos] ; pos
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000010 ; >=
  cmp al, 0
  lodflgs
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for3_exit
_for3_block:
_if4_cond:
  mov b, [__ionum] ; ionum
  push a
  mov d, b
  push d
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 1000
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if4_exit
_if4_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if4_exit
_if4_exit:
_if5_cond:
  mov b, [__ionum] ; ionum
  push a
  mov d, b
  push d
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if5_exit
_if5_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if5_exit
_if5_exit:
_if6_cond:
  mov b, [__ionum] ; ionum
  push a
  mov d, b
  push d
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if6_exit
_if6_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if6_exit
_if6_exit:
  mov b, [__ionum] ; ionum
  push a
  mov d, b
  push d
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  swp b
  push b
  call prnnum
  add sp, 2
_for3_update:
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  dec b
  mov [__datumpos], b
  mov b, a
  pop a
  jmp _for3_cond
_for3_exit:
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for2_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  dec b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for2_cond
_for2_exit:
  mov b, 0
  mov [__datumpos], b
_for7_init:
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [__pos], b
_for7_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 6
  add a, b
  mov b, a
  pop a
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for7_exit
_for7_block:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__ionum] ; ionum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for7_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for7_cond
_for7_exit:
_for8_init:
  mov b, 0
  mov [__pos], b
_for8_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 60
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for8_exit
_for8_block:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
_for8_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for8_cond
_for8_exit:
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for9_init:
  mov b, 6
  mov [__pos], b
_for9_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for9_exit
_for9_block:
  call readint
  mov [__ionr], b
  mov b, [__ionr] ; ionr
  push a
  mov a, b
  mov b, 10000
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__ioshift], b
  mov b, [__ioshift] ; ioshift
  push a
  mov a, b
  mov b, 10000
  mul a, b
  pop a
  mov [__ioshift], b
  mov b, [__ionr] ; ionr
  push a
  mov a, b
  mov b, [__ioshift] ; ioshift
  sub a, b
  mov b, a
  pop a
  mov [__ionr], b
  mov b, [__ionum] ; ionum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__ionr] ; ionr
  pop d
  mov [d], b
_for10_init:
  mov b, 6
  mov [__datumpos], b
_for10_cond:
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, [__pos] ; pos
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000010 ; >=
  cmp al, 0
  lodflgs
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for10_exit
_for10_block:
_if11_cond:
  mov b, [__ionum] ; ionum
  push a
  mov d, b
  push d
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 1000
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if11_exit
_if11_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if11_exit
_if11_exit:
_if12_cond:
  mov b, [__ionum] ; ionum
  push a
  mov d, b
  push d
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if12_exit
_if12_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if12_exit
_if12_exit:
_if13_cond:
  mov b, [__ionum] ; ionum
  push a
  mov d, b
  push d
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if13_exit
_if13_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if13_exit
_if13_exit:
  mov b, [__ionum] ; ionum
  push a
  mov d, b
  push d
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  swp b
  push b
  call prnnum
  add sp, 2
_for10_update:
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  dec b
  mov [__datumpos], b
  mov b, a
  pop a
  jmp _for10_cond
_for10_exit:
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for9_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  dec b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for9_cond
_for9_exit:
  mov b, 1
  mov [__datumpos], b
_for14_init:
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [__pos], b
_for14_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 6
  add a, b
  mov b, a
  pop a
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for14_exit
_for14_block:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__ionum] ; ionum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for14_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for14_cond
_for14_exit:
  mov b, 0
  mov [__datumpos], b
_for15_init:
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [__pos], b
_for15_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 6
  add a, b
  mov b, a
  pop a
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for15_exit
_for15_block:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__ioshift], b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__ioshift] ; ioshift
  pop d
  mov [d], b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  mul a, b
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__ioshift] ; ioshift
  push a
  mov a, b
  mov b, 100
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for15_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for15_cond
_for15_exit:
  mov b, 1
  mov [__datumpos], b
_for16_init:
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [__pos], b
_for16_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 6
  add a, b
  mov b, a
  pop a
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for16_exit
_for16_block:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__ioshift], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__ioshift] ; ioshift
  pop d
  mov [d], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  mul a, b
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__ioshift] ; ioshift
  push a
  mov a, b
  mov b, 100
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for16_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for16_cond
_for16_exit:
_for17_init:
  mov b, 0
  mov [__pos], b
_for17_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for17_exit
_for17_block:
  mov b, [__anarrbkp] ; anarrbkp
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
  mov b, [__bnarrbkp] ; bnarrbkp
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for17_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for17_cond
_for17_exit:
_for18_init:
  mov b, 0
  mov [__pos], b
_for18_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 60
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for18_exit
_for18_block:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
_for18_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for18_cond
_for18_exit:
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  call plus
  mov b, 2
  mov [__datumpos], b
_for19_init:
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [__pos], b
_for19_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 6
  add a, b
  mov b, a
  pop a
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for19_exit
_for19_block:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  mul a, b
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for19_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for19_cond
_for19_exit:
_for20_init:
  mov b, 18
  mov [__pos], b
_for20_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for20_exit
_for20_block:
_if21_cond:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 1000
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if21_exit
_if21_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if21_exit
_if21_exit:
_if22_cond:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if22_exit
_if22_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if22_exit
_if22_exit:
_if23_cond:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if23_exit
_if23_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if23_exit
_if23_exit:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  swp b
  push b
  call prnnumspace
  add sp, 2
_for20_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  dec b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for20_cond
_for20_exit:
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for24_init:
  mov b, 0
  mov [__pos], b
_for24_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for24_exit
_for24_block:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarrbkp] ; anarrbkp
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__bnarrbkp] ; bnarrbkp
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for24_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for24_cond
_for24_exit:
  call minus
  mov b, 2
  mov [__datumpos], b
_for25_init:
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [__pos], b
_for25_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 6
  add a, b
  mov b, a
  pop a
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for25_exit
_for25_block:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  mul a, b
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for25_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for25_cond
_for25_exit:
_for26_init:
  mov b, 18
  mov [__pos], b
_for26_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for26_exit
_for26_block:
_if27_cond:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 1000
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if27_exit
_if27_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if27_exit
_if27_exit:
_if28_cond:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if28_exit
_if28_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if28_exit
_if28_exit:
_if29_cond:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if29_exit
_if29_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if29_exit
_if29_exit:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  swp b
  push b
  call prnnumspace
  add sp, 2
_for26_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  dec b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for26_cond
_for26_exit:
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for30_init:
  mov b, 0
  mov [__pos], b
_for30_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for30_exit
_for30_block:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarrbkp] ; anarrbkp
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__bnarrbkp] ; bnarrbkp
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for30_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for30_cond
_for30_exit:
  call times
  mov b, 2
  mov [__datumpos], b
_for31_init:
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [__pos], b
_for31_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 6
  add a, b
  mov b, a
  pop a
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for31_exit
_for31_block:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  mul a, b
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for31_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for31_cond
_for31_exit:
_for32_init:
  mov b, 18
  mov [__pos], b
_for32_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for32_exit
_for32_block:
_if33_cond:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 1000
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if33_exit
_if33_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if33_exit
_if33_exit:
_if34_cond:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if34_exit
_if34_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if34_exit
_if34_exit:
_if35_cond:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if35_exit
_if35_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if35_exit
_if35_exit:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  swp b
  push b
  call prnnumspace
  add sp, 2
_for32_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  dec b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for32_cond
_for32_exit:
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
_for36_init:
  mov b, 0
  mov [__pos], b
_for36_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for36_exit
_for36_block:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarrbkp] ; anarrbkp
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__bnarrbkp] ; bnarrbkp
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for36_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for36_cond
_for36_exit:
  call dividedby
  mov b, 2
  mov [__datumpos], b
_for37_init:
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [__pos], b
_for37_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 6
  add a, b
  mov b, a
  pop a
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for37_exit
_for37_block:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  mul a, b
  pop a
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 2
  mul a, b
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for37_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for37_cond
_for37_exit:
_for38_init:
  mov b, 18
  mov [__pos], b
_for38_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for38_exit
_for38_block:
_if39_cond:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 1000
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if39_exit
_if39_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if39_exit
_if39_exit:
_if40_cond:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if40_exit
_if40_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if40_exit
_if40_exit:
_if41_cond:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if41_exit
_if41_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if41_exit
_if41_exit:
  mov b, [__datum] ; datum
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  swp b
  push b
  call prnnumspace
  add sp, 2
_for38_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  dec b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for38_cond
_for38_exit:
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  leave
  syscall sys_terminate_proc

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

prnnumspace:
  push bp
  mov bp, sp
  mov b, [bp + 5] ; n
  swp b
  push b
  call prnnum
  add sp, 2
  mov b, __string_1 ; " "
  swp b
  push b
  call print
  add sp, 2
  leave
  ret

prnnum:
  push bp
  mov bp, sp
  sub sp, 5 ; digits
  sub sp, 2 ; i
  mov b, 0
  push a
  mov a, b
  mov [bp + -6], a ; i
  pop a
_if42_cond:
  mov b, [bp + 5] ; num
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if42_exit
_if42_true:
  mov b, '0'
  push bl
  call _putchar
  add sp, 1
  leave
  ret
  jmp _if42_exit
_if42_exit:
_while43_cond:
  mov b, [bp + 5] ; num
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while43_exit
_while43_block:
  lea d, [bp + -4] ; digits beginning on the stack
  mov b, d
  push a
  mov d, b
  push d
  mov b, [bp + -6] ; i
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  push d
  mov b, '0'
  push a
  mov a, b
  mov b, [bp + 5] ; num
  push a
  mov a, b
  mov b, 10
  div a, b
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], bl
  mov b, [bp + 5] ; num
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  push a
  mov a, b
  mov [bp + 5], a ; num
  pop a
  mov b, [bp + -6] ; i
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -6], a ; i
  pop a
  mov b, a
  pop a
  jmp _while43_cond
_while43_exit:
_while44_cond:
  mov b, [bp + -6] ; i
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while44_exit
_while44_block:
  mov b, [bp + -6] ; i
  push a
  mov a, b
  dec b
  push a
  mov a, b
  mov [bp + -6], a ; i
  pop a
  mov b, a
  pop a
  lea d, [bp + -4] ; digits beginning on the stack
  mov b, d
  push a
  mov d, b
  push d
  mov b, [bp + -6] ; i
  pop d
  mov a, 1
  mul a, b
  add d, b
  pop a
  mov bl, [d]
  mov bh, 0
  push bl
  call _putchar
  add sp, 1
  jmp _while44_cond
_while44_exit:
  leave
  ret

_putchar:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov al, [bp + 5]
  mov ah, al
  call putchar
; --- END INLINE ASM BLOCK

  leave
  ret

fixsignin:
  push bp
  mov bp, sp
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, 0
  mov [__csign], b
_if45_cond:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 9
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if45_exit
_if45_true:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__pos], b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, 1
  mov [__asign], b
  jmp _if45_exit
_if45_exit:
_if46_cond:
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 9
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if46_exit
_if46_true:
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__pos], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, 1
  mov [__bsign], b
  jmp _if46_exit
_if46_exit:
  leave
  ret

fixsignout:
  push bp
  mov bp, sp
_if47_cond:
  mov b, [__csign] ; csign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if47_exit
_if47_true:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, 0
  mov [__csign], b
  jmp _if47_exit
_if47_exit:
  leave
  ret

fixcsizezero:
  push bp
  mov bp, sp
  mov b, 1
  mov [__allzeroes], b
_for48_init:
  mov b, 1
  mov [__pos], b
_for48_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for48_exit
_for48_block:
_if49_cond:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if49_exit
_if49_true:
  mov b, 0
  mov [__allzeroes], b
  jmp _for48_exit ; for break
  jmp _if49_exit
_if49_exit:
_for48_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for48_cond
_for48_exit:
_if50_cond:
  mov b, [__allzeroes] ; allzeroes
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if50_exit
_if50_true:
  mov b, 0
  mov [__csign], b
  jmp _if50_exit
_if50_exit:
_if51_cond:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 9
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if51_exit
_if51_true:
  mov b, 0
  mov [__csign], b
_for52_init:
  mov b, 1
  mov [__pos], b
_for52_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for52_exit
_for52_block:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
_for52_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for52_cond
_for52_exit:
  jmp _if51_exit
_if51_exit:
  leave
  ret

swapab:
  push bp
  mov bp, sp
_for53_init:
  mov b, 0
  mov [__swappos], b
_for53_cond:
  mov b, [__swappos] ; swappos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for53_exit
_for53_block:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for53_update:
  mov b, [__swappos] ; swappos
  push a
  mov a, b
  inc b
  mov [__swappos], b
  mov b, a
  pop a
  jmp _for53_cond
_for53_exit:
  leave
  ret

checkabsabsize:
  push bp
  mov bp, sp
  mov b, 0
  mov [__agtb], b
  mov b, 0
  mov [__bgta], b
  mov b, 0
  mov [__ageb], b
  mov b, 0
  mov [__bgea], b
  mov b, 0
  mov [__aeqb], b
  mov b, 0
  mov [__aneqb], b
_for54_init:
  mov b, 12
  mov [__psizepos], b
_for54_cond:
  mov b, [__psizepos] ; psizepos
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for54_exit
_for54_block:
  mov b, [__psizepos] ; psizepos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  mov [__sizepos], b
_if55_cond:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__sizepos] ; sizepos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__sizepos] ; sizepos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if55_exit
_if55_true:
  mov b, 1
  mov [__aneqb], b
  mov b, 1
  mov [__agtb], b
  mov b, 1
  mov [__ageb], b
  jmp _if55_exit
_if55_exit:
_if56_cond:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__sizepos] ; sizepos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__sizepos] ; sizepos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if56_exit
_if56_true:
  mov b, 1
  mov [__aneqb], b
  mov b, 1
  mov [__bgta], b
  mov b, 1
  mov [__bgea], b
  jmp _if56_exit
_if56_exit:
_if57_cond:
  mov b, [__aneqb] ; aneqb
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if57_exit
_if57_true:
  jmp _for54_exit ; for break
  jmp _if57_exit
_if57_exit:
_for54_update:
  mov b, [__psizepos] ; psizepos
  push a
  mov a, b
  dec b
  mov [__psizepos], b
  mov b, a
  pop a
  jmp _for54_cond
_for54_exit:
_if58_cond:
  mov b, [__aneqb] ; aneqb
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if58_exit
_if58_true:
  mov b, 1
  mov [__aeqb], b
  mov b, 1
  mov [__ageb], b
  mov b, 1
  mov [__bgea], b
  jmp _if58_exit
_if58_exit:
  leave
  ret

protoplus:
  push bp
  mov bp, sp
  mov b, 0
  mov [__carry], b
_for59_init:
  mov b, 0
  mov [__pos], b
_for59_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for59_exit
_for59_block:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [__carry] ; carry
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, 0
  mov [__carry], b
_if60_cond:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 99
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if60_exit
_if60_true:
  mov b, 1
  mov [__carry], b
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  jmp _if60_exit
_if60_exit:
_for59_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for59_cond
_for59_exit:
  leave
  ret

protominus:
  push bp
  mov bp, sp
  mov b, 0
  mov [__carry], b
_for61_init:
  mov b, 0
  mov [__pos], b
_for61_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for61_exit
_for61_block:
  mov b, 0
  mov [__nextcarry], b
_if62_cond:
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__carry] ; carry
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if62_exit
_if62_true:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, 1
  mov [__nextcarry], b
  jmp _if62_exit
_if62_exit:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [__carry] ; carry
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, [__nextcarry] ; nextcarry
  mov [__carry], b
_for61_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for61_cond
_for61_exit:
_if63_cond:
  mov b, [__carry] ; carry
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if63_exit
_if63_true:
  mov b, 1
  mov [__csign], b
  mov b, 0
  mov [__carry], b
  jmp _if63_exit
_if63_exit:
  leave
  ret

pminus:
  push bp
  mov bp, sp
_for64_init:
  mov b, 0
  mov [__divi], b
_for64_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for64_exit
_for64_block:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
_for64_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for64_cond
_for64_exit:
  call checkabsabsize
_if65_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, [__bsign] ; bsign
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__aeqb] ; aeqb
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if65_exit
_if65_true:
  mov b, 0
  mov [__csign], b
_for66_init:
  mov b, 1
  mov [__pos], b
_for66_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for66_exit
_for66_block:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
_for66_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for66_cond
_for66_exit:
  jmp _if65_exit
_if65_exit:
_if67_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bsign] ; bsign
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__ageb] ; ageb
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if67_exit
_if67_true:
  mov b, 0
  mov [__csign], b
  call protominus
  jmp _if67_exit
_if67_exit:
_if68_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bsign] ; bsign
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bgta] ; bgta
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if68_exit
_if68_true:
  mov b, 1
  mov [__csign], b
  call swapab
  call protominus
  jmp _if68_exit
_if68_exit:
_if69_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bsign] ; bsign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__ageb] ; ageb
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if69_exit
_if69_true:
  mov b, 1
  mov [__csign], b
  call protominus
  jmp _if69_exit
_if69_exit:
_if70_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bsign] ; bsign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bgta] ; bgta
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if70_exit
_if70_true:
  mov b, 0
  mov [__csign], b
  call swapab
  call protominus
  jmp _if70_exit
_if70_exit:
_if71_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bsign] ; bsign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if71_exit
_if71_true:
  mov b, 0
  mov [__csign], b
  call protoplus
  jmp _if71_exit
_if71_exit:
_if72_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bsign] ; bsign
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if72_exit
_if72_true:
  mov b, 1
  mov [__csign], b
  call protoplus
  jmp _if72_exit
_if72_exit:
  leave
  ret

minus:
  push bp
  mov bp, sp
  call fixsignin
  call pminus
  call fixcsizezero
  call fixsignout
  leave
  ret

pplus:
  push bp
  mov bp, sp
_for73_init:
  mov b, 0
  mov [__divi], b
_for73_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for73_exit
_for73_block:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
_for73_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for73_cond
_for73_exit:
  call checkabsabsize
_if74_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bsign] ; bsign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__aeqb] ; aeqb
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if74_exit
_if74_true:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, 0
  mov [__csign], b
_for75_init:
  mov b, 1
  mov [__pos], b
_for75_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for75_exit
_for75_block:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
_for75_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for75_cond
_for75_exit:
  leave
  ret
  jmp _if74_exit
_if74_exit:
_if76_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bsign] ; bsign
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__aeqb] ; aeqb
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if76_exit
_if76_true:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, 0
  mov [__csign], b
_for77_init:
  mov b, 1
  mov [__pos], b
_for77_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for77_exit
_for77_block:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
_for77_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for77_cond
_for77_exit:
  leave
  ret
  jmp _if76_exit
_if76_exit:
_if78_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bsign] ; bsign
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if78_exit
_if78_true:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, 0
  mov [__csign], b
  call protoplus
  leave
  ret
  jmp _if78_exit
_if78_exit:
_if79_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bsign] ; bsign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if79_exit
_if79_true:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, 1
  mov [__csign], b
  call protoplus
  leave
  ret
  jmp _if79_exit
_if79_exit:
_if80_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bsign] ; bsign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__agtb] ; agtb
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if80_exit
_if80_true:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, 0
  mov [__csign], b
  call protominus
  leave
  ret
  jmp _if80_exit
_if80_exit:
_if81_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bsign] ; bsign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bgta] ; bgta
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if81_exit
_if81_true:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, 1
  mov [__csign], b
  call swapab
  call protominus
  leave
  ret
  jmp _if81_exit
_if81_exit:
_if82_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bsign] ; bsign
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__agtb] ; agtb
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if82_exit
_if82_true:
  mov b, 1
  mov [__csign], b
  call swapab
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  call pminus
  leave
  ret
  jmp _if82_exit
_if82_exit:
_if83_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bsign] ; bsign
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  push al
  cmp b, 0
  lodflgs ; transform condition into a single bit
  mov b, [__bgta] ; bgta
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  push al
  cmp b, 0
  lodflgs
  pop bl ; matches previous 'push al'
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if83_exit
_if83_true:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, 0
  mov [__csign], b
  call swapab
  call protominus
  leave
  ret
  jmp _if83_exit
_if83_exit:
  leave
  ret

plus:
  push bp
  mov bp, sp
  call fixsignin
  call pplus
  call fixcsizezero
  call fixsignout
  leave
  ret

normmulres:
  push bp
  mov bp, sp
_if84_cond:
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 99
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if84_exit
_if84_true:
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__toolarge], b
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__toolarge] ; toolarge
  push a
  mov a, b
  mov b, 100
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  jmp _if84_exit
_if84_exit:
  mov b, 0
  mov [__normal], b
_while85_cond:
  mov b, [__normal] ; normal
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while85_exit
_while85_block:
  mov b, 1
  mov [__normal], b
_for86_init:
  mov b, 0
  mov [__protopos], b
_for86_cond:
  mov b, [__protopos] ; protopos
  push a
  mov a, b
  mov b, 23
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for86_exit
_for86_block:
  mov b, 22
  push a
  mov a, b
  mov b, [__protopos] ; protopos
  sub a, b
  mov b, a
  pop a
  mov [__pos], b
_if87_cond:
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 99
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if87_exit
_if87_true:
  mov b, 0
  mov [__normal], b
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__toolarge], b
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__toolarge] ; toolarge
  push a
  mov a, b
  mov b, 100
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__toolarge] ; toolarge
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  jmp _if87_exit
_if87_exit:
_for86_update:
  mov b, [__protopos] ; protopos
  push a
  mov a, b
  inc b
  mov [__protopos], b
  mov b, a
  pop a
  jmp _for86_cond
_for86_exit:
  jmp _while85_cond
_while85_exit:
_if88_cond:
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 99
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if88_exit
_if88_true:
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 100
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__toolarge], b
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__toolarge] ; toolarge
  push a
  mov a, b
  mov b, 100
  mul a, b
  pop a
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  jmp _if88_exit
_if88_exit:
  leave
  ret

prototimes:
  push bp
  mov bp, sp
_for89_init:
  mov b, 0
  mov [__divi], b
_for89_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for89_exit
_for89_block:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
_for89_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for89_cond
_for89_exit:
_for90_init:
  mov b, 0
  mov [__divi], b
_for90_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 24
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for90_exit
_for90_block:
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
_for90_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for90_cond
_for90_exit:
_for91_init:
  mov b, 0
  mov [__mulpos1], b
_for91_cond:
  mov b, [__mulpos1] ; mulpos1
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for91_exit
_for91_block:
_for92_init:
  mov b, 0
  mov [__mulpos2], b
_for92_cond:
  mov b, [__mulpos2] ; mulpos2
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for92_exit
_for92_block:
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, [__mulpos1] ; mulpos1
  push a
  mov a, b
  mov b, [__mulpos2] ; mulpos2
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, [__mulpos1] ; mulpos1
  push a
  mov a, b
  mov b, [__mulpos2] ; mulpos2
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__mulpos2] ; mulpos2
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__mulpos1] ; mulpos1
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  mul a, b
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for92_update:
  mov b, [__mulpos2] ; mulpos2
  push a
  mov a, b
  inc b
  mov [__mulpos2], b
  mov b, a
  pop a
  jmp _for92_cond
_for92_exit:
  call normmulres
_for91_update:
  mov b, [__mulpos1] ; mulpos1
  push a
  mov a, b
  inc b
  mov [__mulpos1], b
  mov b, a
  pop a
  jmp _for91_cond
_for91_exit:
  leave
  ret

aincrease:
  push bp
  mov bp, sp
_for93_init:
  mov b, 12
  mov [__divi], b
_for93_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for93_exit
_for93_block:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__subi], b
  mov b, [__subi] ; subi
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  mov [__subi], b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__subi] ; subi
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  pop d
  mov [d], b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 2
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__subi], b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__subi] ; subi
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for93_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  dec b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for93_cond
_for93_exit:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  mov [__subi], b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  pop d
  mov [d], b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  pop d
  mov [d], b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__subi] ; subi
  push a
  mov a, b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  pop d
  mov [d], b
  leave
  ret

bincrease:
  push bp
  mov bp, sp
_for94_init:
  mov b, 12
  mov [__divi], b
_for94_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for94_exit
_for94_block:
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__subi], b
  mov b, [__subi] ; subi
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  mov [__subi], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__subi] ; subi
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  pop d
  mov [d], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 2
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__subi], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__subi] ; subi
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for94_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  dec b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for94_cond
_for94_exit:
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  mov [__subi], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  pop d
  mov [d], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  pop d
  mov [d], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__subi] ; subi
  push a
  mov a, b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  sub a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  pop d
  mov [d], b
  leave
  ret

adecrease:
  push bp
  mov bp, sp
_for95_init:
  mov b, 0
  mov [__divi], b
_for95_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 11
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for95_exit
_for95_block:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__subi], b
  mov b, [__subi] ; subi
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  mov [__subi], b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__subi] ; subi
  sub a, b
  mov b, a
  pop a
  mov [__subi], b
  mov b, [__subi] ; subi
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  mov [__subi], b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__subi] ; subi
  push a
  mov a, b
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for95_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for95_cond
_for95_exit:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  pop d
  mov [d], b
  leave
  ret

bdecrease:
  push bp
  mov bp, sp
_for96_init:
  mov b, 0
  mov [__divi], b
_for96_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 11
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for96_exit
_for96_block:
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__subi], b
  mov b, [__subi] ; subi
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  mov [__subi], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__subi] ; subi
  sub a, b
  mov b, a
  pop a
  mov [__subi], b
  mov b, [__subi] ; subi
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  mov [__subi], b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__subi] ; subi
  push a
  mov a, b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for96_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for96_cond
_for96_exit:
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  pop d
  mov [d], b
  leave
  ret

protodividedby:
  push bp
  mov bp, sp
  mov b, 0
  mov [__posflag], b
  mov b, 0
  mov [__brshift], b
  mov b, 0
  mov [__blshift], b
  mov b, 0
  mov [__alshift], b
  mov b, 0
  mov [__divcounter1], b
  mov b, 0
  mov [__divcounter2], b
  mov b, 0
  mov [__segmentcounter], b
  mov b, 1
  mov [__allzeroes], b
_for97_init:
  mov b, 0
  mov [__divi], b
_for97_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for97_exit
_for97_block:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
  mov b, [__divres] ; divres
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
_if98_cond:
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if98_exit
_if98_true:
  mov b, 0
  mov [__allzeroes], b
  jmp _if98_exit
_if98_exit:
_for97_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for97_cond
_for97_exit:
_if99_cond:
  mov b, [__allzeroes] ; allzeroes
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if99_exit
_if99_true:
  leave
  ret
  jmp _if99_exit
_if99_exit:
_while100_cond:
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while100_exit
_while100_block:
_for101_init:
  mov b, 11
  mov [__divi], b
_for101_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for101_exit
_for101_block:
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for101_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  dec b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for101_cond
_for101_exit:
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
  mov b, [__blshift] ; blshift
  push a
  mov a, b
  mov b, 2
  add a, b
  mov b, a
  pop a
  mov [__blshift], b
  jmp _while100_cond
_while100_exit:
  mov b, 1
  mov [__allzeroes], b
_for102_init:
  mov b, 0
  mov [__divi], b
_for102_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for102_exit
_for102_block:
_if103_cond:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if103_exit
_if103_true:
  mov b, 0
  mov [__allzeroes], b
  jmp _if103_exit
_if103_exit:
_for102_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for102_cond
_for102_exit:
_if104_cond:
  mov b, [__allzeroes] ; allzeroes
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if104_exit
_if104_true:
  leave
  ret
  jmp _if104_exit
_if104_exit:
_while105_cond:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while105_exit
_while105_block:
_for106_init:
  mov b, 0
  mov [__divi], b
_for106_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 11
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for106_exit
_for106_block:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 11
  push a
  mov a, b
  mov b, [__divi] ; divi
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 11
  push a
  mov a, b
  mov b, [__divi] ; divi
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for106_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for106_cond
_for106_exit:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
  mov b, [__alshift] ; alshift
  push a
  mov a, b
  mov b, 2
  add a, b
  mov b, a
  pop a
  mov [__alshift], b
  jmp _while105_cond
_while105_exit:
_if107_cond:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if107_exit
_if107_true:
  mov b, [__alshift] ; alshift
  push a
  mov a, b
  inc b
  mov [__alshift], b
  mov b, a
  pop a
  call aincrease
  jmp _if107_exit
_if107_exit:
_if108_cond:
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000011
  xor al, %00000010 ; >=
  cmp al, 0
  lodflgs
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if108_exit
_if108_true:
  mov b, [__brshift] ; brshift
  push a
  mov a, b
  inc b
  mov [__brshift], b
  mov b, a
  pop a
  call bdecrease
  jmp _if108_exit
_if108_exit:
  mov b, 0
  mov [__segmentcounter], b
  mov b, 0
  mov [__divcounter1], b
  mov b, 0
  mov [__divcounter2], b
  mov b, 0
  mov [__posflag], b
_if109_cond:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__bnarr] ; bnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if109_exit
_if109_true:
  mov b, [__blshift] ; blshift
  push a
  mov a, b
  inc b
  mov [__blshift], b
  mov b, a
  pop a
  call adecrease
  jmp _if109_exit
_if109_exit:
_while110_cond:
  mov b, [__segmentcounter] ; segmentcounter
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while110_exit
_while110_block:
  call checkabsabsize
_while111_cond:
  mov b, [__ageb] ; ageb
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while111_exit
_while111_block:
  call protominus
  mov b, [__divcounter1] ; divcounter1
  push a
  mov a, b
  inc b
  mov [__divcounter1], b
  mov b, a
  pop a
_for112_init:
  mov b, 0
  mov [__divi], b
_for112_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for112_exit
_for112_block:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
_for112_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for112_cond
_for112_exit:
  call checkabsabsize
  jmp _while111_cond
_while111_exit:
  mov b, [__posflag] ; posflag
  push a
  mov a, b
  inc b
  mov [__posflag], b
  mov b, a
  pop a
_if113_cond:
  mov b, [__posflag] ; posflag
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if113_exit
_if113_true:
  mov b, [__divcounter1] ; divcounter1
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  mov [__divcounter2], b
  mov b, 0
  mov [__divcounter1], b
  jmp _if113_exit
_if113_exit:
  call aincrease
_if114_cond:
  mov b, [__posflag] ; posflag
  push a
  mov a, b
  mov b, 2
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if114_exit
_if114_true:
  mov b, 0
  mov [__posflag], b
  mov b, [__divres] ; divres
  push a
  mov d, b
  push d
  mov b, 11
  push a
  mov a, b
  mov b, [__segmentcounter] ; segmentcounter
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__divcounter2] ; divcounter2
  push a
  mov a, b
  mov b, [__divcounter1] ; divcounter1
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
  mov b, 0
  mov [__divcounter1], b
  mov b, 0
  mov [__divcounter2], b
  mov b, [__segmentcounter] ; segmentcounter
  push a
  mov a, b
  inc b
  mov [__segmentcounter], b
  mov b, a
  pop a
  mov b, 1
  mov [__allzeroes], b
_for115_init:
  mov b, 0
  mov [__divi], b
_for115_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for115_exit
_for115_block:
_if116_cond:
  mov b, [__anarr] ; anarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if116_exit
_if116_true:
  mov b, 0
  mov [__allzeroes], b
  jmp _if116_exit
_if116_exit:
_for115_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for115_cond
_for115_exit:
_if117_cond:
  mov b, [__allzeroes] ; allzeroes
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if117_exit
_if117_true:
  leave
  ret
  jmp _if117_exit
_if117_exit:
  jmp _if114_exit
_if114_exit:
  jmp _while110_cond
_while110_exit:
  leave
  ret

normdivres:
  push bp
  mov bp, sp
_for118_init:
  mov b, 12
  mov [__divi], b
_for118_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 24
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for118_exit
_for118_block:
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
_for118_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for118_cond
_for118_exit:
_for119_init:
  mov b, 0
  mov [__divi], b
_for119_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for119_exit
_for119_block:
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__divres] ; divres
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for119_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for119_cond
_for119_exit:
  call normmulres
_for120_init:
  mov b, 0
  mov [__divshift], b
_for120_cond:
  mov b, [__divshift] ; divshift
  push a
  mov a, b
  mov b, 11
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for120_exit
_for120_block:
_for121_init:
  mov b, 0
  mov [__divi], b
_for121_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 23
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for121_exit
_for121_block:
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, 23
  push a
  mov a, b
  mov b, [__divi] ; divi
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, 23
  push a
  mov a, b
  mov b, [__divi] ; divi
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for121_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for121_cond
_for121_exit:
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
_for120_update:
  mov b, [__divshift] ; divshift
  push a
  mov a, b
  inc b
  mov [__divshift], b
  mov b, a
  pop a
  jmp _for120_cond
_for120_exit:
_for122_init:
  mov b, 0
  mov [__divi], b
_for122_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for122_exit
_for122_block:
  mov b, [__divres] ; divres
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 12
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for122_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for122_cond
_for122_exit:
  leave
  ret

times:
  push bp
  mov bp, sp
  call fixsignin
  mov b, 0
  mov [__csign], b
_if123_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, [__bsign] ; bsign
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if123_exit
_if123_true:
  mov b, 1
  mov [__csign], b
  jmp _if123_exit
_if123_exit:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  call prototimes
  mov b, 1
  mov [__allzeroes], b
_for124_init:
  mov b, 15
  mov [__pos], b
_for124_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 24
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for124_exit
_for124_block:
_if125_cond:
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if125_exit
_if125_true:
  mov b, 0
  mov [__allzeroes], b
  jmp _if125_exit
_if125_exit:
_for124_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for124_cond
_for124_exit:
_if126_cond:
  mov b, [__allzeroes] ; allzeroes
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if126_exit
_if126_true:
_for127_init:
  mov b, 4
  mov [__pos], b
_for127_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 15
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for127_exit
_for127_block:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 4
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__mulres] ; mulres
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for127_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for127_cond
_for127_exit:
  jmp _if126_exit
_if126_exit:
_if128_cond:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 9
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if128_exit
_if128_true:
_for129_init:
  mov b, 0
  mov [__pos], b
_for129_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for129_exit
_for129_block:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, 0
  pop d
  mov [d], b
_for129_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for129_cond
_for129_exit:
  jmp _if128_exit
_if128_exit:
  call fixcsizezero
  call fixsignout
  leave
  ret

dividedby:
  push bp
  mov bp, sp
  call fixsignin
  mov b, 0
  mov [__csign], b
_if130_cond:
  mov b, [__asign] ; asign
  push a
  mov a, b
  mov b, [__bsign] ; bsign
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if130_exit
_if130_true:
  mov b, 1
  mov [__csign], b
  jmp _if130_exit
_if130_exit:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, [__csign] ; csign
  mov [__bkpcsign], b
  call protodividedby
  call normdivres
_for131_init:
  mov b, 0
  mov [__pos], b
_for131_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for131_exit
_for131_block:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__divres] ; divres
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  pop d
  mov [d], b
_for131_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for131_cond
_for131_exit:
_for132_init:
  mov b, 0
  mov [__pos], b
_for132_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__alshift] ; alshift
  push a
  mov a, b
  mov b, [__brshift] ; brshift
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, 12
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [__blshift] ; blshift
  sub a, b
  mov b, a
  pop a
  cmp a, b
  lodflgs
  and al, %00000011 ; <=
  cmp al, 0
  lodflgs
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for132_exit
_for132_block:
_for133_init:
  mov b, 0
  mov [__divi], b
_for133_cond:
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 11
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for133_exit
_for133_block:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__subi], b
  mov b, [__subi] ; subi
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  mov [__subi], b
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, [__subi] ; subi
  sub a, b
  mov b, a
  pop a
  mov [__subi], b
  mov b, [__subi] ; subi
  push a
  mov a, b
  mov b, 10
  mul a, b
  pop a
  mov [__subi], b
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__subi] ; subi
  push a
  mov a, b
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov [d], b
_for133_update:
  mov b, [__divi] ; divi
  push a
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  pop a
  jmp _for133_cond
_for133_exit:
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  push d
  mov b, [__cnarr] ; cnarr
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  pop a
  mov b, [d]
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  pop d
  mov [d], b
_for132_update:
  mov b, [__pos] ; pos
  push a
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  pop a
  jmp _for132_cond
_for132_exit:
  mov b, [__bkpcsign] ; bkpcsign
  mov [__csign], b
  call fixcsizezero
  call fixsignout
  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
__sp_data: .db " ", 0
__sp: .dw __sp_data
__ionum_data: .fill 12, 0
__ionum: .dw __ionum_data
__ionr: .dw 0
__ioshift: .dw 0
__datum_data: .fill 72, 0
__datum: .dw __datum_data
__datumpos: .fill 2, 0
__anarr_data: .fill 24, 0
__anarr: .dw __anarr_data
__bnarr_data: .fill 24, 0
__bnarr: .dw __bnarr_data
__anarrbkp_data: .fill 24, 0
__anarrbkp: .dw __anarrbkp_data
__bnarrbkp_data: .fill 24, 0
__bnarrbkp: .dw __bnarrbkp_data
__cnarr_data: .fill 24, 0
__cnarr: .dw __cnarr_data
__mulres_data: .fill 48, 0
__mulres: .dw __mulres_data
__divres_data: .fill 24, 0
__divres: .dw __divres_data
__asign: .dw 0
__bsign: .dw 0
__csign: .dw 0
__protopos: .dw 0
__pos: .dw 0
__carry: .dw 0
__nextcarry: .dw 0
__agtb: .dw 0
__bgta: .dw 0
__aeqb: .dw 0
__aneqb: .dw 0
__ageb: .dw 0
__bgea: .dw 0
__eqflag: .dw 0
__sizepos: .dw 0
__psizepos: .dw 0
__swappos: .dw 0
__swaptmp: .dw 0
__toolarge: .dw 0
__normal: .dw 0
__mulpos1: .dw 0
__mulpos2: .dw 0
__mulpos3: .dw 0
__brshift: .dw 0
__blshift: .dw 0
__alshift: .dw 0
__divcounter1: .dw 0
__divcounter2: .dw 0
__segmentcounter: .dw 0
__divi: .dw 0
__allzeroes: .dw 0
__bkpcsign: .dw 0
__divshift: .dw 0
__subi: .dw 0
__posflag: .dw 0
__string_0: .db "\n", 0
__string_1: .db " ", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
