.include "kernel.exp"

main:
	mov d, s_clear
	call puts

main_L0:
	call getchar
	cmp ah, 'q'
	je quit
	call getchar
	call getchar
	
	cmp ah, $41
	je go_up

	cmp ah, $42
	je go_down

	cmp ah, $43
	je go_right
	
	cmp ah, $44
	je go_left

back:
; calculate	array position for Y coordinate
	mov a, [pos]
	mov d, buffer
	add d, a
	mov al, '@'
	mov [d], al

	mov d, s_clear
	call puts

	mov d, buffer
	mov b, 0
loop:
	mov c, width
	call putsn
	call printnl
	add d, width
	inc b
	cmp b, height
	jne loop

	jmp main_L0

go_up:
	mov a, [pos]
	sub a, width
	mov [pos], a
	jmp back
go_down:
	mov a, [pos]
	add a, width
	mov [pos], a
	jmp back

go_right:
	mov a, [pos]
	inc a
	mov [pos], a
	jmp back

go_left:
	mov a, [pos]
	dec a
	mov [pos], a
	jmp back

quit:
	ret

width: 			.equ 60
height:			.equ 20

x:				.dw 0
y:				.dw 0

pos:			.dw 0


choice:			.fill 20


s_up:			.db $41
s_down:			.db $42
s_right:		.db $43
s_left:			.db $44

s_clear:		.db 27, "[2J", 27, "[H", 0

buffer:			.fill 1200, ' '

.include "stdio.asm"
.end

