; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK

main:
  push bp
  mov bp, sp
  sub sp, 2 ; i
  sub sp, 2 ; j
  sub sp, 2 ; k
  mov b, 3
  push a
  mov a, b
  mov [bp + -1], a ; i
  pop a
  mov b, 50
  push a
  mov a, b
  mov [bp + -3], a ; j
  pop a
  mov b, 5
  push a
  mov a, b
  mov [bp + -5], a ; k
  pop a
_switch1_expr:
  mov b, [bp + -1] ; i
_switch1_comparisons:
  cmp b, 1
  je _switch1_case0
  cmp b, 2
  je _switch1_case1
  cmp b, 3
  je _switch1_case2
  jmp _switch1_default
_switch1_case0:
  mov b, _string_0 ; "1"
  swp b
  push b
  call print
  add sp, 2
_switch1_case1:
  mov b, _string_1 ; "2"
  swp b
  push b
  call print
  add sp, 2
_switch1_case2:
  mov b, _string_2 ; "3"
  swp b
  push b
  call print
  add sp, 2
  mov b, _string_3 ; "Inside block"
  swp b
  push b
  call print
  add sp, 2
_switch1_default:
  mov b, _string_4 ; "Default"
  swp b
  push b
  call print
  add sp, 2
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
m1_data: 
.dw 123,111,123,
.fill 14, 0
m1: .dw m1_data
m2_data: 
.dw 0,1,2,
.fill 14, 0
m2: .dw m2_data
_string_0: .db "1", 0
_string_1: .db "2", 0
_string_2: .db "3", 0
_string_3: .db "Inside block", 0
_string_4: .db "Default", 0
; --- END DATA BLOCK

; --- BEGIN INCLUDE BLOCK
.include "lib/stdio.asm"
; --- END INCLUDE BLOCK


.end
