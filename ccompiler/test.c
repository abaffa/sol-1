#include "lib/stdio.asm"

int g;

void main(void) {


  return;

}

int test(char p1, char p2){
  char i;

  asm{
    mov a, $i
    mov $i, a
    mov a, $p1
    mov $p1, a
  }
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
