#inc_asm "lib/stdio.asm"

char s1[50] = {'H','e','l','l','o',0};
char *s2 = ". My name is Sol-1.";

void main() {

 //_strcat(s1, s2);
  //printn(_strlen(s1));

  return;
}

int _strlen(char *str) {
    int length;
    
    *str;
    
}
/*
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
*/



/*

ARGUMENTS
  char
  char
  ptr
  pc
  bp
  char << BP (local variables go here)

*/
