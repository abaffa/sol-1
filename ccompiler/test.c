#include "lib/stdio.asm"

// it would be best to create a text area
// and parse the global  data directly there
// and then at the end copy that into the final
// asm file.
// this way we can parse directly

char *h = "Hello World";


void main(void){
  asm{
    mov a, @h
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
