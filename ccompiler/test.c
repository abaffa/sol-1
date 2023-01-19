#include "lib/stdio.asm"

int i;

void main(void) {
  asm{
    mov al, 12
    call print_u8d
      syscall sys_terminate_proc
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
