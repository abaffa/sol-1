#include "lib/stdio.asm"

void main(void) {
  char c1[2];

  f1(c1);

  return;
}

void f1(char c[2]){
  char cc;
  cc = c[1];

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
