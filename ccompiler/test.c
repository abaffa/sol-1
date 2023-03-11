#inc_asm "lib/stdio.asm"

int i = 5;
int *p;
int **pp;

int main() {

  printn(8 && 1);
  print("\n");
  printn(0 && 1);
  print("\n");
  printn(0 && 0);
  print("\n");
  printn(8 && 0);
  print("\n");
  printn(8 && 2);
  print("\n");
  printn(98 && 4);
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