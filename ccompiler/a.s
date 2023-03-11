; --- FILENAME: largenumnSol1.c
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
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for1_cond
_for1_exit:
  call prnnl
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
  mov b, [__ionum]
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
  push d
  mov b, [__ionr] ; ionr
  pop d
  mov a, b
  mov [d], a
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
  mov b, [__ionum]
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
  mov b, [d]
  pop a
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
  mov b, [__ionum]
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
  mov b, [d]
  pop a
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
  mov b, [__ionum]
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
  mov b, [d]
  pop a
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
  mov b, [__ionum]
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
  mov b, [d]
  pop a
  swp b
  push b
  call prnnum
  add sp, 2
_for3_update:
  mov b, [__datumpos] ; datumpos
  mov a, b
  dec b
  mov [__datumpos], b
  mov b, a
  jmp _for3_cond
_for3_exit:
  call prnnl
_for2_update:
  mov b, [__pos] ; pos
  mov a, b
  dec b
  mov [__pos], b
  mov b, a
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
  mov b, [__datum]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__ionum]
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
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for7_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
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
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for8_cond
_for8_exit:
  call prnnl
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
  mov b, [__ionum]
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
  push d
  mov b, [__ionr] ; ionr
  pop d
  mov a, b
  mov [d], a
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
  mov b, [__ionum]
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
  mov b, [d]
  pop a
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
  mov b, [__ionum]
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
  mov b, [d]
  pop a
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
  mov b, [__ionum]
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
  mov b, [d]
  pop a
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
  mov b, [__ionum]
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
  mov b, [d]
  pop a
  swp b
  push b
  call prnnum
  add sp, 2
_for10_update:
  mov b, [__datumpos] ; datumpos
  mov a, b
  dec b
  mov [__datumpos], b
  mov b, a
  jmp _for10_cond
_for10_exit:
  call prnnl
_for9_update:
  mov b, [__pos] ; pos
  mov a, b
  dec b
  mov [__pos], b
  mov b, a
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
  mov b, [__datum]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__ionum]
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
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for14_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
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
  mov b, [__datum]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, 100
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__ioshift], b
  mov b, [__anarr]
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
  push d
  mov b, [__ioshift] ; ioshift
  pop d
  mov a, b
  mov [d], a
  mov b, [__anarr]
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
  push d
  mov b, [__datum]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  mov a, b
  mov [d], a
_for15_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
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
  mov b, [__datum]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, 100
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__ioshift], b
  mov b, [__bnarr]
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
  push d
  mov b, [__ioshift] ; ioshift
  pop d
  mov a, b
  mov [d], a
  mov b, [__bnarr]
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
  push d
  mov b, [__datum]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  mov a, b
  mov [d], a
_for16_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
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
  mov b, [__anarrbkp]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
  mov b, [__bnarrbkp]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for17_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
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
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for18_cond
_for18_exit:
  call prnnl
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
  mov b, [__datum]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__cnarr]
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
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, 100
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [__cnarr]
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
  mov b, [d]
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
_for19_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
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
  mov b, [__datum]
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
  mov b, [d]
  pop a
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
  mov b, [__datum]
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
  mov b, [d]
  pop a
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
  mov b, [__datum]
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
  mov b, [d]
  pop a
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
  mov b, [__datum]
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
  mov b, [d]
  pop a
  swp b
  push b
  call prnnumspace
  add sp, 2
_for20_update:
  mov b, [__pos] ; pos
  mov a, b
  dec b
  mov [__pos], b
  mov b, a
  jmp _for20_cond
_for20_exit:
  call prnnl
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
  mov b, [__anarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__anarrbkp]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
  mov b, [__bnarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__bnarrbkp]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for24_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
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
  mov b, [__datum]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__cnarr]
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
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, 100
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [__cnarr]
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
  mov b, [d]
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
_for25_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
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
  mov b, [__datum]
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
  mov b, [d]
  pop a
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
  mov b, [__datum]
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
  mov b, [d]
  pop a
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
  mov b, [__datum]
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
  mov b, [d]
  pop a
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
  mov b, [__datum]
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
  mov b, [d]
  pop a
  swp b
  push b
  call prnnumspace
  add sp, 2
