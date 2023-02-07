#include "lib/stdio.asm"

void main(void){
  int i[2][2];
  int j;

  i[1][0] = sizeof(int);
  i[1][1] = sizeof(char);

  j = i[1][0];

  asm{
    mov a, @j
    swp a
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
