#inc_asm "lib/stdio.asm"

int m1[10] = {123, 111, 123};
int m2[10] = {0, 1, 2};

int main() {

  int i1, i2, i3, i4;
  i1=1;
  i2=1;
  i3=1;
  i4=1;

  printn(--i1);
  print("\n");
  printn(i1);
  print("\n");
  printn(++i2);
  print("\n");
  printn(i2);
  print("\n");
  printn(i3--);
  print("\n");
  printn(i3);
  print("\n");
  printn(i4++);
  print("\n");
  printn(i4);
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