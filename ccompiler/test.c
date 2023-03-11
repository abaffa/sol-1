#inc_asm "lib/stdio.asm"

int matrix[20];

int main() {
  int i;
  int j;
  int m[10];

  for(i=0;i<20;i++){
    matrix[i] = i;
  }

  j = 0;
  m[5] = 1;
  m[6] = 1;


  for(i=1;i<=20;i++){
    printn(matrix[i-1 + j + m[5] - m[6]]);
    print("\n");
  }

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