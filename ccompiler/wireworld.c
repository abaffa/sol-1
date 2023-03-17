#inc_asm "lib/stdio.asm"

enum CellState {
    EMPTY,
    CONDUCTOR,
    ELECTRON_HEAD,
    ELECTRON_TAIL
};

int grid[20][40];
int new_grid[20][40];

void print_grid() {
    int y;
    int x;
    char c;
    for (y = 0; y < 20; ++y) {
        for (x = 0; x < 40; ++x) {
            switch (grid[y][x]) {
                case EMPTY: c = ' '; break;
                case CONDUCTOR: c = '.'; break;
                case ELECTRON_HEAD: c = '@'; break;
                case ELECTRON_TAIL: c = '#'; break;
            }
            _putchar(c);
        }
        _putchar('\n');
    }
    return;
}

void iterate() {
    int x, y, dx, dy;
    int nx, ny;
    int head_count;
    for (y = 0; y < 20; ++y) {
        for (x = 0; x < 40; ++x) {
            head_count = 0;
            for (dy = -1; dy <= 1; ++dy) {
                for (dx = -1; dx <= 1; ++dx) {
                    if (dx == 0 && dy == 0) continue;
                    nx = x + dx;
                    ny = y + dy;
                    if (nx >= 0 && nx < 40 && ny >= 0 && ny < 20 && grid[ny][nx] == ELECTRON_HEAD) {
                        ++head_count;
                    }
                }
            }

            switch (grid[y][x]) {
                case EMPTY: new_grid[y][x] = EMPTY; break;
                case CONDUCTOR: new_grid[y][x] = (head_count == 1 || head_count == 2) ? ELECTRON_HEAD : CONDUCTOR; break;
                case ELECTRON_HEAD: new_grid[y][x] = ELECTRON_TAIL; break;
                case ELECTRON_TAIL: new_grid[y][x] = CONDUCTOR; break;
            }
        }
    }

    for (y = 0; y < 20; ++y) {
        for (x = 0; x < 40; ++x) {
            grid[y][x] = new_grid[y][x];
        }
    }
    return;
}

int main() {
    // Add an oscillator
    grid[5][5] = CONDUCTOR;
    grid[6][5] = ELECTRON_HEAD;
    grid[7][5] = CONDUCTOR;
    grid[6][6] = ELECTRON_TAIL;
    grid[6][7] = CONDUCTOR;

    while (1) {
        print_grid();
        iterate();
    }

    return 0;
}

void _putchar(char c){
  asm{
    mov al, @c
    mov ah, al
    call putchar
  }
  return;
}

int scann(){
  int m;
  asm{
    call scan_u16d
    mov @m, a
  }
  
  return m;
}

void print(char *s){
    asm{
        mov a, @s
        mov d, a
        call puts
    }
    return;
}