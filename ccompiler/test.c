#include "lib/stdio.asm"

void main(void){
  char m[10][10];

  m[0][0] = 'A';

  return;
}

void f1(char c[10][10]){
  char cc;

  cc = c[1][0];
  asm{
    mov a, ^cc;
    swp a
    call putchar
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
