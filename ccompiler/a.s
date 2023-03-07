; --- FILENAME: polish.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; type
  sub sp, 2 ; op2
  sub sp, 100 ; s
_while1_cond:
  lea d, [bp + -103] ; s_data
  mov b, d
  swp b
  push b
  call getop
  add sp, 2
  push a
  mov a, b
  mov [bp + -1], a ; type
  pop a
  push a
  mov a, b
  mov b, '$'
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
_switch2_expr:
  mov b, [bp + -1] ; type
_switch2_comparisons:
  cmp b, 999
  je _switch2_case0
  cmp bl, '+'
  je _switch2_case1
  cmp bl, '*'
  je _switch2_case2
  cmp bl, '-'
  je _switch2_case3
  cmp bl, '/'
  je _switch2_case4
  cmp b, 10
  je _switch2_case5
  jmp _switch2_default
_switch2_case0:
  lea d, [bp + -103] ; s_data
  mov b, d
  swp b
  push b
  call _atoi
  add sp, 2
  swp b
  push b
  call _push
  add sp, 2
  jmp _switch2_exit ; case break
_switch2_case1:
  call _pop
  push a
  mov a, b
  call _pop
  add a, b
  mov b, a
  pop a
  swp b
  push b
  call _push
  add sp, 2
  jmp _switch2_exit ; case break
_switch2_case2:
  call _pop
  push a
  mov a, b
  call _pop
  mul a, b
  pop a
  swp b
  push b
  call _push
  add sp, 2
  jmp _switch2_exit ; case break
_switch2_case3:
  call _pop
  push a
  mov a, b
  mov [bp + -3], a ; op2
  pop a
  call _pop
  push a
  mov a, b
  mov b, [bp + -3] ; op2
  sub a, b
  mov b, a
  pop a
  swp b
  push b
  call _push
  add sp, 2
  jmp _switch2_exit ; case break
_switch2_case4:
  call _pop
  push a
  mov a, b
  mov [bp + -3], a ; op2
  pop a
_if3_cond:
  mov b, [bp + -3] ; op2
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
  je _if3_else
_if3_true:
  call _pop
  push a
  mov a, b
  mov b, [bp + -3] ; op2
  div a, b
  mov g, a
  mov a, b
  mov b, g
  pop a
  swp b
  push b
  call _push
  add sp, 2
  jmp _if3_exit
_if3_else:
  mov b, _string_0 ; "Divide by zero error\n"
  swp b
  push b
  call print
  add sp, 2
_if3_exit:
  jmp _switch2_exit ; case break
_switch2_case5:
  call _pop
  swp b
  push b
  call printn
  add sp, 2
  mov b, _string_1 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  jmp _switch2_exit ; case break
_switch2_default:
  mov b, _string_2 ; "Unknown input: "
  swp b
  push b
  call print
  add sp, 2
  lea d, [bp + -103] ; s_data
  mov b, d
  swp b
  push b
  call print
  add sp, 2
  mov b, _string_1 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  jmp _switch2_exit ; case break
_switch2_exit:
  jmp _while1_cond
_while1_exit:
  mov b, 0
  leave
  syscall sys_terminate_proc

_atoi:
  push bp
  mov bp, sp
  sub sp, 2 ; n

; --- BEGIN INLINE ASM BLOCK
  lea d, [bp + 5]
  mov a, [d]
  mov d, a
  call strtoint
  mov [bp + -1], a
; --- END INLINE ASM BLOCK

  mov b, [bp + -1] ; n
  leave
  ret

_push:
  push bp
  mov bp, sp
_if4_cond:
  mov b, [_sp] ; _sp
  push a
  mov a, b
  mov b, 100
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
  je _if4_else
_if4_true:
  mov b, [val]
  mov d, b
  push d
  mov b, [_sp] ; _sp
  pop d
  mov a, 2
  mul a, b
  add d, b
  push d
  mov b, [bp + 5] ; f
  pop d
  mov a, b
  mov [d], a
  mov b, [_sp] ; _sp
  inc b
  mov [_sp], b
  jmp _if4_exit
_if4_else:
  mov b, _string_3 ; "Error: stack full, can't _push: "
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + 5] ; f
  swp b
  push b
  call printn
  add sp, 2
_if4_exit:
  leave
  ret

_pop:
  push bp
  mov bp, sp
  mov b, _string_4 ; "POP"
  swp b
  push b
  call print
  add sp, 2
_if5_cond:
  mov b, [_sp] ; _sp
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
  je _if5_else
_if5_true:
  mov b, [_sp] ; _sp
  dec b
  mov [_sp], b
  mov b, [val]
  push a
  mov d, b
  push d
  mov b, [_sp] ; _sp
  pop d
  mov a, 2
  mul a, b
  add d, b
  mov b, [d]
  pop a
  leave
  ret
  jmp _if5_exit
_if5_else:
  mov b, _string_5 ; "Error: stack empty.\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 0
  leave
  ret
_if5_exit:

getop:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 1 ; c
_while6_cond:
  lea d, [bp + 5] ; s
  mov b, [d]
  mov d, b
  push d
  mov b, 0
  pop d
  mov a, 1
  mul a, b
  add d, b
  push d
  call getch
  push al
  mov al, bl
  mov [bp + -2], al ; c
  pop al
  pop d
  mov al, bl
  mov [d], al
  push a
  mov a, b
  mov b, ' '
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
  je _while6_exit
