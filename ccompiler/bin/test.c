#include "lib/kernel.exp"
#include "lib/stdio.asm"

char mychar = 'a';
char *p;

int main(void) {

  p = &mychar;

  *p = 'b';


  return;
}


/*

ARGUMENTS
  char
  int
  int
  pc
  bp
  locals <<< BP

*/
