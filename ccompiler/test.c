#include "lib/stdio.asm"

// it would be best to create a text area
// and parse the global  data directly there
// and then at the end copy that into the final
// asm file.
// this way we can parse directly

// for matrices, need to create the data label and also the pointer
// so we can make matrices just like pointers


int main() {
    int n;
    n = 10000; // number of rows and columns
    int i, j;

    // Generate the pattern
    for (i = 1; i <= n; i++) {
        for (j = 1; j <= n; j++) {
            if ((i+j) % 2 == 0) {
                print(" ");
                printn(i*j);
            } else {
                print(" ");
                printn(i+j);
            }
        }
        print("\n");
    }

    return 0;
}

void printarray(int a[4][4]){
  int i, j;
  for(i=0;i<4;i++){
    for(j=0;j<4;j++){
      printn(a[i][j]);
      print("\n");
    }
  }
  return;
}

int main() {
    printarray(a);
    return 0;
}

void printn(int n){
  asm{
    mov a, @n
    call print_u16d
  }
  return;
}

void print(char *s){
    asm{
        mov a, @s
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
