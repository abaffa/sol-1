;Program for calculating e using series sum of terms 1/n!
;Will use 10 terms
;Uses fpdiv and fpadd as subroutines
;e accumulates in fp_e

			.include "kernel.exp"
			.org	0400h

;=================Debug===========================

			call	print_variables

;=================================================
			syscall sys_terminate_proc	;special call to return to OS
;Subroutines

;===============Debug--print variables================
print_variables:	
			call	printnl

;=====================Debug========================

			ret

;==================================================

			mov	d,fp_A_string
			call	puts
			mov	b,[fp_a]
			swp	b
			call	print_u16x
			mov	b,[fp_a+2]
			swp	b
			call	print_u16x
			call	printnl
			mov	d,fp_B_string
			call	puts
			mov	b,[fp_b]
			swp	b
			call	print_u16x
			mov	b,[fp_b+2]
			swp	b
			call	print_u16x
			call	printnl
			mov	d,fp_C_string
			call	puts
			mov	b,[fp_c]
			swp	b
			call	print_u16x
			mov	b,[fp_c+2]
			swp	b
			call	print_u16x
			call	printnl
			mov	d,sign_string
			call	puts
			mov	b,[sign]
			swp	b
			call	print_u16x
			call	printnl
			mov	d,long_a_string
			call	puts
			mov	b,[long_a]
			swp	b
			call	print_u16x
			mov	b,[long_a+2]
			swp	b
			call	print_u16x
			call	printnl
			mov	d,long_b_string
			call	puts
			mov	b,[long_b]
			swp	b
			call	print_u16x
			mov	b,[long_b+2]
			swp	b
			call	print_u16x
			call	printnl
			mov	d,long_c_string
			call	puts
			mov	b,[long_c]
			swp	b
			call	print_u16x
			mov	b,[long_c+2]
			swp	b
			call	print_u16x
			call	printnl
			mov	d,long_d_string
			call	puts
			mov	b,[long_d]
			swp	b
			call	print_u16x
			mov	b,[long_d+2]
			swp	b
			call	print_u16x
			call	printnl
			mov	d,exponent_a_string
			call	puts
			mov	b,[exponent_a]
			swp	b
			call	print_u16x
			call	printnl
			mov	d,exponent_b_string
			call	puts
			mov	b,[exponent_b]
			swp	b
			call	print_u16x
			call	printnl
			mov	d,exponent_c_string
			call	puts
			mov	b,[exponent_c]
			swp	b
			call	print_u16x
			call	printnl


			mov	d,fp_e_string
			call	puts
			mov	b,[fp_e]
			swp	b
			call	print_u16x
			mov	b,[fp_e+2]
			swp	b
			call	print_u16x
			call	printnl
			mov	d,n_string
			call	puts
			mov	bl,[n]
			call	print_u8x
			call	printnl
			mov	d,fp_fact_string
			call	puts
			mov	b,[fp_factorial]
			swp	b
			call	print_u16x
			mov	b,[fp_factorial+2]
			swp	b
			call	print_u16x
			call	printnl

			ret

;Strings for print_variables
fp_A_string:		.db	"fp_a: ",0
fp_B_string:		.db	"fp_b: ",0
fp_C_string:		.db	"fp_c: ",0
n_string:		.db	"n: ",0
fp_fact_string:	.db	"n factorial as fp: ",0
fp_e_string:		.db	"fp_e (value of e): ",0
sign_string:		.db	"sign: ",0
long_a_string:		.db	"long_a: ",0
long_b_string:		.db	"long_b: ",0
long_c_string:		.db	"long_c: ",0
long_d_string:		.db	"long_d: ",0
exponent_a_string:	.db	"exponent_a: ",0
exponent_b_string:	.db	"exponent_b: ",0
exponent_c_string:	.db	"exponent_c: ",0
			
;======================End of print_variables subroutine==================


