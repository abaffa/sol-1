#include "lib/stdio.asm"

void main(){
    int n;
    int result;

    print("Factorial of: ");
    n = getn();

    result = fact(n);

    print("\nResult: ");
    printn(result);
    print("\n");

    return;

}

int fact(int n){
    if(n == 1) return 1;
    else return n*fact(n-1);
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

int getn(){
    int n;
    asm{
        call scan_u16d
        mov @n, a
    }
    return n;
}