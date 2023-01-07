;Code for division of floating point numbers
;Performs fp_a divided by fp_b (that is, fp_a is dividend, fp_b is divisor)
;Uses long_a, long_b, long_c and long_d to perform calculation
;Quotient returned in fp_c
;Does not check for zero divisor
			.include "kernel.exp"
			.org	1024

;First gets fp_a and fp_b from input
;Get fp_a as an ascii hex string
			call	printnl
			mov	d,enter_fp_A_string
			call	puts
			mov	d,buffer
			call	gets
;Now parse string and put in fp_a
			mov	b,[buffer]		;gets two ascii hex char values
			swp	b			;mov gets little-endian, so need to swap bytes
			call	atoi			;converts ascii hex pair in B to value in AL
			mov	[fp_a],al
			mov	b,[buffer+2]
			swp	b
			call	atoi
			mov	[fp_a+1],al
			mov	b,[buffer+4]
			swp	b
			call	atoi
			mov	[fp_a+2],al
			mov	b,[buffer+6]
			swp	b
			call	atoi
			mov	[fp_a+3],al
;Get fp_b as an ascii hex string
			call	printnl
			mov	d,enter_fp_B_string
			call	puts
			mov	d,buffer
			call	gets
;Now parse string and put in fp_b
			mov	b,[buffer]		;gets two ascii hex char values
			swp	b			;mov gets little-endian, so need to swap bytes
			call	atoi			;converts ascii hex pair in B to value in AL
			mov	[fp_b],al
			mov	b,[buffer+2]
			swp	b
			call	atoi
			mov	[fp_b+1],al
			mov	b,[buffer+4]
			swp	b
			call	atoi
			mov	[fp_b+2],al
			mov	b,[buffer+6]
			swp	b
			call	atoi
			mov	[fp_b+3],al

divide_float:					
			
;Calculate sign of quotient first (same as in multiplication)							
			mov	al,[fp_a]
			mov	bl,al
			mov	al,[fp_b]
			xor	al,bl		;sign of result is XOR of signs of products
			mov	bl,al
			mov	al,10000000b	;mask of remainder of bits
			and	al,bl
			mov	[sign],al	;(sign) is 8-bit mask used to OR-in the sign bit
			
			
