#include "lib/stdio.asm"

void main(void){
  int *i[2][2]; // -7
  int j; // -9
  int k; // -11
  j = 55;
  i[1][1] = &j;
  k = *i[1][1];

  asm{
    mov a, @k
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
