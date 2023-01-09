#include "lib/stdio.asm"

int main(void) {
  test(5, 10, 15, 1);

  asm{
    syscall sys_terminate_proc
  }
}

void test(int c, int kk, int i, int k){
  int ii;
  char d = 0;
  int jj;

  for(i = 0; i < 10; i++){
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
