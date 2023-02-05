#include "lib/stdio.asm"

void main(void){
  char c1[10];
  char *p;
  p = c1;
  int i;

  for(i = 0; i < 10; i = i + 1){
    *p = 'A'+i;
  }
  
  
  f1(p);

  return;
}

void f1(char c[10]){
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
