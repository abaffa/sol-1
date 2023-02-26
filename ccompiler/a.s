; --- FILENAME: fact.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  sub sp, 2 ; n
  sub sp, 2 ; result
  mov b, _string_0
  swp b
  push b
  call print
  add sp, 2
  call getn
  push a
  mov a, b
  mov [bp + -1], a ; n
  pop a
  mov b, [bp + -1] ; n
  swp b
  push b
  call fact
  add sp, 2
  push a
  mov a, b
  mov [bp + -3], a ; result
  pop a
  mov b, _string_1
  swp b
  push b
  call print
  add sp, 2
  mov b, [bp + -3] ; result
  swp b
  push b
  call printn
  add sp, 2
  mov b, _string_2
  swp b
  push b
  call print
  add sp, 2
  leave
  syscall sys_terminate_proc
fact:
  push bp
  mov bp, sp
_if1_cond:
  mov b, [bp + 5] ; n
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
  je _if1_else
_if1_true:
  mov b, 1
  leave
  ret
  jmp _if1_exit
_if1_else:
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov b, [bp + 5] ; n
  push a
  mov a, b
  mov b, 1
  sub a, b
  mov b, a
  pop a
  swp b
  push b
  call fact
  add sp, 2
  mul a, b
  pop a
  leave
  ret
_if1_exit:
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
; --- END TEXT BLOCK

; --- BEGIN DATA BLOCK
_string_0: .db "Factorial of: ", 0
_string_1: .db "\nResult: ", 0
_string_2: .db "\n", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
