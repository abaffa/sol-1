#include "lib/stdio.asm"
#include "lib/token.asm"
#include "lib/ctype.asm"

void main(void){

    asm{
        mov a, 0
        mov [prog], a	; move tokennizer pointer to the beginning of the arguments area (address 0)
        call get_arg	; read argument line
        mov d, tokstr
        call puts
        call printnl
    }

   return;
}







/*

ARGUMENTS
  char
  char
  ptr
  pc
  bp
  char << BP (local variables go here)

*/