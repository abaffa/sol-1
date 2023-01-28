; --- Filename: test.c

.include "lib/kernel.exp"

.org PROC_TEXT_ORG

; --- begin text block
main:
  push bp
  mov bp, sp
; --- begin asm block
    call scan_u16d
    mov [i], a
  ; --- end asm block
_switch1_expr:
  mov b, [i]
_switch1_comparisons:
  cmp b, 1
  je _switch1_case0
  cmp b, 2
  je _switch1_case1
_switch1_default:
_switch2_expr:
  mov b, [j]
_switch2_comparisons:
  cmp b, 33
  je _switch2_case0
  cmp b, 22
  je _switch2_case1
_switch2_default:
  mov b, 88
  mov [i], b
  call print
  jmp _switch2_exit
  jmp _switch2_exit
_switch2_case0:
  mov b, 33
  mov [i], b
  call print
  jmp _switch2_exit
_switch2_case1:
  mov b, 22
  mov [i], b
  call print
  jmp _switch2_exit
_switch2_exit:
  jmp _switch1_exit
_switch1_case0:
  mov b, 1
  mov [i], b
  call print
  jmp _switch1_exit
_switch1_case1:
  mov b, 2
  mov [i], b
  call print
  jmp _switch1_exit
_switch1_exit:
  leave
  syscall sys_terminate_proc
print:
  push bp
  mov bp, sp
; --- begin asm block
    mov a, [i]
    call print_u16d
  ; --- end asm block
  leave
  ret
; --- end text block

; --- begin data block
i: .dw 54
j: .dw 99
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
