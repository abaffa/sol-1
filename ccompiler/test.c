#inc_asm "lib/stdio.asm"
#include "stdio.c"

int main() {
  int i = 123;
  int i2 = 'A';
  char c = 72;
  char c2 = 'B';

  print_num(i);
  print("\n");
  print_num(i2);
  print("\n");

  _putchar(c);
  print("\n");
  _putchar(c2);
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