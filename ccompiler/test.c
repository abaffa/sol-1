#include "lib/stdio.asm"

enum e1 {E1, E2, E3};
enum e2 {hello, world, haha};

char *nl = "\n\r";
int i;

void main(void) {

  do{
    asm{
      mov a, $i
      call print_u16d

      mov a, $nl
      mov d, a
      call puts
    }
  } while(i < 10);

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