_while6_block:
  jmp _while6_cond
_while6_exit:
  lea d, [bp + 5] ; s
  mov b, [d]
  mov d, b
  push d
  mov b, 1
  pop d
  mov a, 1
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov al, bl
  mov [d], al
_if7_cond:
  mov bl, [bp + -2] ; c
  mov bh, 0
  push bl
  call isdigit
  add sp, 1
  push al
  cmp b, 0
  lodflgs
  and al, %00000001 ; transform logical not condition result into a single bit
  mov bl, al
  mov bh, 0
  pop al
  cmp b, 0
  je _if7_exit
_if7_true:
  mov bl, [bp + -2] ; c
  mov bh, 0
  leave
  ret
  jmp _if7_exit
_if7_exit:
  mov b, 0
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
_if8_cond:
  mov bl, [bp + -2] ; c
  mov bh, 0
  push bl
  call isdigit
  add sp, 1
  cmp b, 0
  je _if8_exit
_if8_true:
_while9_cond:
  lea d, [bp + 5] ; s
  mov b, [d]
  mov d, b
  push d
  mov b, [bp + -1] ; i
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  pop d
  mov a, 1
  mul a, b
  add d, b
  push d
  call getch
  push al
  mov al, bl
  mov [bp + -2], al ; c
  pop al
  pop d
  mov al, bl
  mov [d], al
  push bl
  call isdigit
  add sp, 1
  cmp b, 0
  je _while9_exit
_while9_block:
  jmp _while9_cond
_while9_exit:
  jmp _if8_exit
_if8_exit:
  lea d, [bp + 5] ; s
  mov b, [d]
  mov d, b
  push d
  mov b, [bp + -1] ; i
  pop d
  mov a, 1
  mul a, b
  add d, b
  push d
  mov b, 0
  pop d
  mov al, bl
  mov [d], al
_if10_cond:
  mov bl, [bp + -2] ; c
  mov bh, 0
  push a
  mov a, b
  mov b, '$'
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
  je _if10_exit
_if10_true:
  mov bl, [bp + -2] ; c
  mov bh, 0
  push bl
  call ungetch
  add sp, 1
  jmp _if10_exit
_if10_exit:
  mov b, 999
  leave
  ret

getch:
  push bp
  mov bp, sp
_if11_cond:
  mov b, [bufp] ; bufp
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
  je _if11_else
_if11_true:
  mov b, [bufp] ; bufp
  dec b
  mov [bufp], b
  mov b, [buf]
  push a
  mov d, b
  push d
  mov b, [bufp] ; bufp
  pop d
  mov a, 1
  mul a, b
  add d, b
  mov bl, [d]
  mov bh, 0
  pop a
  leave
  ret
  jmp _if11_exit
_if11_else:
  call _getchar
  leave
  ret
_if11_exit:

ungetch:
  push bp
  mov bp, sp
_if12_cond:
  mov b, [bufp] ; bufp
  push a
  mov a, b
  mov b, 100
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
  pop a
  cmp b, 0
  je _if12_else
_if12_true:
  mov b, _string_6 ; "Error: too many characters.\n"
  swp b
  push b
  call print
  add sp, 2
  jmp _if12_exit
_if12_else:
  mov b, [buf]
  mov d, b
  push d
  mov b, [bufp] ; bufp
  pop d
  mov a, 1
  mul a, b
  add d, b
  push d
  mov bl, [bp + 5] ; c
  mov bh, 0
  pop d
  mov al, bl
  mov [d], al
  mov b, [bufp] ; bufp
  inc b
  mov [bufp], b
_if12_exit:
  leave
  ret

isdigit:
  push bp
  mov bp, sp
_if13_cond:
  mov bl, [bp + 5] ; c
  mov bh, 0
  push a
  mov a, b
  mov b, '0'
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
  pop a
  push a
  mov a, b
  cmp a, 0
  lodflgs
  not al
  and al, %00000001 ; transform logical AND condition result into a single bit
  mov bl, [bp + 5] ; c
  mov bh, 0
  push a
  mov a, b
  mov b, '9'
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
  je _if13_else
_if13_true:
  mov b, 1
  leave
  ret
  jmp _if13_exit
_if13_else:
  mov b, 0
  leave
  ret
_if13_exit:

_getchar:
  push bp
  mov bp, sp
  sub sp, 1 ; c

; --- BEGIN INLINE ASM BLOCK
  call getchar
  mov al, ah
  mov [bp + 0], al
; --- END INLINE ASM BLOCK

  mov bl, [bp + 0] ; c
  mov bh, 0
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
  push b
  mov b, [bp + -1] ; m
  pop d
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
_sp: .dw 0
val_data: .fill 200, 0
val: .dw val_data
buf_data: .fill 100, 0
buf: .dw buf_data
bufp: .dw 0
_string_0: .db "Divide by zero error\n", 0
_string_1: .db "\n", 0
_string_2: .db "Unknown input: ", 0
_string_3: .db "Error: stack full, can't _push: ", 0
_string_4: .db "POP", 0
_string_5: .db "Error: stack empty.\n", 0
_string_6: .db "Error: too many characters.\n", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
