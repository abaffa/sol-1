#include "lib/stdio.asm"


char matrix[5][5][5] = 'a';
char c = 'Z';
int i1 = 2;
int i2 = 1;
int i3 = 0;

void main(void) {
  print(matrix[i3][i2][i1]);

  return;
}

void print(char c){
  asm{
    mov a, $c
    swp a
    add a, 0100h
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
