; --- FILENAME: largenumnSol1.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
_for1_init:
  mov b, 0
  mov [pos], b
_for1_cond:
  mov b, [pos] ; pos
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
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for1_cond
_for1_exit:
  call prnnl
_for2_init:
  mov b, 6
  mov [pos], b
_for2_cond:
  mov b, [pos] ; pos
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
  mov [ionr], b
  mov b, [ionr] ; ionr
  push a
  mov a, b
  mov b, 10000
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [ioshift], b
  mov b, [ioshift] ; ioshift
  push a
  mov a, b
  mov b, 10000
  mul a, b
  pop a
  mov [ioshift], b
  mov b, [ionr] ; ionr
  push a
  mov a, b
  mov b, [ioshift] ; ioshift
  sub a, b
  mov b, a
  pop a
  mov [ionr], b
  mov b, [ionum]
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [ionr] ; ionr
  pop d
  mov a, b
  mov [d], a
_for3_init:
  mov b, 6
  mov [datumpos], b
_for3_cond:
  mov b, [datumpos] ; datumpos
  push a
  mov a, b
  mov b, [pos] ; pos
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
  mov b, [ionum]
  push a
  mov d, b
  push d
  mov b, [datumpos] ; datumpos
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
  mov b, [ionum]
  push a
  mov d, b
  push d
  mov b, [datumpos] ; datumpos
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
  mov b, [ionum]
  push a
  mov d, b
  push d
  mov b, [datumpos] ; datumpos
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
  mov b, [ionum]
  push a
  mov d, b
  push d
  mov b, [datumpos] ; datumpos
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
  mov b, [datumpos] ; datumpos
  mov a, b
  dec b
  mov [datumpos], b
  mov b, a
  jmp _for3_cond
_for3_exit:
  call prnnl
_for2_update:
  mov b, [pos] ; pos
  mov a, b
  dec b
  mov [pos], b
  mov b, a
  jmp _for2_cond
_for2_exit:
  mov b, 0
  mov [datumpos], b
