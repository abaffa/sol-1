#include "lib/stdio.asm"

// it would be best to create a text area
// and parse the global  data directly there
// and then at the end copy that into the final
// asm file.
// this way we can parse directly

char m[10][10];
char *ss = "\n";

void main(void){
  int i, j;

  for(i=0; i<10; i++){
    for(j=0; j<10; j++){
      m[i][j] = i+j;
    }
  }

  for(i=0; i<10; i++){
    for(j=0; j<10; j++){
      print_nbr(m[i][j]);
    }
  }

   return;
}


void print_nbr(int n){
  asm{
    mov a, @n
    call print_u16d
    mov a, @ss
    mov d, a
    call puts
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
