#include "lib/stdio.asm"

int main() {
    int n; // start with 100
    
    print("Starting number: ");
    asm{
        call scan_u16d
        mov @n, a
    }

    while (n != 1) {
        printn(n);
        print(", ");
        if (n % 2 == 0) { // if even, divide by 2
            n = n / 2;
        } else { // if odd, multiply by 3 and add 1
            n = 3 * n + 1;
        }
    }
    print("Final number: ");
    printn(n); // print the final 1
    print("\n");
    return 0;
}

void print(char *s){
    asm{
        mov a, @s
        mov d, a
        call puts
    }
    return;
}

void printn(int n){
    asm{
        mov a, @n
        call print_u16d
    }
    return;
}