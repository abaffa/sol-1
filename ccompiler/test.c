#include "lib/stdio.asm"

// it would be best to create a text area
// and parse the global  data directly there
// and then at the end copy that into the final
// asm file.
// this way we can parse directly

int cc[100] = {11, 22, 33, 44};
char *mp[5] = {222, 123, 44};
int matrix[10] = {1,2,3};
char *m= "\n";

void main(void){
  int i;

  for(i=0; i<100; i++){
    print(cc[i]);
  }
   return;
}


void print(int nbr){
  asm{
    TESTME:
      mov a, @nbr
      call print_u16d
      mov a, @m
      mov d, a
      call puts
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