.include "kernel.exp"
.org PROC_TEXT_ORG

; **** TEXT SEGMENT ****

main:
	mov a, 0
	mov b, [v1]
	push a
	mov a, b
	mov b, [v2]
	push a
	mov a, b
	mov b, [v3]
	mul a, b
	pop a
	add a, b
	mov b, a
	pop a
	mov [x], b
	mov a, 0
	mov b, [x]
	push a
	mov a, b
	mov b, 1
	add a, b
	mov b, a
	pop a
	mov [y], b
	mov a, 0
	mov b, [y]
	push a
	mov a, b
	mov b, 2
	mul a, b
	pop a
	mov [z], b


	mov a, [z]
	call print_u16d
	call printnl


	syscall sys_terminate_proc

; **** DATA SEGMENT ****

x: .dw 11
y: .dw 22
z: .dw 33
v1: .dw 1
v2: .dw 2
v3: .dw 3


printnl:
	push a
	mov a, $0A00
	syscall sys_io
	mov a, $0D00
	syscall sys_io
	pop a
	ret

print_u16d:
	push a
	push b
	mov b, 10000
	div a, b			; get 10000 coeff.
	call print_zero_or_space
	mov a, b
	mov b, 1000
	div a, b			; get 10000 coeff.
	call print_zero_or_space
	mov a, b
	mov b, 100
	div a, b
	call print_zero_or_space
	mov a, b
	mov b, 10
	div a, b
	call print_zero_or_space
	mov a, b
	add al, $30
	mov ah, al
	mov al, 0
	syscall sys_io	; print coeff
	pop b
	pop a
	ret
print_zero_or_space:
	; cmp a, 0
	; jne print_number
	; mov ah, $20
	; call putchar
	; ret
print_number:
	add al, $30
	mov ah, al
	call putchar
	ret


putchar:
	push a
	mov al, 0
	syscall sys_io			; char in AH
	pop a
	ret
		


.end
