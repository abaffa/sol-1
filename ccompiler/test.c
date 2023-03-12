#inc_asm "lib/stdio.asm"

int ROWS= 20;
int COLS= 40;

void display_board(int board[20][40]) {
  int i,j;
    for (i = 0; i < ROWS; i++) {
        for (j = 0; j < COLS; j++) {
            print(board[i][j] ? "X" : " ");
        }
        print("\n");
    }
}

    int new_board[20][40];
void update_board(int board[20][40]) {
  int dx, dy;
  int i,j;
  int count;
  int x;
  int y;
    for (i = 0; i < ROWS; i++) {
        for ( j = 0; j < COLS; j++) {
            count = 0;
            // Count the number of neighbors that are "on"
            for (dx = -1; dx <= 1; dx++) {
                for (dy = -1; dy <= 1; dy++) {
                    if (dx == 0 && dy == 0) {
                        continue;
                    }
                    x = i + dx;
                    y = j + dy;
                    if (x < 0) {
                        x = ROWS - 1;
                    } else if (x >= ROWS) {
                        x = 0;
                    }
                    if (y < 0) {
                        y = COLS - 1;
                    } else if (y >= COLS) {
                        y = 0;
                    }
                    if (board[x][y]) {
                        count++;
                    }
                }
            }
            if (board[i][j]) {
                // If the cell is "on", it becomes "dying"
                new_board[i][j] = 2;
            } else if (count == 2) {
                // If the cell has exactly 2 neighbors that are "on", it becomes "on"
                new_board[i][j] = 1;
            }
        }
    }
    // Update the board with the new values
    for (i = 0; i < ROWS; i++) {
        for (j = 0; j < COLS; j++) {
            board[i][j] = new_board[i][j];
        }
    }
}

    int board[20][40];
int main() {
  int i,j;
    // Initialize the board with random values
    for (i = 0; i < ROWS; i++) {
        for (j = 0; j < COLS; j++) {
            board[i][j] = i+j % 2;
        }
    }
    // Run the simulation for a certain number of iterations
    for (i = 0; i < 10; i++) {
        printn("Iteration :", i+1);
        print("\n");
        display_board(board);
        update_board(board);
    }
    return 0;
}


void scann(int *n){
  int m;
  asm{
    call scan_u16d
    mov @m, a
  }
  *n = m;
  return;
}


void printn(char *s, int n){
  print(s);
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