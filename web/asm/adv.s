
.include "kernel.exp"
.include "shell.exp"
.org shell_transient_area

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ADVENTURE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
adventure:
	push bp
	mov bp, sp	
	sub sp, 1		; 1 byte for player location
	sub sp, 64		; 64 bytes for player command

	mov d, s_adv_instr
	call puts

adv_start:
	call printnl
	mov al, 0
	mov [bp+0], al		; reset position

adv_loop:
	mov al, [bp+0]		; get position
	mov ah, 0
	mov cl, 1
	shl a, cl			; times 2
	mov a, [a + adv_text_table]	; get text description for new position
	mov d, a
	call printnl
	call puts
	call printnl

	lea d, [bp + -64]
	call gets			; get command

	mov al, [d]
	mov ah, al
	call to_upper
	cmp al, 'Q'
	je adv_ret			; quit game
	call adv_map_dir		; convert NESW to 0123 in AL
	cmp al, 4
	je other_command		; other keywords
move_command:
	mov bl, al			; save converted movement value
	mov al, [bp+0]		; get current pos
	mov cl, 2
	shl al, cl			; multiply pos by 4, for table conversion
	add al, bl			; get new position table index
	mov ah, 0
	add a, adv_pos_table
	mov d, a
	mov al, [d]
	mov [bp+0], al		; save new position
	
	jmp adv_loop			; back to main loop

other_command:
	mov d, s_adv_error
	call puts
	jmp adv_loop
	
adv_ret:
	mov al, 1	
	mov sp, bp
	pop bp
	ret

adv_pos_table:
	; pos 0, beginning
	.db 1			; N
	.db 2			; E
	.db 3			; S
	.db 4			; W

	; pos 1
	.db 6			
	.db 1			
	.db 0			
	.db 1	
		
	; pos 2
	.db 2
	.db 2
	.db 3
	.db 0	

	; pos 3
	.db 0
	.db 2
	.db 3
	.db 4

	; pos 4
	.db 5
	.db 0
	.db 3
	.db 4

	; pos 5, statue
	.db 5
	.db 5
	.db 4
	.db 5

	; pos 6
	.db 7
	.db 6
	.db 1
	.db 6

	; pos 7
	.db 8
	.db 7
	.db 6
	.db 7

	; pos 8
	.db 9
	.db 8
	.db 7
	.db 8

	; pos 9
	.db 9
	.db 9
	.db 8
	.db 9


; dir char in AL
; output in AL
adv_map_dir:
	mov ah, al
	mov al, 0
	cmp ah, 'N'
	je dir_ret
	inc al
	cmp ah, 'E'
	je dir_ret
	inc al
	cmp ah, 'S'
	je dir_ret
	inc al
	cmp ah, 'W'
	je dir_ret
	inc al			; not a direction command
dir_ret:
	ret
	
	




	
adv_text_table:
	.dw s_adv_0
	.dw s_adv_1
	.dw s_adv_2
	.dw s_adv_3
	.dw s_adv_4
	.dw s_adv_5
	.dw s_adv_6
	.dw s_adv_7
	.dw s_adv_8
	.dw s_adv_9	
	

s_adv_instr:	.db "INSTRUCTIONS:\n"
				.db "N: Go North\n"
				.db "S: Go South\n"
				.db "W: Go West\n"
				.db "E: Go East\n"
				.db "X: Examine Location (not working yet)\n"
				.db "Q: Quit Game", 0

s_adv_0:
	.db "It is around 9am, and you find yourself in a forest.\n"
	.db "There is an old wooden cabin north of you.\n"
	.db "The cabin looks very old and seems abandoned. It has two windows and a door at the front.\n"
	.db "You can see through the windows and the sunlight illuminates the inside of the cabin.", 0

s_adv_1:
	.db "You are at the entrance door to the cabin. The door is locked.\n", 0

s_adv_2:
	.db "You are in a clearing. Small trees encircle you. The grass is short and there are a few big rocks on the ground.\n"
	.db "The sky is a deep blue with big white puffy clouds flying calmly.", 0

s_adv_3:
	.db "You are in a deep forest. Big trees block the way south.", 0

s_adv_4:
	.db "You are on a rocky plateau.", 0

s_adv_5:
	.db "You are at the top of the plateau. Looking down the mountain you see a big lake.", 0

s_adv_6:
	.db "You are north of the cabin. There is a path through the trees leading north.", 0

s_adv_7:
	.db "You are in a forest path. There is a small stream north of you.", 0

s_adv_8:
	.db "You are at a water spring. The grass is wet and muddy.", 0

s_adv_9:
	.db "You are in a bog. The water reaches up to your knees.\n"
	.db "The ground feels like quick sand and it is difficult to move around.", 0

s_adv_restart:
	.db "Restart? ", 0
	
s_adv_error:
	.db "\nI do not understand that word.\n\n", 0
	
s_adv_exam:
	.db "There is nothing here.\n\n", 0
	
s_item_show:
	.db "Items at this location: ", 0



.include "stdio.s"
.include "ctype.s"

.end