_for7_init:
  mov b, [datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [pos], b
_for7_cond:
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [datum]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [ionum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for7_cond
_for7_exit:
_for8_init:
  mov b, 0
  mov [pos], b
_for8_cond:
  mov b, [pos] ; pos
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
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for8_cond
_for8_exit:
  call prnnl
_for9_init:
  mov b, 6
  mov [pos], b
_for9_cond:
  mov b, [pos] ; pos
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
  mov [ionr], b
  mov b, [ionr] ; ionr
  push a
  mov a, b
  mov b, 10000
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  mov [ioshift], b
  mov b, [ioshift] ; ioshift
  push a
  mov a, b
  mov b, 10000
  mul a, b
  pop a
  mov [ioshift], b
  mov b, [ionr] ; ionr
  push a
  mov a, b
  mov b, [ioshift] ; ioshift
  sub a, b
  mov b, a
  pop a
  mov [ionr], b
  mov b, [ionum]
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [ionr] ; ionr
  pop d
  mov a, b
  mov [d], a
_for10_init:
  mov b, 6
  mov [datumpos], b
_for10_cond:
  mov b, [datumpos] ; datumpos
  push a
  mov a, b
  mov b, [pos] ; pos
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
  mov b, [ionum]
  push a
  mov d, b
  push d
  mov b, [datumpos] ; datumpos
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
  mov b, [ionum]
  push a
  mov d, b
  push d
  mov b, [datumpos] ; datumpos
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
  mov b, [ionum]
  push a
  mov d, b
  push d
  mov b, [datumpos] ; datumpos
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
  mov b, [ionum]
  push a
  mov d, b
  push d
  mov b, [datumpos] ; datumpos
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
  mov b, [datumpos] ; datumpos
  mov a, b
  dec b
  mov [datumpos], b
  mov b, a
  jmp _for10_cond
_for10_exit:
  call prnnl
_for9_update:
  mov b, [pos] ; pos
  mov a, b
  dec b
  mov [pos], b
  mov b, a
  jmp _for9_cond
_for9_exit:
  mov b, 1
  mov [datumpos], b
_for14_init:
  mov b, [datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [pos], b
_for14_cond:
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [datum]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [ionum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for14_cond
_for14_exit:
  mov b, 0
  mov [datumpos], b
_for15_init:
  mov b, [datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [pos], b
_for15_cond:
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov [ioshift], b
  mov b, [anarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [ioshift] ; ioshift
  pop d
  mov a, b
  mov [d], a
  mov b, [anarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [ioshift] ; ioshift
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
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for15_cond
_for15_exit:
  mov b, 1
  mov [datumpos], b
_for16_init:
  mov b, [datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [pos], b
_for16_cond:
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov [ioshift], b
  mov b, [bnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [ioshift] ; ioshift
  pop d
  mov a, b
  mov [d], a
  mov b, [bnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [ioshift] ; ioshift
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
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for16_cond
_for16_exit:
_for17_init:
  mov b, 0
  mov [pos], b
_for17_cond:
  mov b, [pos] ; pos
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
  mov b, [anarrbkp]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
  mov b, [bnarrbkp]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [bnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for17_cond
_for17_exit:
_for18_init:
  mov b, 0
  mov [pos], b
_for18_cond:
  mov b, [pos] ; pos
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
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for18_cond
_for18_exit:
  call prnnl
  call plus
  mov b, 2
  mov [datumpos], b
_for19_init:
  mov b, [datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [pos], b
_for19_cond:
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [datum]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [cnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [cnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for19_cond
_for19_exit:
_for20_init:
  mov b, 18
  mov [pos], b
_for20_cond:
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [pos] ; pos
  mov a, b
  dec b
  mov [pos], b
  mov b, a
  jmp _for20_cond
_for20_exit:
  call prnnl
_for24_init:
  mov b, 0
  mov [pos], b
_for24_cond:
  mov b, [pos] ; pos
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
  mov b, [anarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [anarrbkp]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
  mov b, [bnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [bnarrbkp]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for24_cond
_for24_exit:
  call minus
  mov b, 2
  mov [datumpos], b
_for25_init:
  mov b, [datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [pos], b
_for25_cond:
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [datum]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [cnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [cnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for25_cond
_for25_exit:
_for26_init:
  mov b, 18
  mov [pos], b
_for26_cond:
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [pos] ; pos
  mov a, b
  dec b
  mov [pos], b
  mov b, a
  jmp _for26_cond
_for26_exit:
  call prnnl
_for30_init:
  mov b, 0
  mov [pos], b
_for30_cond:
  mov b, [pos] ; pos
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
  mov b, [anarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [anarrbkp]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
  mov b, [bnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [bnarrbkp]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for30_cond
_for30_exit:
  call times
  mov b, 2
  mov [datumpos], b
_for31_init:
  mov b, [datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [pos], b
_for31_cond:
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [datum]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [cnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [cnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for31_cond
_for31_exit:
_for32_init:
  mov b, 18
  mov [pos], b
_for32_cond:
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [pos] ; pos
  mov a, b
  dec b
  mov [pos], b
  mov b, a
  jmp _for32_cond
_for32_exit:
  call prnnl
_for36_init:
  mov b, 0
  mov [pos], b
_for36_cond:
  mov b, [pos] ; pos
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
  mov b, [anarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [anarrbkp]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
  mov b, [bnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [bnarrbkp]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for36_cond
_for36_exit:
  call dividedby
  mov b, 2
  mov [datumpos], b
_for37_init:
  mov b, [datumpos] ; datumpos
  push a
  mov a, b
  mov b, 6
  mul a, b
  pop a
  mov [pos], b
_for37_cond:
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [datum]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [cnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
  mov b, [cnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [datumpos] ; datumpos
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
_for37_update:
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for37_cond
_for37_exit:
_for38_init:
  mov b, 18
  mov [pos], b
_for38_cond:
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  je _if41_exit
_if41_true:
  mov b, 0
  swp b
  push b
  call prnnum
  add sp, 2
  jmp _if41_exit
_if41_exit:
  mov b, [datum]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
_for38_update:
  mov b, [pos] ; pos
  mov a, b
  dec b
  mov [pos], b
  mov b, a
  jmp _for38_cond
_for38_exit:
  call prnnl
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
  mov a, [sp]
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
  mov a, [ss]
  mov d, a
  call puts
; --- END INLINE ASM BLOCK

  leave
  ret

prnsp:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [sp]
  mov d, a
  call puts
; --- END INLINE ASM BLOCK

  leave
  ret

fixsignin:
  push bp
  mov bp, sp
  mov b, 0
  mov [asign], b
  mov b, 0
  mov [bsign], b
  mov b, 0
  mov [csign], b
_if42_cond:
  mov b, [anarr]
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
  je _if42_exit
_if42_true:
  mov b, [anarr]
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
  mov [pos], b
  mov b, [anarr]
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [anarr]
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
  mov b, [pos] ; pos
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
  mov [asign], b
  jmp _if42_exit
_if42_exit:
_if43_cond:
  mov b, [bnarr]
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
  mov b, [bnarr]
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
  mov [pos], b
  mov b, [bnarr]
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [bnarr]
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
  mov b, [pos] ; pos
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
  mov [bsign], b
  jmp _if43_exit
_if43_exit:
  leave
  ret

fixsignout:
  push bp
  mov bp, sp
_if44_cond:
  mov b, [csign] ; csign
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
  je _if44_exit
_if44_true:
  mov b, [cnarr]
  mov d, b
  push d
  mov b, 11
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [cnarr]
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
  mov [csign], b
  jmp _if44_exit
_if44_exit:
  leave
  ret

fixcsizezero:
  push bp
  mov bp, sp
  mov b, 1
  mov [allzeroes], b
_for45_init:
  mov b, 1
  mov [pos], b
_for45_cond:
  mov b, [pos] ; pos
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
_if46_cond:
  mov b, [cnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  je _if46_exit
_if46_true:
  mov b, 0
  mov [allzeroes], b
  jmp _for45_exit ; for break
  jmp _if46_exit
_if46_exit:
_for45_update:
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for45_cond
_for45_exit:
_if47_cond:
  mov b, [allzeroes] ; allzeroes
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
  mov b, 0
  mov [csign], b
  jmp _if47_exit
_if47_exit:
_if48_cond:
  mov b, [cnarr]
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
  je _if48_exit
_if48_true:
  mov b, 0
  mov [csign], b
_for49_init:
  mov b, 1
  mov [pos], b
_for49_cond:
  mov b, [pos] ; pos
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
  je _for49_exit
_for49_block:
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for49_update:
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for49_cond
_for49_exit:
  jmp _if48_exit
_if48_exit:
  leave
  ret

swapab:
  push bp
  mov bp, sp
_for50_init:
  mov b, 0
  mov [swappos], b
_for50_cond:
  mov b, [swappos] ; swappos
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
  je _for50_exit
_for50_block:
  mov b, [anarr]
  mov d, b
  push d
  mov b, [swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, [swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [bnarr]
  push a
  mov d, b
  push d
  mov b, [swappos] ; swappos
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
  mov b, [bnarr]
  mov d, b
  push d
  mov b, [swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, [swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [bnarr]
  push a
  mov d, b
  push d
  mov b, [swappos] ; swappos
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
  mov b, [anarr]
  mov d, b
  push d
  mov b, [swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, [swappos] ; swappos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [bnarr]
  push a
  mov d, b
  push d
  mov b, [swappos] ; swappos
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
_for50_update:
  mov b, [swappos] ; swappos
  mov a, b
  inc b
  mov [swappos], b
  mov b, a
  jmp _for50_cond
_for50_exit:
  leave
  ret

checkabsabsize:
  push bp
  mov bp, sp
  mov b, 0
  mov [agtb], b
  mov b, 0
  mov [bgta], b
  mov b, 0
  mov [ageb], b
  mov b, 0
  mov [bgea], b
  mov b, 0
  mov [aeqb], b
  mov b, 0
  mov [aneqb], b
_for51_init:
  mov b, 12
  mov [psizepos], b
_for51_cond:
  mov b, [psizepos] ; psizepos
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
  je _for51_exit
_for51_block:
  mov b, [psizepos] ; psizepos
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  mov [sizepos], b
_if52_cond:
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, [sizepos] ; sizepos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [bnarr]
  push a
  mov d, b
  push d
  mov b, [sizepos] ; sizepos
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
  je _if52_exit
_if52_true:
  mov b, 1
  mov [aneqb], b
  mov b, 1
  mov [agtb], b
  mov b, 1
  mov [ageb], b
  jmp _if52_exit
_if52_exit:
_if53_cond:
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, [sizepos] ; sizepos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [bnarr]
  push a
  mov d, b
  push d
  mov b, [sizepos] ; sizepos
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
  je _if53_exit
_if53_true:
  mov b, 1
  mov [aneqb], b
  mov b, 1
  mov [bgta], b
  mov b, 1
  mov [bgea], b
  jmp _if53_exit
_if53_exit:
_if54_cond:
  mov b, [aneqb] ; aneqb
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
  je _if54_exit
_if54_true:
  jmp _for51_exit ; for break
  jmp _if54_exit
_if54_exit:
_for51_update:
  mov b, [psizepos] ; psizepos
  mov a, b
  dec b
  mov [psizepos], b
  mov b, a
  jmp _for51_cond
_for51_exit:
_if55_cond:
  mov b, [aneqb] ; aneqb
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
  je _if55_exit
_if55_true:
  mov b, 1
  mov [aeqb], b
  mov b, 1
  mov [ageb], b
  mov b, 1
  mov [bgea], b
  jmp _if55_exit
_if55_exit:
  leave
  ret

protoplus:
  push bp
  mov bp, sp
  mov b, 0
  mov [carry], b
_for56_init:
  mov b, 0
  mov [pos], b
_for56_cond:
  mov b, [pos] ; pos
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
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [bnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [carry] ; carry
  add a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
  mov b, 0
  mov [carry], b
_if57_cond:
  mov b, [cnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  je _if57_exit
_if57_true:
  mov b, 1
  mov [carry], b
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [cnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  jmp _if57_exit
_if57_exit:
_for56_update:
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for56_cond
_for56_exit:
  leave
  ret

protominus:
  push bp
  mov bp, sp
  mov b, 0
  mov [carry], b
_for58_init:
  mov b, 0
  mov [pos], b
_for58_cond:
  mov b, [pos] ; pos
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
  mov b, 0
  mov [nextcarry], b
_if59_cond:
  mov b, [bnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [carry] ; carry
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  je _if59_exit
_if59_true:
  mov b, [anarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov [nextcarry], b
  jmp _if59_exit
_if59_exit:
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [bnarr]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [carry] ; carry
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
  mov b, [nextcarry] ; nextcarry
  mov [carry], b
_for58_update:
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for58_cond
_for58_exit:
_if60_cond:
  mov b, [carry] ; carry
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
  je _if60_exit
_if60_true:
  mov b, 1
  mov [csign], b
  mov b, 0
  mov [carry], b
  jmp _if60_exit
_if60_exit:
  leave
  ret

pminus:
  push bp
  mov bp, sp
_for61_init:
  mov b, 0
  mov [divi], b
_for61_cond:
  mov b, [divi] ; divi
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
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for61_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for61_cond
_for61_exit:
  call checkabsabsize
_if62_cond:
  mov b, [asign] ; asign
  push a
  mov a, b
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  mov b, [aeqb] ; aeqb
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if62_exit
_if62_true:
  mov b, 0
  mov [csign], b
_for63_init:
  mov b, 1
  mov [pos], b
_for63_cond:
  mov b, [pos] ; pos
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
  je _for63_exit
_for63_block:
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for63_update:
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for63_cond
_for63_exit:
  jmp _if62_exit
_if62_exit:
_if64_cond:
  mov b, [asign] ; asign
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
  xor al, %00000001
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
  xor al, %00000001
  mov b, [ageb] ; ageb
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if64_exit
_if64_true:
  mov b, 0
  mov [csign], b
  call protominus
  jmp _if64_exit
_if64_exit:
_if65_cond:
  mov b, [asign] ; asign
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
  xor al, %00000001
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
  xor al, %00000001
  mov b, [bgta] ; bgta
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if65_exit
_if65_true:
  mov b, 1
  mov [csign], b
  call swapab
  call protominus
  jmp _if65_exit
_if65_exit:
_if66_cond:
  mov b, [asign] ; asign
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
  xor al, %00000001
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
  xor al, %00000001
  mov b, [ageb] ; ageb
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if66_exit
_if66_true:
  mov b, 1
  mov [csign], b
  call protominus
  jmp _if66_exit
_if66_exit:
_if67_cond:
  mov b, [asign] ; asign
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
  xor al, %00000001
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
  xor al, %00000001
  mov b, [bgta] ; bgta
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if67_exit
_if67_true:
  mov b, 0
  mov [csign], b
  call swapab
  call protominus
  jmp _if67_exit
_if67_exit:
_if68_cond:
  mov b, [asign] ; asign
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
  xor al, %00000001
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if68_exit
_if68_true:
  mov b, 0
  mov [csign], b
  call protoplus
  jmp _if68_exit
_if68_exit:
_if69_cond:
  mov b, [asign] ; asign
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
  xor al, %00000001
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if69_exit
_if69_true:
  mov b, 1
  mov [csign], b
  call protoplus
  jmp _if69_exit
_if69_exit:
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
_for70_init:
  mov b, 0
  mov [divi], b
_for70_cond:
  mov b, [divi] ; divi
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
  je _for70_exit
_for70_block:
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for70_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for70_cond
_for70_exit:
  call checkabsabsize
_if71_cond:
  mov b, [asign] ; asign
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
  xor al, %00000001
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
  xor al, %00000001
  mov b, [aeqb] ; aeqb
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if71_exit
_if71_true:
  mov b, 0
  mov [asign], b
  mov b, 0
  mov [bsign], b
  mov b, 0
  mov [csign], b
_for72_init:
  mov b, 1
  mov [pos], b
_for72_cond:
  mov b, [pos] ; pos
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
  je _for72_exit
_for72_block:
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for72_update:
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for72_cond
_for72_exit:
  leave
  ret
  jmp _if71_exit
_if71_exit:
_if73_cond:
  mov b, [asign] ; asign
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
  xor al, %00000001
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
  xor al, %00000001
  mov b, [aeqb] ; aeqb
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if73_exit
_if73_true:
  mov b, 0
  mov [asign], b
  mov b, 0
  mov [bsign], b
  mov b, 0
  mov [csign], b
_for74_init:
  mov b, 1
  mov [pos], b
_for74_cond:
  mov b, [pos] ; pos
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
  je _for74_exit
_for74_block:
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for74_update:
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for74_cond
_for74_exit:
  leave
  ret
  jmp _if73_exit
_if73_exit:
_if75_cond:
  mov b, [asign] ; asign
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
  xor al, %00000001
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if75_exit
_if75_true:
  mov b, 0
  mov [asign], b
  mov b, 0
  mov [bsign], b
  mov b, 0
  mov [csign], b
  call protoplus
  leave
  ret
  jmp _if75_exit
_if75_exit:
_if76_cond:
  mov b, [asign] ; asign
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
  xor al, %00000001
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if76_exit
_if76_true:
  mov b, 0
  mov [asign], b
  mov b, 0
  mov [bsign], b
  mov b, 1
  mov [csign], b
  call protoplus
  leave
  ret
  jmp _if76_exit
_if76_exit:
_if77_cond:
  mov b, [asign] ; asign
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
  xor al, %00000001
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
  xor al, %00000001
  mov b, [agtb] ; agtb
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if77_exit
_if77_true:
  mov b, 0
  mov [asign], b
  mov b, 0
  mov [bsign], b
  mov b, 0
  mov [csign], b
  call protominus
  leave
  ret
  jmp _if77_exit
_if77_exit:
_if78_cond:
  mov b, [asign] ; asign
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
  xor al, %00000001
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
  xor al, %00000001
  mov b, [bgta] ; bgta
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if78_exit
_if78_true:
  mov b, 0
  mov [asign], b
  mov b, 0
  mov [bsign], b
  mov b, 1
  mov [csign], b
  call swapab
  call protominus
  leave
  ret
  jmp _if78_exit
_if78_exit:
_if79_cond:
  mov b, [asign] ; asign
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
  xor al, %00000001
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
  xor al, %00000001
  mov b, [agtb] ; agtb
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if79_exit
_if79_true:
  mov b, 1
  mov [csign], b
  call swapab
  mov b, 0
  mov [asign], b
  mov b, 0
  mov [bsign], b
  call pminus
  leave
  ret
  jmp _if79_exit
_if79_exit:
_if80_cond:
  mov b, [asign] ; asign
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
  xor al, %00000001
  mov b, [bsign] ; bsign
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
  xor al, %00000001
  mov b, [bgta] ; bgta
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
  xor al, %00000001
  pop bl
  mov bh, 0
  pop a
  cmp b, 0
  je _if80_exit
_if80_true:
  mov b, 0
  mov [asign], b
  mov b, 0
  mov [bsign], b
  mov b, 0
  mov [csign], b
  call swapab
  call protominus
  leave
  ret
  jmp _if80_exit
_if80_exit:
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
_if81_cond:
  mov b, [mulres]
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
  je _if81_exit
_if81_true:
  mov b, [mulres]
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
  mov [toolarge], b
  mov b, [mulres]
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [mulres]
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
  mov b, [toolarge] ; toolarge
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
  jmp _if81_exit
_if81_exit:
  mov b, 0
  mov [normal], b
_while82_cond:
  mov b, [normal] ; normal
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
  je _while82_exit
_while82_block:
  mov b, 1
  mov [normal], b
_for83_init:
  mov b, 0
  mov [protopos], b
_for83_cond:
  mov b, [protopos] ; protopos
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
  je _for83_exit
_for83_block:
  mov b, 22
  push a
  mov a, b
  mov b, [protopos] ; protopos
  sub a, b
  mov b, a
  pop a
  mov [pos], b
_if84_cond:
  mov b, [mulres]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  je _if84_exit
_if84_true:
  mov b, 0
  mov [normal], b
  mov b, [mulres]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov [toolarge], b
  mov b, [mulres]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [mulres]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [toolarge] ; toolarge
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
  mov b, [mulres]
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [mulres]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [toolarge] ; toolarge
  add a, b
  mov b, a
  pop a
  pop d
  mov a, b
  mov [d], a
  jmp _if84_exit
_if84_exit:
_for83_update:
  mov b, [protopos] ; protopos
  mov a, b
  inc b
  mov [protopos], b
  mov b, a
  jmp _for83_cond
_for83_exit:
  jmp _while82_cond
_while82_exit:
_if85_cond:
  mov b, [mulres]
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
  je _if85_exit
_if85_true:
  mov b, [mulres]
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
  mov [toolarge], b
  mov b, [mulres]
  mov d, b
  push d
  mov b, 23
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [mulres]
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
  mov b, [toolarge] ; toolarge
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
  jmp _if85_exit
_if85_exit:
  leave
  ret

prototimes:
  push bp
  mov bp, sp
_for86_init:
  mov b, 0
  mov [divi], b
_for86_cond:
  mov b, [divi] ; divi
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
  je _for86_exit
_for86_block:
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for86_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for86_cond
_for86_exit:
_for87_init:
  mov b, 0
  mov [divi], b
_for87_cond:
  mov b, [divi] ; divi
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
  je _for87_exit
_for87_block:
  mov b, [mulres]
  mov d, b
  push d
  mov b, [divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for87_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for87_cond
_for87_exit:
_for88_init:
  mov b, 0
  mov [mulpos1], b
_for88_cond:
  mov b, [mulpos1] ; mulpos1
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
  je _for88_exit
_for88_block:
_for89_init:
  mov b, 0
  mov [mulpos2], b
_for89_cond:
  mov b, [mulpos2] ; mulpos2
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
  mov b, [mulres]
  mov d, b
  push d
  mov b, [mulpos1] ; mulpos1
  push a
  mov a, b
  mov b, [mulpos2] ; mulpos2
  add a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [mulres]
  push a
  mov d, b
  push d
  mov b, [mulpos1] ; mulpos1
  push a
  mov a, b
  mov b, [mulpos2] ; mulpos2
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
  mov b, [bnarr]
  push a
  mov d, b
  push d
  mov b, [mulpos2] ; mulpos2
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  push a
  mov a, b
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, [mulpos1] ; mulpos1
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
_for89_update:
  mov b, [mulpos2] ; mulpos2
  mov a, b
  inc b
  mov [mulpos2], b
  mov b, a
  jmp _for89_cond
_for89_exit:
  call normmulres
_for88_update:
  mov b, [mulpos1] ; mulpos1
  mov a, b
  inc b
  mov [mulpos1], b
  mov b, a
  jmp _for88_cond
_for88_exit:
  leave
  ret

protodividedby:
  push bp
  mov bp, sp
  mov b, 0
  mov [brshift], b
  mov b, 0
  mov [blshift], b
  mov b, 0
  mov [alshift], b
  mov b, 0
  mov [divcounter], b
  mov b, 0
  mov [segmentcounter], b
  mov b, 1
  mov [allzeroes], b
_for90_init:
  mov b, 0
  mov [divi], b
_for90_cond:
  mov b, [divi] ; divi
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
  je _for90_exit
_for90_block:
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
  mov b, [divres]
  mov d, b
  push d
  mov b, [divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_if91_cond:
  mov b, [bnarr]
  push a
  mov d, b
  push d
  mov b, [divi] ; divi
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
  je _if91_exit
_if91_true:
  mov b, 0
  mov [allzeroes], b
  jmp _if91_exit
_if91_exit:
_for90_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for90_cond
_for90_exit:
_if92_cond:
  mov b, [allzeroes] ; allzeroes
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
  je _if92_exit
_if92_true:
  leave
  ret
  jmp _if92_exit
_if92_exit:
_if93_cond:
  mov b, [bnarr]
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
  je _if93_exit
_if93_true:
_for94_init:
  mov b, 0
  mov [divi], b
_for94_cond:
  mov b, [divi] ; divi
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
  je _for94_exit
_for94_block:
  mov b, [bnarr]
  mov d, b
  push d
  mov b, [divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [bnarr]
  push a
  mov d, b
  push d
  mov b, [divi] ; divi
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
_for94_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for94_cond
_for94_exit:
  mov b, 1
  mov [brshift], b
  mov b, [bnarr]
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
  jmp _if93_exit
_if93_exit:
_while95_cond:
  mov b, [bnarr]
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
  je _while95_exit
_while95_block:
_for96_init:
  mov b, 0
  mov [divi], b
_for96_cond:
  mov b, [divi] ; divi
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
  je _for96_exit
_for96_block:
  mov b, [bnarr]
  mov d, b
  push d
  mov b, 10
  push a
  mov a, b
  mov b, [divi] ; divi
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [bnarr]
  push a
  mov d, b
  push d
  mov b, 10
  push a
  mov a, b
  mov b, [divi] ; divi
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
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for96_cond
_for96_exit:
  mov b, [bnarr]
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
  mov b, [blshift] ; blshift
  mov a, b
  inc b
  mov [blshift], b
  mov b, a
  jmp _while95_cond
_while95_exit:
  mov b, 1
  mov [allzeroes], b
_for97_init:
  mov b, 0
  mov [divi], b
_for97_cond:
  mov b, [divi] ; divi
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
_if98_cond:
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, [divi] ; divi
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
  je _if98_exit
_if98_true:
  mov b, 0
  mov [allzeroes], b
  jmp _if98_exit
_if98_exit:
_for97_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for97_cond
_for97_exit:
_if99_cond:
  mov b, [allzeroes] ; allzeroes
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
  mov b, [anarr]
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
  je _while100_exit
_while100_block:
_for101_init:
  mov b, 0
  mov [divi], b
_for101_cond:
  mov b, [divi] ; divi
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
  je _for101_exit
_for101_block:
  mov b, [anarr]
  mov d, b
  push d
  mov b, 11
  push a
  mov a, b
  mov b, [divi] ; divi
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, 11
  push a
  mov a, b
  mov b, [divi] ; divi
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
_for101_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for101_cond
_for101_exit:
  mov b, [anarr]
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
  mov b, [alshift] ; alshift
  mov a, b
  inc b
  mov [alshift], b
  mov b, a
  jmp _while100_cond
_while100_exit:
  mov b, 0
  mov [segmentcounter], b
  mov b, 0
  mov [divcounter], b
_while102_cond:
  mov b, [segmentcounter] ; segmentcounter
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
  je _while102_exit
_while102_block:
_while103_cond:
  mov b, [anarr]
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
  je _while103_exit
_while103_block:
  call pminus
  mov b, [divcounter] ; divcounter
  mov a, b
  inc b
  mov [divcounter], b
  mov b, a
_for104_init:
  mov b, 0
  mov [divi], b
_for104_cond:
  mov b, [divi] ; divi
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
  mov b, [anarr]
  mov d, b
  push d
  mov b, [divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [cnarr]
  push a
  mov d, b
  push d
  mov b, [divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for104_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for104_cond
_for104_exit:
  jmp _while103_cond
_while103_exit:
  mov b, [divres]
  mov d, b
  push d
  mov b, 11
  push a
  mov a, b
  mov b, [segmentcounter] ; segmentcounter
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [divcounter] ; divcounter
  pop d
  mov a, b
  mov [d], a
  mov b, 0
  mov [divcounter], b
  mov b, [segmentcounter] ; segmentcounter
  mov a, b
  inc b
  mov [segmentcounter], b
  mov b, a
  mov b, 1
  mov [allzeroes], b
_for105_init:
  mov b, 0
  mov [divi], b
_for105_cond:
  mov b, [divi] ; divi
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
  je _for105_exit
_for105_block:
_if106_cond:
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, [divi] ; divi
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
  je _if106_exit
_if106_true:
  mov b, 0
  mov [allzeroes], b
  jmp _if106_exit
_if106_exit:
_for105_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for105_cond
_for105_exit:
_if107_cond:
  mov b, [allzeroes] ; allzeroes
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
  je _if107_exit
_if107_true:
  leave
  ret
  jmp _if107_exit
_if107_exit:
_while108_cond:
  mov b, [anarr]
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
  je _while108_exit
_while108_block:
_for109_init:
  mov b, 0
  mov [divi], b
_for109_cond:
  mov b, [divi] ; divi
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
  je _for109_exit
_for109_block:
  mov b, [anarr]
  mov d, b
  push d
  mov b, 11
  push a
  mov a, b
  mov b, [divi] ; divi
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [anarr]
  push a
  mov d, b
  push d
  mov b, 11
  push a
  mov a, b
  mov b, [divi] ; divi
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
_for109_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for109_cond
_for109_exit:
  mov b, [anarr]
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
_if110_cond:
  mov b, [anarr]
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
  je _if110_exit
_if110_true:
  mov b, [divres]
  mov d, b
  push d
  mov b, 11
  push a
  mov a, b
  mov b, [segmentcounter] ; segmentcounter
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
  mov b, [anarr]
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
  mov b, [segmentcounter] ; segmentcounter
  mov a, b
  inc b
  mov [segmentcounter], b
  mov b, a
_if111_cond:
  mov b, [segmentcounter] ; segmentcounter
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
  je _if111_exit
_if111_true:
  leave
  ret
  jmp _if111_exit
_if111_exit:
  jmp _if110_exit
_if110_exit:
  jmp _while108_cond
_while108_exit:
  jmp _while102_cond
_while102_exit:
  leave
  ret

normdivres:
  push bp
  mov bp, sp
_for112_init:
  mov b, 12
  mov [divi], b
_for112_cond:
  mov b, [divi] ; divi
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
  je _for112_exit
_for112_block:
  mov b, [mulres]
  mov d, b
  push d
  mov b, [divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for112_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for112_cond
_for112_exit:
_for113_init:
  mov b, 0
  mov [divi], b
_for113_cond:
  mov b, [divi] ; divi
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
  je _for113_exit
_for113_block:
  mov b, [mulres]
  mov d, b
  push d
  mov b, [divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [divres]
  push a
  mov d, b
  push d
  mov b, [divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for113_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for113_cond
_for113_exit:
  call normmulres
_for114_init:
  mov b, 0
  mov [divshift], b
_for114_cond:
  mov b, [divshift] ; divshift
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
  je _for114_exit
_for114_block:
_for115_init:
  mov b, 0
  mov [divi], b
_for115_cond:
  mov b, [divi] ; divi
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
  je _for115_exit
_for115_block:
  mov b, [mulres]
  mov d, b
  push d
  mov b, 23
  push a
  mov a, b
  mov b, [divi] ; divi
  sub a, b
  mov b, a
  pop a
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [mulres]
  push a
  mov d, b
  push d
  mov b, 23
  push a
  mov a, b
  mov b, [divi] ; divi
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
_for115_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for115_cond
_for115_exit:
  mov b, [mulres]
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
_for114_update:
  mov b, [divshift] ; divshift
  mov a, b
  inc b
  mov [divshift], b
  mov b, a
  jmp _for114_cond
_for114_exit:
_for116_init:
  mov b, 0
  mov [divi], b
_for116_cond:
  mov b, [divi] ; divi
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
  je _for116_exit
_for116_block:
  mov b, [divres]
  mov d, b
  push d
  mov b, [divi] ; divi
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [mulres]
  push a
  mov d, b
  push d
  mov b, [divi] ; divi
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
_for116_update:
  mov b, [divi] ; divi
  mov a, b
  inc b
  mov [divi], b
  mov b, a
  jmp _for116_cond
_for116_exit:
  leave
  ret

times:
  push bp
  mov bp, sp
  call fixsignin
  mov b, 0
  mov [csign], b
_if117_cond:
  mov b, [asign] ; asign
  push a
  mov a, b
  mov b, [bsign] ; bsign
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if117_exit
_if117_true:
  mov b, 1
  mov [csign], b
  jmp _if117_exit
_if117_exit:
  mov b, 0
  mov [asign], b
  mov b, 0
  mov [bsign], b
  call prototimes
  mov b, 1
  mov [allzeroes], b
_for118_init:
  mov b, 15
  mov [pos], b
_for118_cond:
  mov b, [pos] ; pos
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
_if119_cond:
  mov b, [mulres]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
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
  je _if119_exit
_if119_true:
  mov b, 0
  mov [allzeroes], b
  jmp _if119_exit
_if119_exit:
_for118_update:
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for118_cond
_for118_exit:
_if120_cond:
  mov b, [allzeroes] ; allzeroes
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
  je _if120_exit
_if120_true:
_for121_init:
  mov b, 4
  mov [pos], b
_for121_cond:
  mov b, [pos] ; pos
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
  je _for121_exit
_for121_block:
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
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
  mov b, [mulres]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for121_update:
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for121_cond
_for121_exit:
  jmp _if120_exit
_if120_exit:
_if122_cond:
  mov b, [cnarr]
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
  je _if122_exit
_if122_true:
_for123_init:
  mov b, 0
  mov [pos], b
_for123_cond:
  mov b, [pos] ; pos
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
  je _for123_exit
_for123_block:
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
_for123_update:
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for123_cond
_for123_exit:
  jmp _if122_exit
_if122_exit:
  call fixcsizezero
  call fixsignout
  leave
  ret

dividedby:
  push bp
  mov bp, sp
  call fixsignin
  mov b, 0
  mov [csign], b
_if124_cond:
  mov b, [asign] ; asign
  push a
  mov a, b
  mov b, [bsign] ; bsign
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _if124_exit
_if124_true:
  mov b, 1
  mov [csign], b
  jmp _if124_exit
_if124_exit:
  mov b, 0
  mov [asign], b
  mov b, 0
  mov [bsign], b
  mov b, [csign] ; csign
  mov [bkpcsign], b
  call protodividedby
  call normdivres
_if125_cond:
  mov b, [blshift] ; blshift
  push a
  mov a, b
  mov b, 6
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [alshift] ; alshift
  push a
  mov a, b
  mov b, [brshift] ; brshift
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
  je _if125_exit
_if125_true:
  mov b, [blshift] ; blshift
  push a
  mov a, b
  mov b, 6
  add a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [alshift] ; alshift
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [brshift] ; brshift
  sub a, b
  mov b, a
  pop a
  mov [blshift], b
  mov b, 12
  push a
  mov a, b
  mov b, [blshift] ; blshift
  sub a, b
  mov b, a
  pop a
  mov [divi], b
_for126_init:
  mov b, 0
  mov [pos], b
_for126_cond:
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [blshift] ; blshift
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  shr al
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for126_exit
_for126_block:
_if127_cond:
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [divi] ; divi
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
  je _if127_exit
_if127_true:
  mov b, [cnarr]
  mov d, b
  push d
  mov b, [pos] ; pos
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [divres]
  push a
  mov d, b
  push d
  mov b, [pos] ; pos
  push a
  mov a, b
  mov b, [divi] ; divi
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
  jmp _if127_exit
_if127_exit:
_for126_update:
  mov b, [pos] ; pos
  mov a, b
  inc b
  mov [pos], b
  mov b, a
  jmp _for126_cond
_for126_exit:
  jmp _if125_exit
_if125_exit:
  mov b, [bkpcsign] ; bkpcsign
  mov [csign], b
  call fixcsizezero
  call fixsignout
  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
ss_data: .db "\n", 0
ss: .dw ss_data
sp_data: .db " ", 0
sp: .dw sp_data
ionum_data: 
.dw 0,0,0,0,0,0,
.fill 0, 0
ionum: .dw ionum_data
ionr: .dw 0
ioshift: .dw 0
datum_data: 
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.fill 36, 0
datum: .dw datum_data
datumpos: .dw 0
anarr_data: 
.dw 0,0,0,0,0,0,0,0,0,0,0,0,
.fill 0, 0
anarr: .dw anarr_data
bnarr_data: 
.dw 0,0,0,0,0,0,0,0,0,0,0,0,
.fill 0, 0
bnarr: .dw bnarr_data
anarrbkp_data: 
.dw 0,0,0,0,0,0,0,0,0,0,0,0,
.fill 0, 0
anarrbkp: .dw anarrbkp_data
bnarrbkp_data: 
.dw 0,0,0,0,0,0,0,0,0,0,0,0,
.fill 0, 0
bnarrbkp: .dw bnarrbkp_data
cnarr_data: 
.dw 0,0,0,0,0,0,0,0,0,0,0,0,
.fill 0, 0
cnarr: .dw cnarr_data
mulres_data: 
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.fill 0, 0
mulres: .dw mulres_data
divres_data: 
.dw 0,0,0,0,0,0,0,0,0,0,0,0,
.fill 0, 0
divres: .dw divres_data
asign: .dw 0
bsign: .dw 0
csign: .dw 0
protopos: .dw 0
pos: .dw 0
carry: .dw 0
nextcarry: .dw 0
agtb: .dw 0
bgta: .dw 0
aeqb: .dw 0
aneqb: .dw 0
ageb: .dw 0
bgea: .dw 0
eqflag: .dw 0
sizepos: .dw 0
psizepos: .dw 0
swappos: .dw 0
swaptmp: .dw 0
toolarge: .dw 0
normal: .dw 0
mulpos1: .dw 0
mulpos2: .dw 0
mulpos3: .dw 0
brshift: .dw 0
blshift: .dw 0
alshift: .dw 0
divcounter: .dw 0
segmentcounter: .dw 0
divi: .dw 0
allzeroes: .dw 0
bkpcsign: .dw 0
divshift: .dw 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
