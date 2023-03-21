;Subroutine to multiply two floating-point variables
;Floats are IEEE 754 single-precision
;Multiplies fp_a and fp_b
;Result in fp_c
			.include "lib/kernel.exp"
			.org	8000h

;First gets fp_a and fp_b from input
			call	scan_u16x
			swp	a
			mov	[fp_a],a
			call	scan_u16x
			swp	a
			mov	[fp_a+2],a
			call	scan_u16x
			swp	a
			mov	[fp_b],a
			call	scan_u16x
			swp	a
			mov	[fp_b+2],a

multiply_float:
;Calculate sign of product first
			mov	al,[fp_a]
			mov	bl,al
			mov	al,[fp_b]
			xor	al,bl		;sign of result is XOR of signs of products
			mov	bl,al
			mov	al,10000000b	;mask of remainder of bits
			and	al,bl
			mov	[sign],al	;(sign) is 8-bit mask used to OR-in the sign bit
;Calculate exponent of product
;Get exponent of a
			mov	al,[fp_a]	;need to get bit 0 of exponent from bit 7 of
			shl	al,1		;fp_a+1 and combine with the rest of the
			mov	bl,al		;exponent from fp_a
			mov	al,[fp_a+1]	;is bit 7 one?
			and	al,10000000b
			jnz	mfp_next_1	;yes, OR-in a 1 in bit 0 of exponent byte
			mov	al,bl
			jmp	mfp_next_2	;no, skip OR-in (will have a zero from shift)
mfp_next_1:		mov	al,00000001b
			or	al,bl
;Remove exponent bias and save
mfp_next_2:		sub	al,127		;al now has unbiased exponent of a
			mov	[exponent_a],al
			
;Get exponent of b
			mov	al,[fp_b]	;need to get bit 0 of exponent from bit 7 of
			shl	al,1		;fp_a+1 and combine with the rest of the
			mov	bl,al		;exponent from fp_a
			mov	al,[fp_b+1]	;is bit 7 one?
			and	al,10000000b
			jnz	mfp_next_3	;yes, OR-in a 1 in bit 0 of exponent byte
			mov	al,bl
			jmp	mfp_next_4	;no, skip OR-in (will have a zero from shift)
mfp_next_3:		mov	al,00000001b
			or	al,bl
;Remove exponent bias and save
mfp_next_4:		sub	al,127		;al now has unbiased exponent of b
			mov	[exponent_b],al
;Add unbiased exponents and save
			mov	[exponent_b],al	;add exponents
			mov	bl,al
			mov	al,[exponent_a]
			add	al,bl
			mov	[exponent_c],al	;exponent_c has unbiased exponent of product
			

			
;Multiply significands
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

			call	multiply_long		;24-bit integer multiplication


			
;Normalize product			
mfp_loop_1:		mov	al,[double_long_b]	;check leftmost bit of product
			mov	bl,al
			mov	al,10000000b
			and	al,bl			;test leftmost bit of product
			jnz	mfp_next_5		;normalized, assemble final fp
			call	shift_left_double_long_b	;not normalized, shift left and dec exponent
			mov	al,[exponent_c]
			dec	al
			mov	[exponent_c],al
			jmp	mfp_loop_1
			

;Assemble final fp 
mfp_next_5:		mov	al,[exponent_c]	;First byte is sign bit and bits 7 to 1
			add	al,128			;restore bias + 1 (for effect of multiplication)
			mov	[exponent_c],al	;exponent_c now has biased exponent
			shr	al,1
			mov	bl,[sign]			;move over for sign bit
			or	al,bl			;put sign bit in
			mov	[fp_c],al		;First byte done
			mov	al,[double_long_b]	;get first byte of mantissa
			mov	[fp_c+1],al		;store in second byte of fp
			mov	al,[exponent_c]	;check bit 0 of biased exponent
			and	al,00000001b		;test bit 0 of exponent
			jnz	mfp_next_6		;bit is one, leave one in bit 7 of fp_c+1
			mov	al,[fp_c+1]		;bit is 0, mask off bit 7 of fp_c+1
			and	al,01111111b
			mov	[fp_c+1],al
mfp_next_6:		mov	al,[double_long_b+1]	;get second and third product bytes
			mov	[fp_c+2],al
			mov	al,[double_long_b+2]
			mov	[fp_c+3],al		;complete fp product now assembled in fp_c

;Print product
			mov	b,[fp_c]
			swp	b
			call	print_u16x
			mov	b,[fp_c+2]
			swp	b
			call	print_u16x

;Insert rounding code here -- check leftmost bits of double_long_a+4, and increment mantissa if rounding
;For now just truncate
			
			ret

			

;Multiply long integers, using shift and add only -- no nybble multiplication
;Long words passed in long_a and long_b
;Product returned in double_long_b
;Uses double_long_a to hold multiplicand for shifting
;Uses double_long_b for 48-bit addition
;Uses long_c for mask for multiplicand bits in long_b

