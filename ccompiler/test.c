#include "lib/stdio.asm"

void main(void) {
  char c1[2];
  char *p;
  p = c1;
  f1(p);

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
