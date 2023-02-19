#include "lib/stdio.asm"

// it would be best to create a text area
// and parse the global  data directly there
// and then at the end copy that into the final
// asm file.
// this way we can parse directly

char kk;
char *mp[5] = {10};
int matrix[10] = {1,2,3};

void main(void){
  int i;

   return;
}


void print(int nbr){
  asm{
    mov a, @nbr
    call print_u16d
    mov ah, $0A
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