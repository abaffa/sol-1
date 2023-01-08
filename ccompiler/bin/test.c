#include "lib/stdio.asm"



int main(void) {
    test(5, 10);

  asm{
    syscall sys_terminate_proc
  }
}

void test(char c, int j, int k){
  int ii;

  ii = 56;

  c = 1;
  j = 2;
  k = 3;

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
