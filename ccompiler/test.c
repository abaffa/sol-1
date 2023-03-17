#inc_asm "lib/stdio.asm"


int main() {
  int i;
  i=100;
  i=i - 1;
  print_num(i);

  return 0;
}

void _gets(char *s){
  asm{
    mov a, @s
    mov d, a
    call gets
  }
  return;
}

int _strlen(char str[1]) {
    int length;
    length = 0;
    
    while (str[length] != 0) {
        length++;
    }
    
    return length;
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