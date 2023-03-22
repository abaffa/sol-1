#inc_asm "lib/stdio.asm"
#include "stdio.c"

char clear[8] = {27, '[', '2', 'J', 27, '[', 'H', 0};

void main(void){
  print(clear);
}