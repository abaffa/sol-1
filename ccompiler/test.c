#inc_asm "lib/stdio.asm"

int main() {
  int i; 
  for (i = 100; i >= 0; i--) {
    print_num(i);
    print("\n");
  }
  return;
    printn(12);
    print("\n");
    printn(1126);
    print("\n");
    printn(65535);
    print("\n");
/*
    printn(126);
    print("\n");
    printn(65535);
    print("\n");
    printn(0);
    print("\n");
*/
    return 0;
}

void printn(int number) {
  char buffer[5]; // Maximum size needed for a 16-bit decimal number
  int index;
  int i;
if (number == 0) {
    _putchar('0');
    return;
  }

  index = 0;

  // Convert the number to a string in reverse order
  while (number > 0) {
    buffer[index++] = (number % 10) + '0';
    number = number / 10;
  }

  // Print the string in the correct order
  for (i = index - 1; i >= 0; i--) {
    _putchar(buffer[i]);
  }
    return;
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