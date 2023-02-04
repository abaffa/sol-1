#include "lib/stdio.asm"


char cc;

char c1[3];

void main(void) {

  f1(c1);
  return;
}

void f1(char c[3]){
  cc = c[2];
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
  char
  pc
  bp
  int <<< BP (local variables go here)
  int
  int
  char

*/
