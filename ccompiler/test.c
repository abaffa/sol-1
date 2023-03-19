#inc_asm "lib/stdio.asm"
#include "stdio.c"

int main() {
  int i = 65535;
  int i2 = 'A';
  char c = 72;
  char c2 = 'B';

  print_num((char*)i);
  print("\n");
}




/*

ARGUMENTS
  char
  char
  ptr
  pc
  bp
  char << BP (local variables go here)

*/