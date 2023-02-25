#include "lib/stdio.asm"

#define CELLS 20
#define GENERATIONS 20

int state[CELLS];   // initial state, all cells are 0
int next_state[CELLS];

int main() {
   int i;
   int j;

   // set the middle cell to 1 in the initial state
   state[CELLS / 2] = 1;

   // print the initial state
   for (i = 0; i < CELLS; i++) {
      printn(state[i]);
   }
   print("\n");

   for (j = 1; j < GENERATIONS; j++) {
      for (i = 1; i < CELLS - 1; i++) {
         // calculate the next state of cell i based on its neighbors
         next_state[i] = state[i - 1] ^ state[i + 1];
      }
      // copy the next state to the current state
      for (i = 1; i < CELLS - 1; i++) {
         state[i] = next_state[i];
      }
      // print the current state
      for (i = 0; i < CELLS; i++) {
         printn(state[i]);
      }
      print("\n");
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
    asm{
        mov b, @n
        call print_u8d
    }
    return;
}