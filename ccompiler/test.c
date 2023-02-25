#include "lib/stdio.asm"

// it would be best to create a text area
// and parse the global  data directly there
// and then at the end copy that into the final
// asm file.
// this way we can parse directly

// for matrices, need to create the data label and also the pointer
// so we can make matrices just like pointers

    int n;
    int i;
int main() {

    print("Enter the number of triangular numbers to generate: ");
    asm{
      call scan_u16d
      mov @n, a
    }

    for (i = 1; i < n; i++) {
    asm{
        mov a, @i
        call print_u16d
        mov ah, $0A
        call putchar
    }
    }

    return 0;
}

void print(char *s){
    asm{
        mov a, @s
        mov d, a
        call puts
    }
    return;
}
void printn(int n){
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
