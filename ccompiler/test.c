#include "lib/stdio.asm"

int i = 54;
int j = 99;

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
      switch(j){
        case 33:
          i = 33;
          print();
          break;
        case 22:
          i = 22;
          print();
          break;
        default:
          i = 88;
          print();
          break;
      }
  }

  return;

}

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
