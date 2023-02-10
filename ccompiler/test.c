#include "lib/stdio.asm"

void main(void){
  int i;

  for(i = 0; i < 65535; i++){
    print(i);
  }

  return;
}

void print(int n){
  asm{
    mov a, @n
    call print_u16d

    mov ah, $0A
    call putchar
    mov ah, $0D
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
