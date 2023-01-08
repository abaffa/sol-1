#include "lib/stdio.asm"



int main(void) {
    test(5, 10, 15);

  asm{
    syscall sys_terminate_proc
  }
}

void test(char c, int i, int k){
  int ii;
  char d;
  int jj;


  c = 'a';

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
