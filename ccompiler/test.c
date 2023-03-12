#inc_asm "lib/stdio.asm"

int anarr[10] = {1,1,1,1,1,1,1,1,1,1};
int bnarr[10] = {2,2,2,2,2,2,2,2,2,2};

int main() {
  int swappos;
for (swappos = 0; swappos < 10; swappos++) {
  anarr[swappos] = anarr[swappos] + bnarr[swappos];
  bnarr[swappos] = anarr[swappos] - bnarr[swappos];
  anarr[swappos] = anarr[swappos] - bnarr[swappos];
}


for (swappos = 0; swappos < 10; swappos++) {
  printn(anarr[swappos]);
  print(" : ");
  printn(bnarr[swappos]);
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