multiply_long:		mov	al,0
			mov	[double_long_a],al	;clear multiplicand word
			mov	[double_long_a+1],al
			mov	[double_long_a+2],al
			mov	[double_long_a+3],al
			mov	[double_long_a+4],al
			mov	[double_long_a+5],al
			mov	[double_long_b],al	;clear product word
			mov	[double_long_b+1],al
			mov	[double_long_b+2],al
			mov	[double_long_b+3],al
			mov	[double_long_b+4],al
			mov	[double_long_b+5],al
			mov	[long_c],al
			mov	[long_c+1],al
			mov	al,00000001b		;mask for multiplicand b bits
			mov	[long_c+2],al
			mov	al,[long_a+2]
			mov	[double_long_a+5],al	;place multiplicand a in double_long_a
			mov	al,[long_a+1]
			mov	[double_long_a+4],al
			mov	al,[long_a]
			mov	[double_long_a+3],al

mult_long_loop:	mov	al,[long_b+2]		;check bit in multiplicand b with mask
			mov	bl,al
			mov	al,[long_c+2]		;mask in long_c		
			and	al,bl
			jz	mult_long_next_1	;need to check all 3 bytes
			jmp	mult_long_add		;bit is one, add
mult_long_next_1:	mov	al,[long_b+1]
			mov	bl,al
			mov	al,[long_c+1]
			and	al,bl
			jz	mult_long_next_2
			jmp	mult_long_add
mult_long_next_2:	mov	al,[long_b]
			mov	bl,al
			mov	al,[long_c]
			and	al,bl
			jz	mult_long_shift	;bit is zero, don't add, shift multiplicand


			
;In the following add double-long, do 3 16-bit additions with carry
;Need to swap before and after add to get memory order correct			
mult_long_add:		mov	a,[double_long_b+4]	;bit in long_b is one, add multiplicand a to product b
			swp	a
			mov	b,a			;48-bit addition
			mov	a,[double_long_a+4]
			swp	a
			add	a,b
			swp	a
			mov	[double_long_b+4],a	;product will accumulate in double_long_b
			mov	a,[double_long_b+2]
			swp	a
			mov	b,a
			mov	a,[double_long_a+2]
			swp	a
			adc	a,b
			swp	a
			mov	[double_long_b+2],a
			mov	a,[double_long_b]
			swp	a
			mov	b,a
			mov	a,[double_long_a]
			swp	a
			adc	a,b
			swp	a
			mov	[double_long_b],a
			
mult_long_shift:	call	shift_left_double_long_a	;shifts multiplicand in double_long_a
			call	shift_left_long	;shifts mask in long_c left one
			mov	al,[long_c]		;check long_c if zero (24 shifts done)
			mov	bl,al
			mov	al,[long_c+1]
			or	al,bl
			jnz	mult_long_loop		;not zero, keep multiplying
			mov	bl,al
			mov	al,[long_c+2]
			or	al,bl
			jnz	mult_long_loop		;not zero, keep multiplying
			ret				;mask bytes all zeros, done
;Subroutine to shift left one a 48-bit value
;48-bit value in double_long_a
;concatenates 3 one-bit left shifts of the 3 words that make up the value
;uses 16-bit mov instructions, swaps low and hi bytes to make it right
shift_left_double_long_a:
			mov	a,[double_long_a+4]
			swp	a
			shl	a
			swp	a
			mov	[double_long_a+4],a
			mov	a,[double_long_a+2]
			mov	cl, 1
			swp	a
			rlc	a, cl
			swp	a
			mov	[double_long_a+2],a
			mov	a,[double_long_a]
			mov	cl, 1
			swp	a
			rlc	a, cl
			swp	a
			mov	[double_long_a],a
			ret
			
;Subroutine to shift left one a 48-bit value
;48-bit value in double_long_b
;concatenates 3 one-bit left shifts of the 3 words that make up the value
;uses 16-bit mov instructions, swaps low and hi bytes to make it right
shift_left_double_long_b:
			mov	a,[double_long_b+4]
			swp	a
			shl	a
			swp	a
			mov	[double_long_b+4],a
			mov	a,[double_long_b+2]
			mov	cl, 1
			swp	a
			rlc	a, cl
			swp	a
			mov	[double_long_b+2],a
			mov	a,[double_long_b]
			mov	cl, 1
			swp	a
			rlc	a, cl
			swp	a
			mov	[double_long_b],a
			ret

;Subroutine to shift left one a 24-bit value
;24-bit value in long_c
shift_left_long:	mov	a,[long_c+1]	;16-bit load, little endian
			swp	a		;swap to make it fit the big-endian mantissa
			shl	a
			swp	a
			mov	[long_c+1],a
			mov	a,[long_c-1]	;16-bit load, low byte in memory is garbage
			mov	cl, 1
			swp	a
			rlc	a, cl
			mov	[long_c],al	;discard high byte which is garbage
			ret
							
;Variables
fp_a			.db	40h,83h,33h,33h	;IEEE 754 single-precision floating point number 0x40833333 = decimal 4.1
fp_b			.db	40h,60h,00h,00h	;IEEE 754 single-precision floating point number 0x40600000 = decimal 3.5
fp_c			.db	0,0,0,0	;IEEE 754 single-precision floating point number 0x4165999A = decimal 14.35
sign			.db	0
exponent_a		.db	0
exponent_b		.db	0
exponent_c		.db	0
long_a			.db	0,0,0		;24-bit integer
long_b			.db	0,0,0		;24-bit integer
long_c			.db	0,0,0		;24-bit integer
double_long_a	.db	0,0,0,0,0,0	;48-bit integer
double_long_b	.db	0,0,0,0,0,0	;48-bit interger

.include "lib/stdio.asm"

.end
