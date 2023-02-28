; --- FILENAME: test.c
.include "lib/kernel.exp"
.org PROC_TEXT_ORG

; --- BEGIN TEXT BLOCK
main:
  push bp
  mov bp, sp
  sub sp, 2 ; a
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
  mov b, 99
  swp b
  push b
  call printn
  add sp, 2
  jmp _switch1_exit
_switch1_case0:
  mov b, 1
  swp b
  push b
  call printn
  add sp, 2
  jmp _switch1_exit ; case break
_switch1_case1:
  mov b, 2
  swp b
  push b
  call printn
  add sp, 2
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
