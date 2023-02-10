#include "lib/stdio.asm"

char **p[2];
char **pp;
char *s = "Enter the number of rows: ";

void main(void){
    p[0] = &s;
asm{}
    pp = p[0];

    asm{
      mov a, @pp
      mov d, a
      mov a, [d]
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