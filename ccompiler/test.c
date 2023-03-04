#inc_asm "lib/stdio.asm"

int m[50] = {123, 111, 123};
char *s2 = ". My name is Sol-1.";
char *c = "hi";

int main() {

  &m;

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


void printn(int n){
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
