#include "lib/stdio.asm"


void main(void) {
  asm{
    call scan_u16d
    syscall sys_bkpt
    call print_u16d
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
