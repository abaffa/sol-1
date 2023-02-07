#include "lib/stdio.asm"

void main(void){
  int i;

  i = 1 << 3;

  asm{
    mov a, @i
    swp a
    call print_u16d
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
