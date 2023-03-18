#inc_asm "lib/stdio.asm"

char s[8] = {27, '[', '2', 'J', 27, '[', 'H', 0};
int snake_x[100], snake_y[100];
int snake_len = 1;
int dx = 1, dy = 0;

void draw_board() {
    int x, y;
    int i;
    char c;
    print(s);

    for (y = 0; y < 20; y++) {
        for (x = 0; x < 40; x++) {
             c = ' ';

            if (x == 0 || x == 40 - 1 || y == 0 || y == 20 - 1) {
                c = '#';
            } else {
                for (i = 0; i < snake_len; i++) {
                    if (x == snake_x[i] && y == snake_y[i]) {
                        c = i == 0 ? 'O' : 'o';
                        break;
                    }
                }
            }

            _putchar(c);
        }
        _putchar('\n');
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
void _putchar(char c){
  asm{
    mov al, @c
    mov ah, al
    call putchar
  }
  return;
}
void update_snake() {
    int i;
    for (i = snake_len - 1; i > 0; i--) {
        snake_x[i] = snake_x[i - 1];
        snake_y[i] = snake_y[i - 1];
    }

    snake_x[0] = snake_x[0] + dx;
    snake_y[0] = snake_y[0] + dy;

    if (snake_x[0] <= 0 || snake_x[0] >= 40 - 1 || snake_y[0] <= 0 || snake_y[0] >= 20 - 1) {
        if (dx == 1) {
            dx = 0;
            dy = 1;
        } else if (dy == 1) {
            dx = -1;
            dy = 0;
        } else if (dx == -1) {
            dx = 0;
            dy = -1;
        } else if (dy == -1) {
            dx = 1;
            dy = 0;
        }
    }
    return;
}

int main() {

    snake_x[0] = 40 / 2;
    snake_y[0] = 20 / 2;

    while (1) {
        draw_board();
        update_snake();
    }

    return 0;
}
