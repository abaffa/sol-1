; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  mov b, 1
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 10
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001 ; ==
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 1
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 10
  push a
  mov a, b
  mov b, 1
  cmp a, b
  lodflgs
  and al, %00000001
  xor al, %00000001 ; !=
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 1
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
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 20
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
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 1
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000011 ; <=
  cmp al, 0
  lodflgs
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 10
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000011 ; <=
  cmp al, 0
  lodflgs
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 20
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000011 ; <=
  cmp al, 0
  lodflgs
  xor al, %00000001
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 10
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
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 1
  push a
  mov a, b
  mov b, 10
  cmp a, b
  lodflgs
  and al, %00000011
  cmp al, 0
  lodflgs
  mov ah, 0
  mov b, a
  pop a
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 10
  push a
  mov a, b
  mov b, 1
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
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 10
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
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, 1
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
  swp b
  push b
  call printn
  add sp, 2
  mov b, __string_0 ; "\n"
  swp b
  push b
  call print
  add sp, 2
  mov b, __string_1 ; "HEllo"
  swp b
  push b
  call print
  add sp, 2
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
__j: .dw 2
__s_data: .db "Hello", 0
__s: .dw __s_data
__string_0: .db "\n", 0
__string_1: .db "HEllo", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
