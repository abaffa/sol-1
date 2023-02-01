#include "lib/stdio.asm"


char matrix[5][5][5] = 'A';
char c = 'Z';
int i1 = 2;
int i2 = 1;
int i3 = 0;

void main(void) {
  c = matrix[i3][i2][i1];

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
