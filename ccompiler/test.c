#inc_asm "lib/stdio.asm"

void bubble_sort(char arr[100], int n) {
    int i, j;
    char temp;

    for (i = 0; i < n - 1; i++) {
        for (j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
    return;
}

void _gets(char *s){
  asm{
    mov a, @s
    mov d, a
    call gets
  }
  return;
}

int _strlen(char str[100]) {
    int length;
    length = 0;
    
    while (str[length] != 0) {
        length++;
    }
    
    return length;
}
int main() {
    int n, i;

    char s[100];
    print("Enter the elements of the array as a string: ");
    _gets(s);
    print("OK.\n");

    n = _strlen(s);
    print("Now sorting...\n");
    bubble_sort(s, n);

    print("Sorted array: ");
    for (i = 0; i < n; i++) {
        _putchar(s[i]);
    }
    print("\n");

    return 0;
}


void print_num(int num) {
  char digits[5];
  int i;
  i = 0;
  if(num == 0){
    _putchar('0');
    return;
  }
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

int integer_square_root(int n) {
    if (n <= 1) {
        return n;
    }

    int x;
    int y;
    x = n;
    y = (x + n / x) / 2;

    while (y < x) {
        x = y;
        y = (x + n / x) / 2;
    }

    return x;
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



/*

ARGUMENTS
  char
  char
  ptr
  pc
  bp
  char << BP (local variables go here)

*/