#inc_asm "lib/stdio.asm"

int main() {
int m[10];

  m;


    return 0;
}


// Test functions
int add(int x, int y) {
    return x + y;
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