#inc_asm "lib/stdio.asm"

#define ROWS 24
#define COLS 80

void print(char *s){
    asm{
        mov a, @s
        mov d, a
        call puts
    }
    return;
}
int main() {
    int i, j;
    int count;
    count = 0;
    char screen[ROWS][COLS];
    char k;

    // Initialize the screen to spaces
    for (i = 0; i < ROWS; i++) {
        for (j = 0; j < COLS; j++) {
            screen[i][j] = ' ';
        }
    }

    // Generate the pattern
    while (1) {
        for (i = 0; i < ROWS; i++) {
            for (j = 0; j < COLS; j++) {
                if (i == count % ROWS && j == count % COLS) {
                    screen[i][j] = '.';
                } else {
                    screen[i][j] = ' ';
                }
            }
        }
        // Print the screen to the terminal
        for (i = 0; i < ROWS; i++) {
            for (j = 0; j < COLS; j++) {
                k = screen[i][j];
                asm{
                    mov a, @k
                    swp a
                    call putchar
                }
            }
            print("\n");
        }
        count++;
    }

    return 0;
}
