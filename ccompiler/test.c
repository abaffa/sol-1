#include "lib/stdio.asm"

int i = 54;
int j = 33;

void main(void) {
  asm{
    call scan_u16d
    mov $i, a
  }

  switch(i){
    case 1:
      i = 1;
      print();
      break;
    case 2:
      i = 2;
      print();
      break;

    default:
      i = 3;
      print();
  }

  return;

}
char *ss = "Hello World";

void print(void){
  asm{
    mov a, $i
    call print_u16d
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
