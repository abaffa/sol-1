#include "lib/kernel.exp"
#include "lib/stdio.asm"

int integer = 25;
int *p;

int main(void) {

  p = &integer;

  *p = 22;


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
