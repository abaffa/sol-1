#inc_asm "lib/stdio.asm"

char **s[4][4]={1,2, "Helo"};
int **i[1]={22};

int main() {
  int a;

  scann(&a);

  switch(a){
    case 1:
      printn(1);
      break;
    case 2:
      printn(2);
      break;
    default:
      printn(99);
  }



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
