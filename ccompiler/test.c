#include "lib/stdio.asm"

// it would be best to create a text area
// and parse the global  data directly there
// and then at the end copy that into the final
// asm file.
// this way we can parse directly

char c[3] = {255, 254, 253};

int matrix[100] = {1,2,3};
char *m= "hello";

void main(void){

    asm{
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