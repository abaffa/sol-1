#include "lib/stdio.asm"

#define WIDTH 20
#define HEIGHT 20

// Global arrays to hold the current and next states of the game grid
int curr_state[HEIGHT][WIDTH];
int next_state[HEIGHT][WIDTH];

// Function to initialize the game grid with a pattern
void init_game() {
    curr_state[4][4] = 1;
    curr_state[4][5] = 1;
    curr_state[4][6] = 1;
    curr_state[3][6] = 1;
    curr_state[2][5] = 1;
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

// Function to print out the current state of the game grid
void print_game() {
    int i;
    int j;

    for (i = 0; i < HEIGHT; i++) {
        for (j = 0; j < WIDTH; j++) {
            if (curr_state[i][j]) {
                print("* ");
            } else {
                print(". ");
            }
        }
        print("\n");
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

    // Copy the current state of the grid to the next state
    for (i = 0; i < HEIGHT; i++) {
        for (j = 0; j < WIDTH; j++) {
            next_state[i][j] = curr_state[i][j];
        }
    }

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

            // Apply the rules of the game to update the next state
            if (curr_state[i][j]) {
                if (count < 2 || count > 3) {
                    next_state[i][j] = 0;
                }
            } else {
                if (count == 3) {
                    next_state[i][j] = 1;
                }
            }
        }
    }

    // Copy the next state back to the current state
    for (i = 0; i < HEIGHT; i++) {
        for (j = 0; j < WIDTH; j++) {
            curr_state[i][j] = next_state[i][j];
        }
    }
    return;
}

int main() {
    int i;

    // Initialize the game grid with a pattern
    init_game();

    // Run the game for 10 generations
    for (i = 0; i < 10; i++) {
        // Print out the current state of the game grid
        print_game();

        // Update the game grid for the next generation
        update_game();
    }

    return 0;
}