;add_float subroutine
;Addends passed in fp_a and fp_b
;Uses long_a and long_b, long_c, exponent_a, exponent_b and exponent_c in calculation
;Sum returned in fp_c

add_float:		
;Extract mantissas from float
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

;Extract exponents from float
;Get exponent of a
			mov	al,[fp_a]	;need to get bit 0 of exponent from bit 7 of
			shl	al,1		;fp_a+1 and combine with the rest of the
			mov	bl,al		;exponent from fp_a
			mov	al,[fp_a+1]	;is bit 7 one?
			and	al,10000000b
			jnz	afp_next_1	;yes, OR-in a 1 in bit 0 of exponent byte
			mov	al,bl
			jmp	afp_next_2	;no, skip OR-in (will have a zero from shift)
afp_next_1:		mov	al,00000001b
			or	al,bl

;Remove exponent bias and save
afp_next_2:		sub	al,127		;al now has unbiased exponent of a
			mov	[exponent_a],al
			
;Get exponent of b
			mov	al,[fp_b]	;need to get bit 0 of exponent from bit 7 of
			shl	al,1		;fp_a+1 and combine with the rest of the
			mov	bl,al		;exponent from fp_a
			mov	al,[fp_b+1]	;is bit 7 one?
			and	al,10000000b
			jnz	afp_next_3	;yes, OR-in a 1 in bit 0 of exponent byte
			mov	al,bl
			jmp	afp_next_4	;no, skip OR-in (will have a zero from shift)
afp_next_3:		mov	al,00000001b
			or	al,bl
;Remove exponent bias and save
afp_next_4:		sub	al,127		;al now has unbiased exponent of b
			mov	[exponent_b],al

;Compare exponents
			mov	al,[exponent_a]
			mov	bl,[exponent_b]	
			mov	ah,0
			mov	bh,0		
			sub	a,b		;does a-b		
			jnc	afp_skip_1	;exponent_b is less than or equal to exponent_a
			jmp	afp_next_5	;exponent_b is greater than exponent_a
afp_skip_1:		

			jz	afp_add	;exponent_b is equal to exponent_a
			jmp	afp_next_6	;exponent_b is less than exponent_a

;exponent_b > a -- shift mantissa of fp_a right and increment exponent_a until exponents equal
afp_next_5:		mov	al,[long_a]
			mov	[long_d],al
			mov	al,[long_a+1]
			mov	[long_d+1],al
			mov	al,[long_a+2]
			mov	[long_d+2],al
afp_loop_1:		call	shift_right_long_d	;subroutine shifts long_d
			mov	al,[exponent_a]
			inc	al
			mov	[exponent_a],al
			mov	bl,[exponent_b]
			sub	al,bl
			jz	afp_align_a_done	;exponents equal, done
			jmp	afp_loop_1	;not done, continue to shift
afp_align_a_done:	mov	al,[long_d]		;put shifted mantissa back in long_a
			mov	[long_a],al
			mov	al,[long_d+1]
			mov	[long_a+1],al
			mov	al,[long_d+2]
			mov	[long_a+2],al
			jmp	afp_add

;exponent_a > b -- shift mantissa of fp_b right and increment exponent_b until exponents equal
afp_next_6:		mov	al,[long_b]
			mov	[long_d],al
			mov	al,[long_b+1]
			mov	[long_d+1],al
			mov	al,[long_b+2]
			mov	[long_d+2],al
afp_loop_2:		call	shift_right_long_d	;subroutine shifts long_d
			mov	al,[exponent_b]
			inc	al
			mov	[exponent_b],al
			mov	bl,[exponent_a]
			sub	al,bl
			jz	afp_align_b_done	;exponents equal, done
			jmp	afp_loop_2	;not done, continue to shift
afp_align_b_done:	mov	al,[long_d]		;put shifted mantissa back in long_b
			mov	[long_b],al
			mov	al,[long_d+1]
			mov	[long_b+1],al
			mov	al,[long_d+2]
			mov	[long_b+2],al

