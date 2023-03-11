#inc_asm "lib/stdio.asm"

int m[10];

int main() {

  m[0] = 2;
  m[1] = 1;

  m[m[0]] = 55;
  m[m[0] + m[1]] = 77;

  printn(m[m[0]]);
  print("\n");
  printn(m[m[0] + m[1]]);
  print("\n");


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