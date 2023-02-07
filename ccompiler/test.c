#include "lib/stdio.asm"

void main(void){
  int i[2];

  i[0] = sizeof(int);
  i[1] = sizeof(char);

  asm{
    mov a, @i
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
