; --- FILENAME: life.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; n
  mov b, _string_0
  swp b
  push b
  call print
  add sp, 2
  call getn
  push a
  mov a, b
  mov [bp + -3], a ; n
  pop a
_for1_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for1_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, [bp + -3] ; n
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

; --- BEGIN INLINE ASM BLOCK
  mov d, s_telnet_clear
  call puts
; --- END INLINE ASM BLOCK

  mov b, _string_1
  swp b
  push b
  call print
  add sp, 2

; --- BEGIN INLINE ASM BLOCK
  mov a, [bp + -1]
  call print_u16d
  mov ah, $0A
  call putchar
; --- END INLINE ASM BLOCK

  mov b, _string_2
  swp b
  push b
  call print
  add sp, 2

; --- BEGIN INLINE ASM BLOCK
  mov a, sp
  call print_u16d
  mov ah, $0A
  call putchar
; --- END INLINE ASM BLOCK

  call print_game
  call update_game
_for1_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for1_cond
_for1_exit:
  mov b, 0
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
getn:
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
print_game:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
_for2_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for2_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 40
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
  je _for2_exit
_for2_block:
_for3_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for3_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 40
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
  je _for3_exit
_for3_block:
_if4_cond:
  mov b, [curr_state]
  push a
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 80
  mul a, b
  add d, b
  mov b, [bp + -3] ; j
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  cmp b, 0
  je _if4_else
_if4_true:
  mov b, _string_3
  swp b
  push b
  call print
  add sp, 2
  jmp _if4_exit
_if4_else:
  mov b, _string_4
  swp b
  push b
  call print
  add sp, 2
_if4_exit:
_for3_update:
  mov b, [bp + -3] ; j
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
  jmp _for3_cond
_for3_exit:
  mov b, _string_5
  swp b
  push b
  call print
  add sp, 2
_for2_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for2_cond
_for2_exit:
  leave
  ret
update_game:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
  sub sp, 2 ; ni
  sub sp, 2 ; nj
  sub sp, 2 ; count
_for5_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for5_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 40
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
  je _for5_exit
_for5_block:
_for6_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for6_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 40
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
  je _for6_exit
_for6_block:
  mov b, [next_state]
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 80
  mul a, b
  add d, b
  mov b, [bp + -3] ; j
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [curr_state]
  push a
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 80
  mul a, b
  add d, b
  mov b, [bp + -3] ; j
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for6_update:
  mov b, [bp + -3] ; j
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
  jmp _for6_cond
_for6_exit:
_for5_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for5_cond
_for5_exit:
_for7_init:
  mov b, 1
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for7_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 40
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
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
  je _for7_exit
_for7_block:
_for8_init:
  mov b, 1
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for8_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 40
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
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
  je _for8_exit
_for8_block:
  mov b, 0
  push a
  mov a, b
  mov [bp + -9], a ; count
  pop a
_for9_init:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  mov a, b
  mov [bp + -5], a ; ni
  pop a
_for9_cond:
  mov b, [bp + -5] ; ni
  push a
  mov a, b
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
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
  je _for9_exit
_for9_block:
_for10_init:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  mov a, b
  mov [bp + -7], a ; nj
  pop a
_for10_cond:
  mov b, [bp + -7] ; nj
  push a
  mov a, b
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 1
  add a, b
  mov b, a
  pop a
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
  je _for10_exit
_for10_block:
_if11_cond:
  mov b, [bp + -5] ; ni
  push a
  mov a, b
  mov b, 40
  cmp a, b
  lodflgs
  and al, %00000010 ; <
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
  mov b, [bp + -7] ; nj
  push a
  mov a, b
  mov b, 40
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
  push al
  cmp b, 0
  lodflgs
  not al
  and al, %00000001 ; transform logical AND condition result into a single bit
  pop bl
  and al, bl
  mov bl, al
  mov bh, 0
  pop a
  cmp b, 0
  je _if11_exit
