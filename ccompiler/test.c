#include "lib/stdio.asm"

void main(void){
  int i;

  for(i = 0; i < 10; i++){
    print(i);
  }

  return;
}

void print(int i){
  asm{
    mov a, ^i
    call print_u16d
  }

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
