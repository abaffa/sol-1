#inc_asm "lib/stdio.asm"

int main() {
  signed int i;
  i = 1;
  i << 2;

  return 0;
}

void print_num(int num) {
    char digits[5];
    int i;
    i = 0;
    while (num > 0) {
        digits[i] = '0' + (num % 10);
        num = num / 10;
        i++;
    }
    // Print the digits in reverse order using putchar()
    while (i > 0) {
        i--;
        _putchar(digits[i]);
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

void scann(int *n){
  int m;
  asm{
    call scan_u16d
    mov @m, a
  }
  *n = m;
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