_for26_update:
  mov b, [__pos] ; pos
  mov a, b
  dec b
  mov [__pos], b
  mov b, a
  jmp _for26_cond
_for26_exit:
  call prnnl
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
  mov b, [__anarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__anarrbkp]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
  mov b, [__bnarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__bnarrbkp]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for30_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for30_cond
_for30_exit:
  call dividedby
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
  mov b, [__datum]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__cnarr]
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
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, 100
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [__cnarr]
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
  mov b, [d]
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
_for31_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
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
  mov b, [__datum]
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
  mov b, [d]
  pop a
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
  mov b, [__datum]
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
  mov b, [d]
  pop a
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
  mov b, [__datum]
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
  mov b, [d]
  pop a
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
  mov b, [__datum]
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
  mov b, [d]
  pop a
  swp b
  push b
  call prnnumspace
  add sp, 2
_for32_update:
  mov b, [__pos] ; pos
  mov a, b
  dec b
  mov [__pos], b
  mov b, a
  jmp _for32_cond
_for32_exit:
  call prnnl
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
  mov b, [__anarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__anarrbkp]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
  mov b, [__bnarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__bnarrbkp]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for36_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for36_cond
_for36_exit:
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

prnnumspace:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [bp + 5]
  call print_u16d
  mov a, [__sp]
  mov d, a
  call puts
; --- END INLINE ASM BLOCK

  leave
  ret

prnnum:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [bp + 5]
  call print_u16d
; --- END INLINE ASM BLOCK

  leave
  ret

prnnl:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [__ss]
  mov d, a
  call puts
; --- END INLINE ASM BLOCK

  leave
  ret

prnsp:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [__sp]
  mov d, a
  call puts
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
_if37_cond:
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if37_exit
_if37_true:
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__pos], b
  mov b, [__anarr]
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  mov a, b
  mov [d], a
  mov b, 1
  mov [__asign], b
  jmp _if37_exit
_if37_exit:
_if38_cond:
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if38_exit
_if38_true:
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, 10
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__pos], b
  mov b, [__bnarr]
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  mov a, b
  mov [d], a
  mov b, 1
  mov [__bsign], b
  jmp _if38_exit
_if38_exit:
  leave
  ret

fixsignout:
  push bp
  mov bp, sp
_if39_cond:
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
  je _if39_exit
_if39_true:
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__cnarr]
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, 10
  add a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
  mov b, 0
  mov [__csign], b
  jmp _if39_exit
_if39_exit:
  leave
  ret

fixcsizezero:
  push bp
  mov bp, sp
  mov b, 1
  mov [__allzeroes], b
_for40_init:
  mov b, 1
  mov [__pos], b
_for40_cond:
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
  je _for40_exit
_for40_block:
_if41_cond:
  mov b, [__cnarr]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if41_exit
_if41_true:
  mov b, 0
  mov [__allzeroes], b
  jmp _for40_exit ; for break
  jmp _if41_exit
_if41_exit:
_for40_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for40_cond
_for40_exit:
_if42_cond:
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
  je _if42_exit
_if42_true:
  mov b, 0
  mov [__csign], b
  jmp _if42_exit
_if42_exit:
_if43_cond:
  mov b, [__cnarr]
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if43_exit
_if43_true:
  mov b, 0
  mov [__csign], b
_for44_init:
  mov b, 1
  mov [__pos], b
_for44_cond:
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
  je _for44_exit
_for44_block:
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for44_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for44_cond
_for44_exit:
  jmp _if43_exit
_if43_exit:
  leave
  ret

swapab:
  push bp
  mov bp, sp
_for45_init:
  mov b, 0
  mov [__swappos], b
_for45_cond:
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
  je _for45_exit
_for45_block:
  mov b, [__anarr]
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
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
  mov b, [__bnarr]
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
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
  mov b, [__anarr]
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [__swappos] ; swappos
  pop d
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
_for45_update:
  mov b, [__swappos] ; swappos
  mov a, b
  inc b
  mov [__swappos], b
  mov b, a
  jmp _for45_cond
