#include "lib/stdio.asm"

// it would be best to create a text area
// and parse the global  data directly there
// and then at the end copy that into the final
// asm file.
// this way we can parse directly

// for matrices, need to create the data label and also the pointer
// so we can make matrices just like pointers

#define WIDTH 20
#define HEIGHT 20

// Global arrays to hold the current and next states of the game grid
int curr_state[HEIGHT][WIDTH];
int next_state[HEIGHT][WIDTH];

int main() {
    int i;
    int j;
    int ni;
    int nj;
    int count;
    int n;
    n = 0;
    // Copy the current state of the grid to the next state
    for (i = 0; i < 20; i++) {
        for (j = 0; j < 20; j++) {
            curr_state[i][j] = n;
            n++;
        }
    }

    for (i = 0; i < 20; i++) {
        for (j = 0; j < 20; j++) {
            next_state[i][j] = curr_state[i][j] ;
        }
    }
    for (i = 0; i < 20; i++) {
        for (j = 0; j < 20; j++) {
          printn(curr_state[i][j]);
          print("\n");
        }
    }
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
