#inc_asm "lib/stdio.asm"

int aarr[10] = {1,1,1,1,1,1,1,1,1,1};
int barr[10] = {2,2,2,2,2,2,2,2,2,2};

int main() {
  int a, b, c;
  a = 1;
  b = 100;

  c = b - (a * 10);

  printn(c);

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