_if11_true:
_if12_cond:
  mov b, [bp + -5] ; ni
  push a
  mov a, b
  mov b, [bp + -1] ; i
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
  mov b, [bp + -7] ; nj
  push a
  mov a, b
  mov b, [bp + -3] ; j
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
  or a, b
  mov b, a
  pop a
  cmp b, 0
  je _if12_exit
_if12_true:
  mov b, [bp + -9] ; count
  push a
  mov a, b
  mov b, [curr_state]
  push a
  mov d, b
  mov b, [bp + -5] ; ni
  mov a, 80
  mul a, b
  add d, b
  mov b, [bp + -7] ; nj
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  add a, b
  mov b, a
  mov a, b
  mov [bp + -9], a ; count
  pop a
  jmp _if12_exit
_if12_exit:
  jmp _if11_exit
_if11_exit:
_for10_update:
  mov b, [bp + -7] ; nj
  inc b
  push a
  mov a, b
  mov [bp + -7], a ; nj
  pop a
  jmp _for10_cond
_for10_exit:
_for9_update:
  mov b, [bp + -5] ; ni
  inc b
  push a
  mov a, b
  mov [bp + -5], a ; ni
  pop a
  jmp _for9_cond
_for9_exit:
_if13_cond:
  mov b, [curr_state]
  push a
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 80
  mul a, b
  add d, b
  mov b, [bp + -3] ; j
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  cmp b, 0
  je _if13_else
_if13_true:
_if14_cond:
  mov b, [bp + -9] ; count
  push a
  mov a, b
  mov b, 2
  cmp a, b
  lodflgs
  and al, %00000010 ; <
  cmp al, 0
  lodflgs
  not al
  and al, %00000001 ; transform relational logical condition result into a single bit
  mov ah, 0
  mov b, a
  mov a, b
  mov b, [bp + -9] ; count
  push a
  mov a, b
  mov b, 3
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
  je _if14_exit
_if14_true:
  mov b, [next_state]
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 80
  mul a, b
  add d, b
  mov b, [bp + -3] ; j
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov a, b
  mov [d], a
  jmp _if14_exit
_if14_exit:
  jmp _if13_exit
_if13_else:
_if15_cond:
  mov b, [bp + -9] ; count
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
  pop a
  cmp b, 0
  je _if15_exit
_if15_true:
  mov b, [next_state]
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 80
  mul a, b
  add d, b
  mov b, [bp + -3] ; j
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, 1
  pop d
  mov a, b
  mov [d], a
  jmp _if15_exit
_if15_exit:
_if13_exit:
_for8_update:
  mov b, [bp + -3] ; j
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
  jmp _for8_cond
_for8_exit:
_for7_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for7_cond
_for7_exit:
_for16_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_for16_cond:
  mov b, [bp + -1] ; i
  push a
  mov a, b
  mov b, 40
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
  je _for16_exit
_for16_block:
_for17_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
_for17_cond:
  mov b, [bp + -3] ; j
  push a
  mov a, b
  mov b, 40
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
  je _for17_exit
_for17_block:
  mov b, [curr_state]
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 80
  mul a, b
  add d, b
  mov b, [bp + -3] ; j
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [next_state]
  push a
  mov d, b
  mov b, [bp + -1] ; i
  mov a, 80
  mul a, b
  add d, b
  mov b, [bp + -3] ; j
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  pop d
  mov a, b
  mov [d], a
_for17_update:
  mov b, [bp + -3] ; j
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
  jmp _for17_cond
_for17_exit:
_for16_update:
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  jmp _for16_cond
_for16_exit:
  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
curr_state_data: 
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,
.dw 0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,
.dw 0,0,0,1,0,0,0,1,0,1,1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
.fill 1600, 0
curr_state: .dw curr_state_data
next_state_data: .fill 3200, 0
next_state: .dw next_state_data
_string_0: .db "Generations: ", 0
_string_1: .db "Generation: ", 0
_string_2: .db "SP: ", 0
_string_3: .db "@ ", 0
_string_4: .db ". ", 0
_string_5: .db "\n", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