_for45_exit:
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
_for46_init:
  mov b, 12
  mov [__psizepos], b
_for46_cond:
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
  je _for46_exit
_for46_block:
  mov b, [__psizepos] ; psizepos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  mov [__sizepos], b
_if47_cond:
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [__sizepos] ; sizepos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [__sizepos] ; sizepos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
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
  je _if47_exit
_if47_true:
  mov b, 1
  mov [__aneqb], b
  mov b, 1
  mov [__agtb], b
  mov b, 1
  mov [__ageb], b
  jmp _if47_exit
_if47_exit:
_if48_cond:
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [__sizepos] ; sizepos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [__sizepos] ; sizepos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if48_exit
_if48_true:
  mov b, 1
  mov [__aneqb], b
  mov b, 1
  mov [__bgta], b
  mov b, 1
  mov [__bgea], b
  jmp _if48_exit
_if48_exit:
_if49_cond:
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
  je _if49_exit
_if49_true:
  jmp _for46_exit ; for break
  jmp _if49_exit
_if49_exit:
_for46_update:
  mov b, [__psizepos] ; psizepos
  mov a, b
  dec b
  mov [__psizepos], b
  mov b, a
  jmp _for46_cond
_for46_exit:
_if50_cond:
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
  je _if50_exit
_if50_true:
  mov b, 1
  mov [__aeqb], b
  mov b, 1
  mov [__ageb], b
  mov b, 1
  mov [__bgea], b
  jmp _if50_exit
_if50_exit:
  leave
  ret

protoplus:
  push bp
  mov bp, sp
  mov b, 0
  mov [__carry], b
_for51_init:
  mov b, 0
  mov [__pos], b
_for51_cond:
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
  je _for51_exit
_for51_block:
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  mov a, b
  mov [d], a
  mov b, 0
  mov [__carry], b
_if52_cond:
  mov b, [__cnarr]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if52_exit
_if52_true:
  mov b, 1
  mov [__carry], b
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__cnarr]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, 100
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
  jmp _if52_exit
_if52_exit:
_for51_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for51_cond
_for51_exit:
  leave
  ret

protominus:
  push bp
  mov bp, sp
  mov b, 0
  mov [__carry], b
_for53_init:
  mov b, 0
  mov [__pos], b
_for53_cond:
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
  je _for53_exit
_for53_block:
  mov b, 0
  mov [__nextcarry], b
_if54_cond:
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__carry] ; carry
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
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
  je _if54_exit
