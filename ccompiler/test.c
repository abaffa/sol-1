#include "lib/stdio.asm"

// it would be best to create a text area
// and parse the global  data directly there
// and then at the end copy that into the final
// asm file.
// this way we can parse directly

int current[10];
int SIZE = 2;

void main() {
    int left;
    int i;

    current[0] = 12;
    current[1] = 15;

    i = 10;

    left = (i == 0) ? current[SIZE - 1] : current[SIZE - 2];

    print_nbr(left);


    return;
}


void print_nbr(int n){
  asm{
    mov a, @n
    call print_u16d
  }
  return;
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