;24-bit add of adjusted mantissas (exponents are equal)		
afp_add:		mov	al,[exponent_a]
			mov	[exponent_c],al	;final exponent of sum
			mov	a,[long_a+1]		
			swp	a			;16-bit additions for 24-bit adc
			mov	b,[long_b+1]
			swp	b
			add	a,b			
			swp	a				
			mov	[long_c+1],a

;New method for adding upper bytes of long_a and long_b

			mov	al,[long_a]
			mov	bl,[long_b]
			mov	ah,0ffh
			mov	bh,00h
			adc	a,b
			mov	[long_c],al		;store sum
			jc	afp_skip_2	;carry-out, shift right mantissa and inc exp
			jmp	afp_done		;no carry-out, done with math

;Carry-out from add, need to shift sum right and increment exponent
afp_skip_2:		mov	al,[long_c]	;need to put sum in long_d for shift_right_long subroutine
			mov	[long_d],al
			mov	al,[long_c+1]
			mov	[long_d+1],al
			mov	al,[long_c+2]
			mov	[long_d+2],al
			call	shift_right_long_d
			mov	al,[long_d]
			mov	bl,1000000b
			or	al,bl		;put 1 from carry-out in high-bit
			mov	[long_c],al		;store shifted mantissa in long_c
			mov	al,[long_d+1]
			mov	[long_c+1],al
			mov	al,[long_d+2]
			mov	[long_c+2],al
			mov	al,[exponent_c]	;increment exponent
			inc	al
			mov	al,[exponent_c]

;Math done, assemble floating point

afp_done:		mov	al,[exponent_c]	;First byte is sign bit and bits 7 to 1
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
			jnz	afp_skip_3		;bit is one, leave one in bit 7 of fp_c+1
			mov	al,[fp_c+1]		;bit is 0, mask off bit 7 of fp_c+1
			and	al,01111111b
			mov	[fp_c+1],al
afp_skip_3:		mov	al,[long_c+1]		;get second and third product bytes
			mov	[fp_c+2],al
			mov	al,[long_c+2]
			mov	[fp_c+3],al		;complete fp product now assembled in fp_c
			ret


;divide_float subroutine
;Performs fp_a divided by fp_b (that is, fp_a is dividend, fp_b is divisor)
;Uses long_a, long_b, long_c and long_d to perform calculation
;Quotient returned in fp_c
;Does not check for zero divisor

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
			ret








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
result_string:		.db	"Result of fp_A plus fp_B: ",0

;===============Debugging strings======================
exp_b_less_or_equal:	.db	"Exp b less than or equal to exp a.",0
exp_b_greater:		.db	"Exp b greater than exp a.",0
;=======================================================

;Variables
fp_a:			.db	00h,00h,00h,00h
fp_b:			.db	00h,00h,00h,00h
fp_c:			.db	00h,00h,00h,00h
fp_e:			.db	00h,00h,00h,00h	;accumulating value of e
fp_one:		.db	38h,0F0h,00h,00h	;constant value 1 in fp
factorial:		.db	00h,00h		;current factorial as integer
fp_factorial:		.db	00h,00h,00h,00h	;current factorial as fp
n:			.db	00h			;factorial index
sign:			.db	00h
byte_a:		.db	00h
byte_b:		.db	00h
byte_c:		.db	00h
exponent_a:		.db	00h
exponent_b:		.db	00h
exponent_c:		.db	00h
long_a:		.db	00h,00h,00h	;for 24-bit values
long_b:		.db	00h,00h,00h
long_c:		.db	00h,00h,00h
long_d:		.db	00h,00h,00h
long_r			.db	0,0,0
double_long_a		.db	0,0,0,0,0,0	;48-bit integer			
double_long_b		.db	0,0,0,0,0,0	;48-bit interger			
double_long_c		.db	0,0,0,0,0,0			
divide_rounds		.db	0

;Input buffer		
buffer:		.fill	40,0

			.include "stdio.asm"

			.end



