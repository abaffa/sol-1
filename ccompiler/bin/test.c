#include "lib/kernel.exp"
#include "lib/stdio.asm"

char mychar = 'a';
char *p;

int i1, i2;

int main(void) {

  i1 = 1+2*3+5;

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
