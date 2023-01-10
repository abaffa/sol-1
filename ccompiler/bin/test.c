#include "lib/kernel.exp"
#include "lib/stdio.asm"

int integer = 25;
char *s = "hello world";

int main(void) {
  int *p;

  p = &integer + 1;


  asm{
    syscall sys_terminate_proc
  }

  return;
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
