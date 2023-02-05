#include "lib/stdio.asm"

void main(void) {
  int j;
  j = 55;
  f2(j);

  asm{

    ; division
  }

  char c1[2];
  f1(c1);

  return;
}

void f2(int i){


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
