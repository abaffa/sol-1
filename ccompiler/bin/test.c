#include "lib/stdio.asm"



int main(void) {
    test(5, 10);

  asm{
    syscall sys_terminate_proc
  }
}

void test(char i, int j){
  int ii; char c;
  int jj;
  ii = 1;
  c = 2;
  jj = 3;
  i = 2;
  j = 3;
  return;
}

/*

ARGUMENTS
  char
  int
  int
  int
  pc
  bp
  locals <<< BP

*/
