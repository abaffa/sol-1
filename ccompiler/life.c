#inc_asm "lib/stdio.asm"
//#include <stdio.h>

#define SIZE 30

// Global arrays to hold the current and next states of the game grid
int curr_state[SIZE][SIZE] = {
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,1,1,1,1,1,0,0,0,0,1,1,0,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,
0,0,0,1,1,0,0,0,0,1,0,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,
0,0,1,1,1,0,1,1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,
0,0,0,1,1,0,1,0,0,1,0,0,0,1,1,1,1,1,0,0,0,0,0,1,0,0,1,0,0,0,
0,0,0,1,0,0,1,0,0,1,1,0,0,0,1,0,0,1,1,1,0,0,0,1,0,0,1,0,0,0,
0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,
0,0,0,1,0,0,0,0,0,0,1,1,0,1,1,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,
0,0,0,1,1,1,1,1,0,0,0,0,1,1,0,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,
0,0,0,1,1,0,0,0,0,1,0,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,
0,0,1,1,1,0,1,1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,
0,0,0,1,1,0,1,0,0,1,0,0,0,1,1,1,1,1,0,0,0,0,0,1,0,0,1,0,0,0,
0,0,0,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,
0,0,0,1,1,1,1,1,0,0,0,0,1,1,0,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,
0,0,0,1,1,0,0,0,0,1,0,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,
0,0,0,1,1,1,1,1,0,0,0,0,1,1,0,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,
0,0,0,1,1,0,0,0,0,1,0,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,
0,0,1,1,1,0,1,1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,
0,0,0,1,1,0,1,0,0,1,0,0,0,1,1,1,1,1,0,0,0,0,0,1,0,0,1,0,0,0,
0,0,0,1,1,0,1,0,0,1,0,0,0,1,1,1,1,1,0,0,0,0,0,1,0,0,1,0,0,0,
0,0,0,1,1,0,1,0,0,1,0,0,0,1,1,1,1,1,0,0,0,0,0,1,0,0,1,0,0,0,
0,0,0,1,1,0,1,0,0,1,0,0,0,1,1,1,1,1,0,0,0,0,0,1,0,0,1,0,0,0,
0,0,0,1,1,0,1,0,0,1,0,0,0,1,1,1,1,1,0,0,0,0,0,1,0,0,1,0,0,0,
0,0,0,1,1,1,1,1,0,0,0,0,1,1,0,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,
0,0,0,1,1,0,0,0,0,1,0,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,
0,0,1,1,1,0,1,1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,
0,0,0,1,1,0,1,0,0,1,0,0,0,1,1,1,1,1,0,0,0,0,0,1,0,0,1,0,0,0,
0,0,1,1,1,0,1,1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,
0,0,0,1,1,0,1,0,0,1,0,0,0,1,1,1,1,1,0,0,0,0,0,1,0,0,1,0,0,0
};

int next_state[SIZE][SIZE];

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
//    printf("%s", s);
    asm{
        mov a, @s
        mov d, a
        call puts
    }
    
    return;
}

int getn(){
    int n;
    asm{
        call scan_u16d
        mov @n, a
    }
    return n;
}

// Function to print out the current state of the game grid
void print_game() {
    int i;
    int j;

    for (i = 0; i < SIZE; i++) {
        for (j = 0; j < SIZE; j++) {
            if (curr_state[i][j]) {
                print("@ ");
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
    for (i = 0; i < SIZE; i++) {
        for (j = 0; j < SIZE; j++) {
            next_state[i][j] = curr_state[i][j];
        }
    }

    // Update the next state based on the current state
    for (i = 1; i < SIZE-1; i++) {
        for (j = 1; j < SIZE-1; j++) {
            // Count the number of live neighbors for the current cell
            count = 0;
            for (ni = i-1; ni <= i+1; ni++) {
                for (nj = j-1; nj <= j+1; nj++) {
                    if (ni < SIZE && nj < SIZE) {
                        if (ni != i || nj != j) {
                            count = count + curr_state[ni][nj];
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
    for (i = 0; i < SIZE; i++) {
        for (j = 0; j < SIZE; j++) {
            curr_state[i][j] = next_state[i][j];
        }
    }
    return;
}

int main() {
    int i;
    int n;

    print("Generations: ");
    n = getn();
    // Initialize the game grid with a pattern
    init_game();

    // Run the game for 10 generations
    for (i = 0; i < n; i++) {
        // Print out the current state of the game grid
        asm{
            mov d, s_telnet_clear
            call puts
        }
        print_game();

        // Update the game grid for the next generation
        update_game();
    }

    return 0;
}
