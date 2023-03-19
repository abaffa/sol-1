; --- FILENAME: rsa.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; p
  sub sp, 2 ; q
  sub sp, 2 ; n
  sub sp, 2 ; phi
  sub sp, 2 ; e
  sub sp, 2 ; d
  mov b, 61
  push a
  mov a, b
  mov [bp + -1], a ; p
  pop a
  mov b, 53
  push a
  mov a, b
  mov [bp + -3], a ; q
  pop a
  mov b, [bp + -1] ; p
  push a
  mov a, b
  mov b, [bp + -3] ; q
  mul a, b
  pop a
  push a
  mov a, b
  mov [bp + -5], a ; n
  pop a
  mov b, [bp + -1] ; p
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  push a
  mov a, b
  mov b, [bp + -3] ; q
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  mul a, b
  pop a
  push a
  mov a, b
  mov [bp + -7], a ; phi
  pop a
  mov b, [bp + -7] ; phi
  swp b
  push b
  call find_e
  add sp, 2
  push a
  mov a, b
  mov [bp + -9], a ; e
  pop a
  mov b, [bp + -9] ; e
  swp b
  push b
  mov b, [bp + -7] ; phi
  swp b
  push b
  call find_d
  add sp, 4
  push a
  mov a, b
  mov [bp + -11], a ; d
  pop a
  sub sp, 2 ; exp
  sub sp, 2 ; base
  sub sp, 2 ; mod
  sub sp, 2 ; result
  mov b, [bp + -9] ; e
  push a
  mov a, b
  mov [bp + -13], a ; exp
  pop a
  mov b, $48
  push a
  mov a, b
  mov [bp + -15], a ; base
  pop a
  mov b, [bp + -5] ; n
  push a
  mov a, b
  mov [bp + -17], a ; mod
  pop a
  mov b, 1
  push a
  mov a, b
  mov [bp + -19], a ; result
  pop a
_while1_cond:
  mov b, [bp + -13] ; exp
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  mov bl, al
  mov g, a
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl
  mov b, g
  and bl, %00000001
  or al, bl
  xor al, %00000001 ; > (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while1_exit
_while1_block:
_if2_cond:
  mov b, [bp + -13] ; exp
  push a
  mov a, b
  mov b, 1
  and a, b
  mov b, a
  pop a
  cmp b, 0
  je _if2_exit
_if2_true:
  mov b, [bp + -19] ; result
  swp b
  push b
  call print_num
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + -15] ; base
  swp b
  push b
  call print_num
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + -17] ; mod
  swp b
  push b
  call print_num
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + -19] ; result
  push a
  mov a, b
  mov b, [bp + -15] ; base
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [bp + -17] ; mod
  div a, b
  pop a
  push a
  mov a, b
  mov [bp + -19], a ; result
  pop a
  mov b, [bp + -19] ; result
  swp b
  push b
  call print_num
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  jmp _if2_exit
_if2_exit:
  mov b, [bp + -13] ; exp
  push a
  mov a, b
  mov b, 1
  push c
  mov c, b
  mov b, a
  ashr b, cl
  pop c
  pop a
  push a
  mov a, b
  mov [bp + -13], a ; exp
  pop a
  mov b, [bp + -15] ; base
  push a
  mov a, b
  mov b, [bp + -15] ; base
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [bp + -17] ; mod
  div a, b
  pop a
  push a
  mov a, b
  mov [bp + -15], a ; base
  pop a
  jmp _while1_cond
_while1_exit:
  mov b, [bp + -19] ; result
  swp b
  push b
  call print_num
  add sp, 2
  mov b, 0
  leave
  syscall sys_terminate_proc

_gets:
  push bp
  mov bp, sp

; --- BEGIN INLINE ASM BLOCK
  mov a, [bp + 5]
  mov d, a
  call gets
; --- END INLINE ASM BLOCK

  leave
  ret

gcd:
  push bp
  mov bp, sp
_if3_cond:
  mov b, [bp + 5] ; b
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
  je _if3_exit
_if3_true:
  mov b, [bp + 7] ; a
  leave
  ret
  jmp _if3_exit
_if3_exit:
  mov b, [bp + 5] ; b
  swp b
  push b
  mov b, [bp + 7] ; a
  push a
  mov a, b
  mov b, [bp + 5] ; b
  div a, b
  pop a
  swp b
  push b
  call gcd
  add sp, 4
  leave
  ret

mod_exp:
  push bp
  mov bp, sp
  sub sp, 2 ; result
  mov b, 1
  push a
  mov a, b
  mov [bp + -1], a ; result
  pop a
