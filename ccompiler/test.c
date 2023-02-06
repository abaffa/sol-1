#include "lib/stdio.asm"

void main(void){
  char m[10][10];
  int i, j;

  for(i = 0; i < 10; i++){
    for(j = 1; j < 10; j++){
      m[i][j] = 'A';
    }

  }

  return;
}

void _puts(char *string){
  asm{
    mov a, @string
    mov d, a
    swp a
    call puts
  }
}

void f1(char c[10][10]){
  char cc;

  cc = c[1][0];
  asm{
    mov a, @cc;
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
