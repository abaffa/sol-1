#inc_asm "lib/stdio.asm"

char s1[50] = {'H','e','l','l','o',0};
char *s2 = ". My name is Sol-1.";

int main() {

    print("Destination: ");
    print(s1);
    print("\n");
    print("Source: ");
    print(s2);
    print("\n");

    print("Concatenation: ");
    _strcat(s1, s2);
    print(s1);

    print("\n");

  return 0;
}

int _strlen(char *str) {
    int length;
    length = 0;
    
    while (*(str+length) != 0) {
        length++;
    }
    
    return length;
}

char *_strcat(char *dest, char *src) {
    int dest_len;
    int i;
    dest_len = _strlen(dest);
    
    for (i = 0; *(src+i) != 0; i++) {
        *(dest+dest_len + i) = *(src+i);
    }
    *(dest+dest_len + i) = 0;
    
    return dest;
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