_while4_cond:
  mov b, [bp + 7] ; exp
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  mov bl, al
  mov g, a
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl
  mov b, g
  and bl, %00000001
  or al, bl
  xor al, %00000001 ; > (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while4_exit
_while4_block:
_if5_cond:
  mov b, [bp + 7] ; exp
  push a
  mov a, b
  mov b, 1
  and a, b
  mov b, a
  pop a
  cmp b, 0
  je _if5_exit
_if5_true:
  mov b, [bp + -1] ; result
  push a
  mov a, b
  mov b, [bp + 9] ; base
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [bp + 5] ; mod
  div a, b
  pop a
  push a
  mov a, b
  mov [bp + -1], a ; result
  pop a
  jmp _if5_exit
_if5_exit:
  mov b, [bp + 7] ; exp
  push a
  mov a, b
  mov b, 1
  push c
  mov c, b
  mov b, a
  ashr b, cl
  pop c
  pop a
  push a
  mov a, b
  mov [bp + 7], a ; exp
  pop a
  mov b, [bp + 9] ; base
  push a
  mov a, b
  mov b, [bp + 9] ; base
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [bp + 5] ; mod
  div a, b
  pop a
  push a
  mov a, b
  mov [bp + 9], a ; base
  pop a
  jmp _while4_cond
_while4_exit:
  mov b, [bp + -1] ; result
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

print_num:
  push bp
  mov bp, sp
  sub sp, 5 ; digits
  sub sp, 2 ; i
  mov b, 0
  push a
  mov a, b
  mov [bp + -6], a ; i
  pop a
_if6_cond:
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
  je _if6_exit
_if6_true:
  mov b, $30
  push bl
  call _putchar
  add sp, 1
  leave
  ret
  jmp _if6_exit
_if6_exit:
_while7_cond:
  mov b, [bp + 5] ; num
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  mov bl, al
  mov g, a
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl
  mov b, g
  and bl, %00000001
  or al, bl
  xor al, %00000001 ; > (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while7_exit
_while7_block:
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
  mov b, $30
  push a
  mov a, b
  mov b, [bp + 5] ; num
  push a
  mov a, b
  mov b, 10
  div a, b
  pop a
  add b, a
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
  jmp _while7_cond
_while7_exit:
_while8_cond:
  mov b, [bp + -6] ; i
  push a
  mov a, b
  mov b, 0
  cmp a, b
  lodflgs
  mov bl, al
  mov g, a
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl
  mov b, g
  and bl, %00000001
  or al, bl
  xor al, %00000001 ; > (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _while8_exit
_while8_block:
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
  jmp _while8_cond
_while8_exit:
  leave
  ret

find_e:
  push bp
  mov bp, sp
  sub sp, 2 ; e
_for9_init:
  mov b, 2
  push a
  mov a, b
  mov [bp + -1], a ; e
  pop a
_for9_cond:
  mov b, [bp + -1] ; e
  push a
  mov a, b
  mov b, [bp + 5] ; phi
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl ; < (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for9_exit
_for9_block:
_if10_cond:
  mov b, [bp + -1] ; e
  swp b
  push b
  mov b, [bp + 5] ; phi
  swp b
  push b
  call gcd
  add sp, 4
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
  je _if10_exit
_if10_true:
  mov b, [bp + -1] ; e
  leave
  ret
  jmp _if10_exit
_if10_exit:
_for9_update:
  mov b, [bp + -1] ; e
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; e
  pop a
  mov b, a
  pop a
  jmp _for9_cond
_for9_exit:
  mov b, 0
  leave
  ret

find_d:
  push bp
  mov bp, sp
  sub sp, 2 ; d
_for11_init:
  mov b, 2
  push a
  mov a, b
  mov [bp + -1], a ; d
  pop a
_for11_cond:
  mov b, [bp + -1] ; d
  push a
  mov a, b
  mov b, [bp + 5] ; phi
  cmp a, b
  lodflgs
  mov bl, al
  shr al, 3
  shr bl, 2
  and bl, %00000001
  xor al, bl ; < (signed)
  mov ah, 0
  mov b, a
  pop a
  cmp b, 0
  je _for11_exit
_for11_block:
_if12_cond:
  mov b, [bp + -1] ; d
  push a
  mov a, b
  mov b, [bp + 7] ; e
  mul a, b
  pop a
  push a
  mov a, b
  mov b, [bp + 5] ; phi
  div a, b
  pop a
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
  je _if12_exit
_if12_true:
  mov b, [bp + -1] ; d
  leave
  ret
  jmp _if12_exit
_if12_exit:
_for11_update:
  mov b, [bp + -1] ; d
  push a
  mov a, b
  inc b
  push a
  mov a, b
  mov [bp + -1], a ; d
  pop a
  mov b, a
  pop a
  jmp _for11_cond
_for11_exit:
  mov b, 0
  leave
  ret
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
__string_0: .db "\n", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
