#include "lib/stdio.asm"


char c = 'Z';
int i1 = 2;
int i2 = 1;
int i3 = 0;

void main(void) {
  char matrix[2][2][2];

  print(matrix[i3][i2][i1]);

  return;
}

void print(char c){
  asm{
    mov a, ^c
    swp a
    call putchar
  }
  return;
}

/*

ARGUMENTS
  char
  char
  char
  pc
  bp
  int <<< BP (local variables go here)
  int
  int
  char

*/
