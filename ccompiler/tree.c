#inc_asm "lib/stdio.asm"

char canvas[22][80];

int main() {
    int i, j;
    int initial_angle;

    initial_angle = (90 * 1000) / 180;
    // Initialize the canvas
    for (i = 0; i < 22; i++) {
        for (j = 0; j < 80; j++) {
            canvas[i][j] = ' ';
        }
    }

    // Draw the fractal tree
    draw_tree(40, 21, initial_angle, 5, canvas);

    // Print the canvas
    for (i = 0; i < 22; i++) {
        for (j = 0; j < 80; j++) {
            _putchar(canvas[i][j]);
        }
        _putchar('\n');
    }

    return 0;
}

void draw_tree(int x, int y, int angle, int depth, char canvas[22][80]) {
    int i;
    int length_factor;
    int angle_factor;
    int x_pos, y_pos;
    int x2, y2;
    int new_angle_left;
    int new_angle_right;

    if (depth == 0) {
        return;
    }


    length_factor = 6;
    angle_factor = 5;


    x2 = x + (depth * length_factor * angle / 1000);
    y2 = y - (depth * length_factor * (1000 - angle) / 1000);
    print_num(y); print(", ");
    print_num(depth); print(", ");
    print_num(length_factor); print(", ");
    print_num(angle); print(", ");
    print_num(y2); print(", ");
    print("\n");

    if (x2 < 0 || x2 >= 80 || y2 < 0 || y2 >= 22) {
        return;
    }

    // Draw the line
    for (i = 0; i <= depth; i++) {
        x_pos = x + (i * length_factor * angle / 1000);
        y_pos = y - (i * length_factor * (1000 - angle) / 1000);

        if (x_pos >= 0 && x_pos < 80 && y_pos >= 0 && y_pos < 22) {
            canvas[y_pos][x_pos] = '*';
        }
    }

    // Recursively draw the branches
    new_angle_left = angle - angle_factor;
    new_angle_right = angle + angle_factor;
    draw_tree(x2, y2, new_angle_left, depth - 1, canvas);
    draw_tree(x2, y2, new_angle_right, depth - 1, canvas);
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

void print_num(int num) {
    int digits[5];
    int i, j;
    i = 0;

    if (num == 0) {
        _putchar('0');
        return;
    }

    if (num < 0) {
        _putchar('-');
        num = -num;
    }

    while (num > 0) {
        digits[i] = num % 10;
        num = num / 10;
        i++;
    }

    for (j = i - 1; j >= 0; j--) {
        _putchar(digits[j] + '0');
    }
    return;
}
