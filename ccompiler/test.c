#include "lib/stdio.asm"

// it would be best to create a text area
// and parse the global  data directly there
// and then at the end copy that into the final
// asm file.
// this way we can parse directly


void main() {
  int i;

  for(i =0; i<65535;i++){
    prints("Hello World: ", i);
  }
  return;

}


void prints(char *s, int i){
  asm{
    mov a, @s
    mov d, a
    call puts
    mov a, @i
    call print_u16d

    mov ah, $0A
    call putchar
    mov ah, $0D
    call putchar
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
