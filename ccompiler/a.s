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
  cmp b, 1
  je _switch1_case0
  cmp b, 2
  je _switch1_case1
_switch1_default:
  mov b, 3
  mov [i], b
  call print
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
j: .dw 33
ss_data: .db "Hello World", 0
ss: .dw ss_data
; --- end data block
; --- begin include block
.include "lib/stdio.asm"
; --- end include block

.end
