#include "lib/stdio.asm"

// it would be best to create a text area
// and parse the global  data directly there
// and then at the end copy that into the final
// asm file.
// this way we can parse directly


void main() {

  prints("Hello World");
  prints("Hello World2");
  prints("Hello World3");

  return;

}


void prints(char *s){

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
