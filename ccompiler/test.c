#include "lib/stdio.asm"

void main(void){
  char m[10][10];
  int i, j;

  for(i = 0; i < 10; i++){
    for(j = 0; j < 10; j++){
      m[i][j] = 'A' + j;
      asm{}
      f1(m[i][j]);
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
  return;
}

void f1(char c){

  asm{
    mov al, @c;
    mov ah, al
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
