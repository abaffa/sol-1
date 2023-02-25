#include "lib/stdio.asm"

#define WIDTH 20
#define HEIGHT 20

// Global arrays to hold the current and next states of the game grid
int curr_state[HEIGHT][WIDTH];
int next_state[HEIGHT][WIDTH];


void print(char *s){
    asm{
        mov a, @s
        mov d, a
        call puts
    }
    return;
}


// Function to update the game grid for the next generation
void update_game() {
    int i;
    int j;
    int ni;
    int nj;
    int count;


    // Update the next state based on the current state
    for (i = 1; i < HEIGHT; i++) {
        for (j = 1; j < WIDTH; j++) {
            // Count the number of live neighbors for the current cell
            count = 0;
            for (ni = i-1; ni <= i+1; ni++) {
                for (nj = j-1; nj <= j+1; nj++) {
                    if (ni >= 0 && ni < HEIGHT && nj >= 0 && nj < WIDTH) {
                        if (ni != i || nj != j) {
                            count =count+ curr_state[ni][nj];
                        }
                    }
                }
            }

        }
    }

    return;
}

int main() {

        update_game();

    return 0;
}
