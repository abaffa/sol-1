#inc_asm "lib/stdio.asm"


int main() {
  print_num(10000 >> 2);
}

int mod_exp(int base, int exp, int mod) {
    int result = 1;
    while (exp > 0) {
        if (exp & 1) {
            result = (result * base) % mod;
        }
        exp = exp >> 1;
        base = (base * base) % mod;
    }
    return result;
}
void _gets(char *s){
  asm{
    mov a, @s
    mov d, a
    call gets
  }
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
}

void _putchar(char c){
  asm{
    mov al, @c
    mov ah, al
    call putchar
  }
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