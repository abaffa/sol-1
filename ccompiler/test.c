#include "lib/stdio.asm"

char *s = "\n";

void main(void){
  
  int i;
  int j;

  for(i=2; ; i++){
    j = fact(i);
    asm{
      mov a, @j
      call print_u16d

      mov a, @s
      mov d, a
      call puts
    }
  }


  return;
}

int fact(int n){
  int nn;
  if(n == 1) return 1;
  else{
    nn = n * fact(n - 1);
    return nn;
  }
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
