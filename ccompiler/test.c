#include "lib/stdio.asm"

// it would be best to create a text area
// and parse the global  data directly there
// and then at the end copy that into the final
// asm file.
// this way we can parse directly

// for matrices, need to create the data label and also the pointer
// so we can make matrices just like pointers

int aa = 233;
int *p = 444;
char *ss[4]={'a', 22};
char *s = "Hello";
int *ii[2] = {45, 22};

void main() {

  *s;

  return;

}


void prints(){
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
