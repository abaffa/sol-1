; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  sub sp, 2 ; a
  sub sp, 2 ; i
  sub sp, 2 ; j
  lea d, [bp + -1]
  mov b, d
  swp b
  push b
  call scann
  add sp, 2
_switch1_expr:
  mov b, [bp + -1] ; a
_switch1_comparisons:
  cmp b, 1
  je _switch1_case0
  cmp b, 2
  je _switch1_case1
_switch1_default:
_switch2_expr:
  mov b, [bp + -1] ; a
_switch2_comparisons:
  cmp b, 1
  je _switch2_case0
  cmp b, 2
  je _switch2_case1
_switch2_default:
  mov b, 99
  swp b
  push b
  call printn
  add sp, 2
  jmp _switch2_exit
_switch2_case0:
  mov b, 1
  swp b
  push b
  call printn
  add sp, 2
  jmp _switch2_exit ; case break
_switch2_case1:
_for3_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; i
  pop a
_for3_cond:
  mov b, [bp + -3] ; i
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
  je _for3_exit
_for3_block:
_for4_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -5], a ; j
  pop a
_for4_cond:
  mov b, [bp + -5] ; j
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
  je _for4_exit
_for4_block:
  mov b, 2
  swp b
  push b
  call printn
  add sp, 2
_for4_update:
  mov b, [bp + -5] ; j
  inc b
  push a
  mov a, b
  mov [bp + -5], a ; j
  pop a
  jmp _for4_cond
_for4_exit:
_for3_update:
  mov b, [bp + -3] ; i
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; i
  pop a
  jmp _for3_cond
_for3_exit:
  jmp _switch2_exit ; case break
_switch2_exit:
  jmp _switch1_exit
_switch1_case0:
  mov b, 1
  swp b
  push b
  call printn
  add sp, 2
  jmp _switch1_exit ; case break
_switch1_case1:
_for5_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -3], a ; i
  pop a
_for5_cond:
  mov b, [bp + -3] ; i
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
  je _for5_exit
_for5_block:
_for6_init:
  mov b, 0
  push a
  mov a, b
  mov [bp + -5], a ; j
  pop a
_for6_cond:
  mov b, [bp + -5] ; j
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
  je _for6_exit
_for6_block:
  mov b, 2
  swp b
  push b
  call printn
  add sp, 2
_for6_update:
  mov b, [bp + -5] ; j
  inc b
  push a
  mov a, b
  mov [bp + -5], a ; j
  pop a
  jmp _for6_cond
_for6_exit:
_for5_update:
  mov b, [bp + -3] ; i
  inc b
  push a
  mov a, b
  mov [bp + -3], a ; i
  pop a
  jmp _for5_cond
_for5_exit:
  jmp _switch1_exit ; case break
_switch1_exit:
  mov b, 0
  leave
  syscall sys_terminate_proc
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
s_data: 
.dw 1, 2, _string_0, 
.fill 26, 0
s: .dw s_data
i_data: 
.dw 22, 
.fill 0, 0
i: .dw i_data
_string_0: .db "Helo", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