_if54_true:
  mov b, [__anarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, 100
  add a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
  mov b, 1
  mov [__nextcarry], b
  jmp _if54_exit
_if54_exit:
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  mov a, b
  mov [d], a
  mov b, [__nextcarry] ; nextcarry
  mov [__carry], b
_for53_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for53_cond
_for53_exit:
_if55_cond:
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
  je _if55_exit
_if55_true:
  mov b, 1
  mov [__csign], b
  mov b, 0
  mov [__carry], b
  jmp _if55_exit
_if55_exit:
  leave
  ret

pminus:
  push bp
  mov bp, sp
_for56_init:
  mov b, 0
  mov [__divi], b
_for56_cond:
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
  je _for56_exit
_for56_block:
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for56_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for56_cond
_for56_exit:
  call checkabsabsize
_if57_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if57_exit
_if57_true:
  mov b, 0
  mov [__csign], b
_for58_init:
  mov b, 1
  mov [__pos], b
_for58_cond:
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
  je _for58_exit
_for58_block:
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for58_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for58_cond
_for58_exit:
  jmp _if57_exit
_if57_exit:
_if59_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if59_exit
_if59_true:
  mov b, 0
  mov [__csign], b
  call protominus
  jmp _if59_exit
_if59_exit:
_if60_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if60_exit
_if60_true:
  mov b, 1
  mov [__csign], b
  call swapab
  call protominus
  jmp _if60_exit
_if60_exit:
_if61_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if61_exit
_if61_true:
  mov b, 1
  mov [__csign], b
  call protominus
  jmp _if61_exit
_if61_exit:
_if62_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if62_exit
_if62_true:
  mov b, 0
  mov [__csign], b
  call swapab
  call protominus
  jmp _if62_exit
_if62_exit:
_if63_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if63_exit
_if63_true:
  mov b, 0
  mov [__csign], b
  call protoplus
  jmp _if63_exit
_if63_exit:
_if64_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if64_exit
_if64_true:
  mov b, 1
  mov [__csign], b
  call protoplus
  jmp _if64_exit
_if64_exit:
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
_for65_init:
  mov b, 0
  mov [__divi], b
_for65_cond:
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
  je _for65_exit
_for65_block:
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for65_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for65_cond
_for65_exit:
  call checkabsabsize
_if66_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if66_exit
_if66_true:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, 0
  mov [__csign], b
_for67_init:
  mov b, 1
  mov [__pos], b
_for67_cond:
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
  je _for67_exit
_for67_block:
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for67_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for67_cond
_for67_exit:
  leave
  ret
  jmp _if66_exit
_if66_exit:
_if68_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if68_exit
_if68_true:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, 0
  mov [__csign], b
_for69_init:
  mov b, 1
  mov [__pos], b
_for69_cond:
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
  je _for69_exit
_for69_block:
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for69_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for69_cond
_for69_exit:
  leave
  ret
  jmp _if68_exit
_if68_exit:
_if70_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if70_exit
_if70_true:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, 0
  mov [__csign], b
  call protoplus
  leave
  ret
  jmp _if70_exit
_if70_exit:
_if71_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if71_exit
_if71_true:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, 1
  mov [__csign], b
  call protoplus
  leave
  ret
  jmp _if71_exit
_if71_exit:
_if72_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if72_exit
_if72_true:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, 0
  mov [__csign], b
  call protominus
  leave
  ret
  jmp _if72_exit
_if72_exit:
_if73_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if73_exit
_if73_true:
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
  jmp _if73_exit
_if73_exit:
_if74_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if74_exit
_if74_true:
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
  jmp _if74_exit
_if74_exit:
_if75_cond:
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
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
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
  pop bl
  or al, bl
  xor al, %00000001
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if75_exit
_if75_true:
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
  jmp _if75_exit
_if75_exit:
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
_if76_cond:
  mov b, [__mulres]
  push a
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if76_exit
_if76_true:
  mov b, [__mulres]
  push a
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, 100
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__toolarge], b
  mov b, [__mulres]
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__mulres]
  push a
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  mov a, b
  mov [d], a
  jmp _if76_exit
_if76_exit:
  mov b, 0
  mov [__normal], b
_while77_cond:
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
  je _while77_exit
_while77_block:
  mov b, 1
  mov [__normal], b
_for78_init:
  mov b, 0
  mov [__protopos], b
_for78_cond:
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
  je _for78_exit
_for78_block:
  mov b, 22
  push a
  mov a, b
  mov b, [__protopos] ; protopos
  sub a, b
  mov b, a
  pop a
  mov [__pos], b
_if79_cond:
  mov b, [__mulres]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if79_exit
_if79_true:
  mov b, 0
  mov [__normal], b
  mov b, [__mulres]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, 100
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__toolarge], b
  mov b, [__mulres]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__mulres]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  mov a, b
  mov [d], a
  mov b, [__mulres]
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
  push d
  mov b, [__mulres]
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
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__toolarge] ; toolarge
  add a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
  jmp _if79_exit
_if79_exit:
_for78_update:
  mov b, [__protopos] ; protopos
  mov a, b
  inc b
  mov [__protopos], b
  mov b, a
  jmp _for78_cond
_for78_exit:
  jmp _while77_cond
_while77_exit:
_if80_cond:
  mov b, [__mulres]
  push a
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if80_exit
_if80_true:
  mov b, [__mulres]
  push a
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, 100
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [__toolarge], b
  mov b, [__mulres]
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__mulres]
  push a
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  mov a, b
  mov [d], a
  jmp _if80_exit
_if80_exit:
  leave
  ret

prototimes:
  push bp
  mov bp, sp
