#include "lib/stdio.asm"
int g;

void main(void) {

  asm{
    mov $g, a
    mov a, $g
  }

  return;

}

int test(int ii){

  asm{
    mov a, $ii
    mov $ii, a
  }

  return ii;
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
