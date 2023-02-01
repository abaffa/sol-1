#include "lib/stdio.asm"


char matrix[2][2][2] = 'A';
char c = 'Z';
int i = 222;

void main(void) {
  c = matrix[1][1][1];

  asm{
    mov a, $c
    swp a
    call putchar

  }

  return;
}



/*

ARGUMENTS
  char
  int
  int
  pc
  bp
  locals <<< BP

*/
