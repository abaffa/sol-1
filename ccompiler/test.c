#inc_asm "lib/stdio.asm"

int m1[10] = {123, 111, 123};
int m2[10] = {0, 1, 2};

int main() {
  int i, j,k;
  i = 100;
  j = 50;
  k = 5;

  printn(i / (j / k));
  //printn(m1[m2[0]]);

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
