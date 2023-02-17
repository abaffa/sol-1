char *s_hex_digits = "0123456789ABCDEF";

void main(void){

    return;
}

char atoi(int hexstr){
    char integer;

    asm {
        push b;
    }

    integer = hex_ascii_encode(hexstr);	// convert BL to 4bit code in AL
    asm{
        mov bl, bh
        push al					; save a
        call hex_ascii_encode
        pop bl	
        shl al, 4
        or al, bl
        pop b
        mov @integer, al
    }

    return integer;
}

char hex_ascii_encode(char in){
    char out;
    asm{
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CONVERT ASCII 'O'..'F' TO INTEGER 0..15
; ASCII in BL
; result in AL
; ascii for F = 0100 0110
; ascii for 9 = 0011 1001
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov al, @in
    test al, $40				; test if letter or number
    jnz hex_letter
    and al, $0F				; get number
    ret
hex_letter:
    and al, $0F				; get letter
    add al, 9
    mov @out, al
    }

    return out;
}