_for81_init:
  mov b, 0
  mov [__divi], b
_for81_cond:
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
  je _for81_exit
_for81_block:
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for81_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for81_cond
_for81_exit:
_for82_init:
  mov b, 0
  mov [__divi], b
_for82_cond:
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
  je _for82_exit
_for82_block:
  mov b, [__mulres]
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for82_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for82_cond
_for82_exit:
_for83_init:
  mov b, 0
  mov [__mulpos1], b
_for83_cond:
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
  je _for83_exit
_for83_block:
_for84_init:
  mov b, 0
  mov [__mulpos2], b
_for84_cond:
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
  je _for84_exit
_for84_block:
  mov b, [__mulres]
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
  push d
  mov b, [__mulres]
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
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [__mulpos2] ; mulpos2
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [__mulpos1] ; mulpos1
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  mul a, b
  pop a
  add a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
_for84_update:
  mov b, [__mulpos2] ; mulpos2
  mov a, b
  inc b
  mov [__mulpos2], b
  mov b, a
  jmp _for84_cond
_for84_exit:
  call normmulres
_for83_update:
  mov b, [__mulpos1] ; mulpos1
  mov a, b
  inc b
  mov [__mulpos1], b
  mov b, a
  jmp _for83_cond
_for83_exit:
  leave
  ret

protodividedby:
  push bp
  mov bp, sp
  mov b, 0
  mov [__brshift], b
  mov b, 0
  mov [__blshift], b
  mov b, 0
  mov [__alshift], b
  mov b, 0
  mov [__divcounter], b
  mov b, 0
  mov [__segmentcounter], b
  mov b, 1
  mov [__allzeroes], b
_for85_init:
  mov b, 0
  mov [__divi], b
_for85_cond:
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
  je _for85_exit
_for85_block:
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
  mov b, [__divres]
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_if86_cond:
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if86_exit
_if86_true:
  mov b, 0
  mov [__allzeroes], b
  jmp _if86_exit
_if86_exit:
_for85_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for85_cond
_for85_exit:
_if87_cond:
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
  je _if87_exit
_if87_true:
  leave
  ret
  jmp _if87_exit
_if87_exit:
_if88_cond:
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if88_exit
_if88_true:
_for89_init:
  mov b, 0
  mov [__divi], b
_for89_cond:
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
  je _for89_exit
_for89_block:
  mov b, [__bnarr]
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__bnarr]
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
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for89_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for89_cond
_for89_exit:
  mov b, 1
  mov [__brshift], b
  mov b, [__bnarr]
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
  jmp _if88_exit
_if88_exit:
_while90_cond:
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, 10
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _while90_exit
_while90_block:
_for91_init:
  mov b, 0
  mov [__divi], b
_for91_cond:
  mov b, [__divi] ; divi
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
  je _for91_exit
_for91_block:
  mov b, [__bnarr]
  mov d, b
  push d
  mov b, 10
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
  push d
  mov b, [__bnarr]
  push a
  mov d, b
  push d
  mov b, 10
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
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for91_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for91_cond
_for91_exit:
  mov b, [__bnarr]
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
  mov b, [__blshift] ; blshift
  mov a, b
  inc b
  mov [__blshift], b
  mov b, a
  jmp _while90_cond
_while90_exit:
  mov b, 1
  mov [__allzeroes], b
_for92_init:
  mov b, 0
  mov [__divi], b
_for92_cond:
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
  je _for92_exit
_for92_block:
_if93_cond:
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if93_exit
_if93_true:
  mov b, 0
  mov [__allzeroes], b
  jmp _if93_exit
_if93_exit:
_for92_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for92_cond
_for92_exit:
_if94_cond:
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
  je _if94_exit
_if94_true:
  leave
  ret
  jmp _if94_exit
_if94_exit:
_while95_cond:
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _while95_exit
_while95_block:
_for96_init:
  mov b, 0
  mov [__divi], b
_for96_cond:
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
  je _for96_exit
