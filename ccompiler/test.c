#include "lib/stdio.asm"


char cc;

void main(void) {
  char c1[3];

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