;Calculate exponent of quotient (same as in multiplication, except subtract exp of fp_b from exp fp_a
;Get exponent of a
			mov	al,[fp_a]	;need to get bit 0 of exponent from bit 7 of
			shl	al,1		;fp_a+1 and combine with the rest of the
			mov	bl,al		;exponent from fp_a
			mov	al,[fp_a+1]	;is bit 7 one?
			and	al,10000000b
			jnz	dfp_next_1	;yes, OR-in a 1 in bit 0 of exponent byte
			mov	al,bl
			jmp	dfp_next_2	;no, skip OR-in (will have a zero from shift)
dfp_next_1:		mov	al,00000001b
			or	al,bl
			
;Remove exponent bias and save
dfp_next_2:		sub	al,127		;al now has unbiased exponent of a
			mov	[exponent_a],al
			
;Get exponent of b
			mov	al,[fp_b]	;need to get bit 0 of exponent from bit 7 of
			shl	al,1		;fp_a+1 and combine with the rest of the
			mov	bl,al		;exponent from fp_a
			mov	al,[fp_b+1]	;is bit 7 one?
			and	al,10000000b
			jnz	dfp_next_3	;yes, OR-in a 1 in bit 0 of exponent byte
			mov	al,bl
			jmp	dfp_next_4	;no, skip OR-in (will have a zero from shift)
dfp_next_3:		mov	al,00000001b
			or	al,bl
			
;Remove exponent bias and save
dfp_next_4:		sub	al,127		;al now has unbiased exponent of b
			mov	[exponent_b],al
			
;Subtract unbiased exponent b from a and save
			mov	bl,al		;temp store unbiased exp b
			mov	al,[exponent_a]
			sub	al,bl		;unbiased exponent a - unbiased exponent b
			mov	[exponent_c],al	;exponent_c has unbiased exponent of result

;Divide significands
;Unpack and divide
			mov	al,[fp_a+1]	;need to set leftmost bit of significand to one
			mov	bl,al		;this bit is implied but not stored in fp
			mov	al,10000000b
			or	al,bl
			mov	[long_a],al
			mov	al,[fp_a+2]
			mov	[long_a+1],al
			mov	al,[fp_a+3]
			mov	[long_a+2],al
			mov	al,[fp_b+1]
			mov	bl,al
			mov	al,10000000b
			or	al,bl
			mov	[long_b],al
			mov	al,[fp_b+2]
			mov	[long_b+1],al
			mov	al,[fp_b+3]
			mov	[long_b+2],al
			call	divide_long
			
;Normalize quotient		
dfp_loop_1:		mov	al,[long_c]	;check leftmost bit of quotient
			mov	bl,al
			mov	al,10000000b
			and	al,bl			;test leftmost bit of quotient
			jnz	dfp_next_5		;normalized, assemble final fp
			call	shift_left_long_c	;not normalized, shift left and dec exponent
			mov	al,[exponent_c]
			dec	al
			mov	[exponent_c],al
			jmp	dfp_loop_1			

;Assemble final fp 
dfp_next_5:		mov	al,[exponent_c]	;First byte is sign bit and bits 7 to 1
			add	al,127			;restore bias
			mov	[exponent_c],al	;exponent_c now has biased exponent
			shr	al,1
			mov	bl,[sign]		;move over for sign bit
			or	al,bl			;put sign bit in
			mov	[fp_c],al		;First byte done
			mov	al,[long_c]		;get first byte of mantissa
			mov	[fp_c+1],al		;store in second byte of fp
			mov	al,[exponent_c]	;check bit 0 of biased exponent
			and	al,00000001b		;test bit 0 of exponent
			jnz	dfp_next_6		;bit is one, leave one in bit 7 of fp_c+1
			mov	al,[fp_c+1]		;bit is 0, mask off bit 7 of fp_c+1
			and	al,01111111b
			mov	[fp_c+1],al
dfp_next_6:		mov	al,[long_c+1]		;get second and third product bytes
			mov	[fp_c+2],al
			mov	al,[long_c+2]
			mov	[fp_c+3],al		;complete fp product now assembled in fp_c

;Insert rounding code here -- check leftmost bits of double_long_a+4, and increment mantissa if rounding

;Print result
			call	printnl
			mov	d,result_string
			call	puts
			mov	b,[fp_c]
			swp	b
			call	print_u16x
			mov	b,[fp_c+2]
			swp	b
			call	print_u16x
			call	printnl

			syscall sys_terminate_proc	;special call to return to OS
			
;Subroutines

;Divide_long subroutine
;Subroutine for 24-bit division
;Dividend passed in long_a
;Divisor passed in long_b
;Divisor and dividend words must be left-aligned before passing
;Does not check for zero divisor
;Uses double_long_a, b and c and long_d for calculation
;Quotient returned in long_c
;Remainder returned in long_r

divide_long:		mov	al,0			;clear variables used in calculation
			mov	[double_long_a],al
			mov	[double_long_a+1],al
			mov	[double_long_a+2],al
			mov	[double_long_a+3],al
			mov	[double_long_a+4],al
			mov	[double_long_a+5],al
			mov	[double_long_b],al
			mov	[double_long_b+1],al
			mov	[double_long_b+2],al
			mov	[double_long_b+3],al
			mov	[double_long_b+4],al
			mov	[double_long_b+5],al
			mov	[double_long_c],al
			mov	[double_long_c+1],al
			mov	[double_long_c+2],al
			mov	[double_long_c+3],al
			mov	[double_long_c+4],al
			mov	[double_long_c+5],al
			mov	[long_c],al		;clear quotient
			mov	[long_c+1],al
			mov	[long_c+2],al
			mov	al,10000000b		;Set up mask to OR-in quotient bits
			mov	[long_d],al
			mov	al,0
			mov	[long_d+1],al
			mov	[long_d+2],al
			mov	al,24
			mov	[divide_rounds],al	;Maximum 24 rounds of division
			mov	al,[long_a]		;set up divisor and dividend in 48-bit words
			mov	[double_long_a],al	;dividend
			mov	al,[long_a+1]
			mov	[double_long_a+1],al
			mov	al,[long_a+2]
			mov	[double_long_a+2],al
			mov	al,[long_b]		;divisor
			mov	[double_long_b],al
			mov	al,[long_b+1]
			mov	[double_long_b+1],al
			mov	al,[long_b+2]
			mov	[double_long_b+2],al
						
long_divide_loop:	mov	a,[double_long_a+4]	;48-bit subtraction of divisor from dividend
			mov	b,[double_long_b+4]	;Divisor in double_long_b to reg b
			swp	a			;Dividend in double_long_a to reg a
			swp	b
			sub	a,b			;Reg A - Reg B is dividend - divisor
			swp	a						
			mov	[double_long_c+4],a	;result placed in double_long_c
			mov	a,[double_long_a+2]	;move through bytes right to left
			mov	b,[double_long_b+2]
			swp	a
			swp	b
			sbb	a,b
			swp	a
			mov	[double_long_c+2],a
			mov	a,[double_long_a]
			mov	b,[double_long_b]
			swp	a
			swp	b
			sbb	a,b
			swp	a
			mov	[double_long_c],a	;double_long_c now has result of subtraction
			jnc	long_quotient_one	;no borrow, put 1 in quotient and replace dividend
			mov	al,[divide_rounds]	;borrow, leave 0 in quotient
			dec	al			;check if reached divide limit
			jz	long_divide_done	;24 rounds done, quit
			mov	[divide_rounds],al	;more rounds to do, go on
			call	shift_right_long_d	;shift mask in long_d right one
			jmp	long_divisor_shift	;do not replace dividend, shift divisor

long_quotient_one:	mov	al,[long_c]		;place a one in quotient word
			mov	bl,[long_d]
			or	al,bl			;uses long_d as mask for quotient bits
			mov	[long_c],al
			mov	al,[long_c+1]
			mov	bl,[long_d+1]
			or	al,bl
			mov	[long_c+1],al
			mov	al,[long_c+2]
			mov	bl,[long_d+2]
			or	al,bl
			mov	[long_c+2],al

			mov	al,[double_long_c]	;replace dividend with subtracted dividend
			mov	[double_long_a],al
			mov	al,[double_long_c+1]
			mov	[double_long_a+1],al
			mov	al,[double_long_c+2]
			mov	[double_long_a+2],al
			mov	al,[double_long_c+3]
			mov	[double_long_a+3],al
			mov	al,[double_long_c+4]
			mov	[double_long_a+4],al
			mov	al,[double_long_c+5]
			mov	[double_long_a+5],al

			
			mov	al,[double_long_a]	;check if remainder zero
			mov	bl,[double_long_a+1]
			or	al,bl
			mov	bl,[double_long_a+2]
			or	al,bl
			mov	bl,[double_long_a+3]
			or	al,bl
			mov	bl,[double_long_a+4]
			or	al,bl
			mov	bl,[double_long_a+5]
			or	al,bl
			jz	long_divide_done	;remainder zero, quit
			mov	al,[divide_rounds]	;remainder not zero, check if reached divide limit
			dec	al
			jz	long_divide_done	;24 rounds done, quit
			mov	[divide_rounds],al	;more rounds to do, go on
			call	shift_right_long_d	;subroutine shifts mask in long_d one right
									
long_divisor_shift:	call	shift_right_double_long_b	;shift divisor in double_long_b one position
			jmp	long_divide_loop

long_divide_done:	mov	al,[double_long_c+5]	;put remainder in long_r
			mov	[long_r+2],al
			mov	al,[double_long_c+4]
			mov	[long_r+1],al
			mov	al,[double_long_c+3]
			mov	[long_r],al
			
;Rounding code here. If remainder not zero, do one more round of division
;If no borrow on this extra round of division, add 1 to quotient

			mov	al,[long_r]		;check if remainder zero
			mov	bl,[long_r+1]
			or	al,bl
			mov	bl,[long_r+2]
			or	al,bl
			jz	rounding_done		;If remainder zero, no need to round
			
;Remainder not zero, do another round of division
			call	shift_right_double_long_b
			mov	a,[double_long_a+4]	;48-bit subtraction of divisor from dividend
			mov	b,[double_long_b+4]	;Divisor in double_long_b to reg b
			swp	a			;Dividend in double_long_a to reg a
			swp	b
			sub	a,b			;Reg A - Reg B is dividend - divisor
			swp	a						
			mov	[double_long_c+4],a	;result placed in double_long_c
			mov	a,[double_long_a+2]	;move through bytes right to left
			mov	b,[double_long_b+2]
			swp	a
			swp	b
			sbb	a,b
			swp	a
			mov	[double_long_c+2],a
			mov	a,[double_long_a]
			mov	b,[double_long_b]
			swp	a
			swp	b
			sbb	a,b
			swp	a
			mov	[double_long_c],a	;double_long_c now has result of subtraction
			jc	rounding_done		;borrow, leave quotient alone
							
			mov	a,[long_c+1]		;no borrow, round up
			swp	a			;16-bit additions for 24-bit add one to quotient
			add	a,1			
			swp	a				
			mov	[long_c+1],a
			mov	a,[long_c-1]		;uppermost byte will be garbage
			swp	a
			adc	a,0
			swp	a
			mov	[long_c-1],al
			
rounding_done:		ret
		
shift_right_long_d:	mov	a,[long_d]	;16-bit load, little endian
			swp	a		;swap to make it fit the big-endian mantissa
			shr	a
			swp	a
			mov	[long_d],a
			mov	a,[long_d+2]	;16-bit load, but high byte in memory is garbage
			mov	cl, 1
			swp	a
			rrc	a, cl
			swp	a
			mov	[long_d+2],al	;discard high byte which is garbage
			ret

shift_right_double_long_b:	
			mov	a,[double_long_b]
			swp	a
			shr	a
			swp	a
			mov	[double_long_b],a
			mov	a,[double_long_b+2]
			mov	cl, 1
			swp	a
			rrc	a, cl
			swp	a
			mov	[double_long_b+2],a
			mov	a,[double_long_b+4]
			mov	cl, 1
			swp	a
			rrc	a, cl
			swp	a
			mov	[double_long_b+4],a
			ret

;Subroutine to shift left one a 24-bit value
;24-bit value in long_c
shift_left_long_c:	mov	a,[long_c+1]	;16-bit load, little endian
			swp	a		;swap to make it fit the big-endian mantissa
			shl	a
			swp	a
			mov	[long_c+1],a
			mov	a,[long_c-1]	;16-bit load, low byte in memory is garbage
			mov	cl, 1
			swp	a
			rlc	a, cl
			swp	a
			mov	[long_c-1],a	;discard high byte which is garbage
			ret
;Strings
enter_fp_A_string:	.db	"Enter fp_A (32-bit hex): ",0
enter_fp_B_string:	.db	"Enter fp_B (32-bit hex): ",0
result_string:		.db	"Result (quotient) of fp_A divided by fp_B: ",0			

;Variables
			
fp_a			.db	041h,0b2h,0cah,0c1h	;Dividend IEEE 754 float 0x41b2cac1 = decimal 22.349			
fp_b			.db	42h,9ah,00h,00h	;Divisor IEEE 754 float 0x429a0000 = decimal 77.0			
fp_c			.db	0,0,0,0		;Quotient IEEE 754 float 0x3e949b39 = decimal 0.290246753			
sign			.db	0			
exponent_a		.db	0			
exponent_b		.db	0			
exponent_c		.db	0			
long_a			.db	0,0,0		;Significand dividend			
long_b			.db	0,0,0		;Significand divisor			
long_c			.db	0,0,0		;Significand quotient			
long_d			.db	0,0,0			
long_r			.db	0,0,0		;Significand remainder			
double_long_a		.db	0,0,0,0,0,0	;48-bit integer			
double_long_b		.db	0,0,0,0,0,0	;48-bit interger			
double_long_c		.db	0,0,0,0,0,0			
divide_rounds		.db	0

;Input buffer		
buffer:		.fill	40,0

			.include "stdio.asm"

		
			.end
			

