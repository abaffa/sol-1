#include "lib/stdio.asm"


int i, j;

int main(void) {
    i = 50;
    j = 100;
    test(i , j);

  asm{
    syscall sys_terminate_proc
  }
}

void test(int i, int j){
  int ii;
  return i+j;
}