_for96_block:
  mov b, [__anarr]
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
  push d
  mov b, [__anarr]
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
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for96_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for96_cond
_for96_exit:
  mov b, [__anarr]
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
  mov b, [__alshift] ; alshift
  mov a, b
  inc b
  mov [__alshift], b
  mov b, a
  jmp _while95_cond
_while95_exit:
  mov b, 0
  mov [__segmentcounter], b
  mov b, 0
  mov [__divcounter], b
_while97_cond:
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
  je _while97_exit
_while97_block:
_while98_cond:
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _while98_exit
_while98_block:
  call pminus
  mov b, [__divcounter] ; divcounter
  mov a, b
  inc b
  mov [__divcounter], b
  mov b, a
_for99_init:
  mov b, 0
  mov [__divi], b
_for99_cond:
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
  je _for99_exit
_for99_block:
  mov b, [__anarr]
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__cnarr]
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for99_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for99_cond
_for99_exit:
  jmp _while98_cond
_while98_exit:
  mov b, [__divres]
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
  push d
  mov b, [__divcounter] ; divcounter
  pop d
  mov a, b
  mov [d], a
  mov b, 0
  mov [__divcounter], b
  mov b, [__segmentcounter] ; segmentcounter
  mov a, b
  inc b
  mov [__segmentcounter], b
  mov b, a
  mov b, 1
  mov [__allzeroes], b
_for100_init:
  mov b, 0
  mov [__divi], b
_for100_cond:
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
  je _for100_exit
_for100_block:
_if101_cond:
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if101_exit
_if101_true:
  mov b, 0
  mov [__allzeroes], b
  jmp _if101_exit
_if101_exit:
_for100_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for100_cond
_for100_exit:
_if102_cond:
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
  je _if102_exit
_if102_true:
  leave
  ret
  jmp _if102_exit
_if102_exit:
_while103_cond:
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _while103_exit
_while103_block:
_for104_init:
  mov b, 0
  mov [__divi], b
_for104_cond:
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
  je _for104_exit
_for104_block:
  mov b, [__anarr]
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
  push d
  mov b, [__anarr]
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
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for104_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for104_cond
_for104_exit:
  mov b, [__anarr]
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_if105_cond:
  mov b, [__anarr]
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if105_exit
_if105_true:
  mov b, [__divres]
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
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
  mov b, [__anarr]
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
  mov b, [__segmentcounter] ; segmentcounter
  mov a, b
  inc b
  mov [__segmentcounter], b
  mov b, a
_if106_cond:
  mov b, [__segmentcounter] ; segmentcounter
  push a
  mov a, b
  mov b, 12
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if106_exit
_if106_true:
  leave
  ret
  jmp _if106_exit
_if106_exit:
  jmp _if105_exit
_if105_exit:
  jmp _while103_cond
_while103_exit:
  jmp _while97_cond
_while97_exit:
  leave
  ret

normdivres:
  push bp
  mov bp, sp
_for107_init:
  mov b, 12
  mov [__divi], b
_for107_cond:
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
  je _for107_exit
_for107_block:
  mov b, [__mulres]
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for107_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for107_cond
_for107_exit:
_for108_init:
  mov b, 0
  mov [__divi], b
_for108_cond:
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
  je _for108_exit
_for108_block:
  mov b, [__mulres]
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__divres]
  push a
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for108_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for108_cond
_for108_exit:
  call normmulres
_for109_init:
  mov b, 0
  mov [__divshift], b
_for109_cond:
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
  je _for109_exit
_for109_block:
_for110_init:
  mov b, 0
  mov [__divi], b
_for110_cond:
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
  je _for110_exit
_for110_block:
  mov b, [__mulres]
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
  push d
  mov b, [__mulres]
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
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for110_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for110_cond
_for110_exit:
  mov b, [__mulres]
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for109_update:
  mov b, [__divshift] ; divshift
  mov a, b
  inc b
  mov [__divshift], b
  mov b, a
  jmp _for109_cond
_for109_exit:
_for111_init:
  mov b, 0
  mov [__divi], b
_for111_cond:
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
  je _for111_exit
_for111_block:
  mov b, [__divres]
  mov d, b
  push d
  mov b, [__divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__mulres]
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
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for111_update:
  mov b, [__divi] ; divi
  mov a, b
  inc b
  mov [__divi], b
  mov b, a
  jmp _for111_cond
