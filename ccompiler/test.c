#inc_asm "lib/stdio.asm"

enum e1 {E1, E2, E3};
int j=2;
char *s = "Hello";

int main() {
  int i;

  printn(1 == 1);
  print("\n");
  printn(10 == 1);
  print("\n");
  printn(1 != 1);
  print("\n");
  printn(10 != 1);
  print("\n");

  printn(1 < 10);
  print("\n");
  printn(20 < 10);
  print("\n");
  printn(1 <= 10);
  print("\n");
  printn(10 <= 10);
  print("\n");
  printn(20 <= 10);
  print("\n");


  printn(10 >1);
  print("\n");
  printn(1 > 10);
  print("\n");
  printn(10 >= 1);
  print("\n");
  printn(10 >= 10);
  print("\n");
  printn(1 >= 10);
  print("\n");


  print("HEllo");

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