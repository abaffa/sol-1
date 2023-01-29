#include "lib/stdio.asm"

enum e1 {E1, E2, E3};

char* s1 = "Hello World";
char** p;
char* s2;

void main(void) {
  p = &s1;
  s2 = *p;

  asm{
    mov a, $s2
    mov d, a
    call puts
  }

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
