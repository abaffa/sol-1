#include "lib/stdio.asm"

  int i;
void main(void){

  for(i = 0; i < 10; i = i + 1){
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
