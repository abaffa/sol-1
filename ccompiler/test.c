#include "lib/stdio.asm"

// it would be best to create a text area
// and parse the global  data directly there
// and then at the end copy that into the final
// asm file.
// this way we can parse directly

// for matrices, need to create the data label and also the pointer
// so we can make matrices just like pointers

int aa = 233;
int *p = 444;
char ss[4]={'a', 22};
char *s = "Hello";
int *ii[2] = {45, 22};
char c = 'A';

int current_gen[ROWS][COLS];
int next_gen[ROWS][COLS];

void initialize_cells() {
    int row;
    int col;

    // Initialize the cells to a simple pattern
    for (row = 0; row < ROWS; row++) {
        for (col = 0; col < COLS; col++) {
            if (row == 2 && col >= 2 && col <= 6) {
                current_gen[row][col] = 1;
            } else {
                current_gen[row][col] = 0;
            }
        }
    }
}
void main() {

  int i[10];
  i;

  return;

}


void prints(){
  int i;
  i = 23;
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
