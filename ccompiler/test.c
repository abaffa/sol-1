#include "lib/stdio.asm"

char *s = "\n";

void main(void){
  
  int j;
  int i;
  int k;
  k = 5;
  j = 10;

  j <= 10 ? (k < 2 ? 11 : 23) : 66;

  asm{
    mov a, @i
    call print_u16d
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