_for111_exit:
  leave
  ret

times:
  push bp
  mov bp, sp
  call fixsignin
  mov b, 0
  mov [__csign], b
_if112_cond:
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
  je _if112_exit
_if112_true:
  mov b, 1
  mov [__csign], b
  jmp _if112_exit
_if112_exit:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  call prototimes
  mov b, 1
  mov [__allzeroes], b
_for113_init:
  mov b, 15
  mov [__pos], b
_for113_cond:
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
  je _for113_exit
_for113_block:
_if114_cond:
  mov b, [__mulres]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if114_exit
_if114_true:
  mov b, 0
  mov [__allzeroes], b
  jmp _if114_exit
_if114_exit:
_for113_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for113_cond
_for113_exit:
_if115_cond:
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
  je _if115_exit
_if115_true:
_for116_init:
  mov b, 4
  mov [__pos], b
_for116_cond:
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
  je _for116_exit
_for116_block:
  mov b, [__cnarr]
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
  push d
  mov b, [__mulres]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for116_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for116_cond
_for116_exit:
  jmp _if115_exit
_if115_exit:
_if117_cond:
  mov b, [__cnarr]
  push a
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
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
  je _if117_exit
_if117_true:
_for118_init:
  mov b, 0
  mov [__pos], b
_for118_cond:
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
  je _for118_exit
_for118_block:
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for118_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for118_cond
_for118_exit:
  jmp _if117_exit
_if117_exit:
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
_if119_cond:
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
  je _if119_exit
_if119_true:
  mov b, 1
  mov [__csign], b
  jmp _if119_exit
_if119_exit:
  mov b, 0
  mov [__asign], b
  mov b, 0
  mov [__bsign], b
  mov b, [__csign] ; csign
  mov [__bkpcsign], b
  call protodividedby
  call normdivres
_if120_cond:
  mov b, [__blshift] ; blshift
  push a
  mov a, b
  mov b, 6
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [__alshift] ; alshift
  push a
  mov a, b
  mov b, [__brshift] ; brshift
  add a, b
  mov b, a
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
  je _if120_exit
_if120_true:
  mov b, [__blshift] ; blshift
  push a
  mov a, b
  mov b, 6
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [__alshift] ; alshift
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [__brshift] ; brshift
  sub a, b
  mov b, a
  pop a
  mov [__blshift], b
  mov b, 12
  push a
  mov a, b
  mov b, [__blshift] ; blshift
  sub a, b
  mov b, a
  pop a
  mov [__divi], b
_for121_init:
  mov b, 0
  mov [__pos], b
_for121_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__blshift] ; blshift
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
_if122_cond:
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__divi] ; divi
  add a, b
  mov b, a
  pop a
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
  je _if122_exit
_if122_true:
  mov b, [__cnarr]
  mov d, b
  push d
  mov b, [__pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [__divres]
  push a
  mov d, b
  push d
  mov b, [__pos] ; pos
  push a
  mov a, b
  mov b, [__divi] ; divi
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
  jmp _if122_exit
_if122_exit:
_for121_update:
  mov b, [__pos] ; pos
  mov a, b
  inc b
  mov [__pos], b
  mov b, a
  jmp _for121_cond
_for121_exit:
  jmp _if120_exit
_if120_exit:
  mov b, [__bkpcsign] ; bkpcsign
  mov [__csign], b
  call fixcsizezero
  call fixsignout
  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
__ss_data: .db "\n", 0
__ss: .dw __ss_data
__sp_data: .db " ", 0
__sp: .dw __sp_data
__ionum_data: .fill 12, 0
__ionum: .dw __ionum_data
__ionr: .dw 0
__ioshift: .dw 0
__datum_data: .fill 72, 0
__datum: .dw __datum_data
__datumpos: .dw 0
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
__divcounter: .dw 0
__segmentcounter: .dw 0
__divi: .dw 0
__allzeroes: .dw 0
__bkpcsign: .dw 0
__divshift: .dw 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
