#inc_asm "lib/stdio.asm"

int index = 0;

void assert(int i){
  if(i) print("Passed.");
  else print("FAILED.");
  printn("Index: ", index);
  print("\n");
  index++;
  return;
}

int main() {
    // Test variables
    int a;
    a = 5;
    int b;
    b = 10;
    int c;
    c = 0;
    char d;
    d = 'X';

    // Test arithmetic operators
    assert(a + b == 15);
    assert(b - a == 5);
    assert(a * b == 50);
    assert(b / a == 2);

    // Test comparison operators
    assert(a < b);
    assert(b > a);
    assert(a <= 5);
    assert(b >= 10);
    assert(a == 5);
    assert(b != 5);

    // Test logical operators
    assert(a && b);
    assert(a || c);
    assert(!c);
    // Test bitwise operators
    assert((a & b) == 0);
    assert((a | b) == 15);
    assert((a ^ b) == 15);
    assert(~a == -6);
    assert((a << 1) == 10);
    assert((b >> 1) == 5);

    // Test assignment operators
    c = a;
    assert(c == 5);
    c = c+ a;
    assert(c == 10);
    c = c + a;
    assert(c == 15);
    c = c * a;
    assert(c == 75);
    c = c / a;
    assert(c == 15);
    c = c % a;
    assert(c == 0);
    c = c << 1;
    assert(c == 0);
    c = c | 1;
    assert(c == 1);

    // Test if-else statements
    if (a < b) {
        assert(1);
    } else {
        assert(0);
    }

    // Test switch statements
    switch (d) {
        case 'X':
            assert(1);
            break;
        case 'Y':
            assert(0);
            break;
        default:
            assert(0);
            break;
    }

    // Test while loops
    int i;
    i = 0;
    while (i < 5) {
        i++;
    }
    assert(i == 5);

    // Test do-while loops
    int j;
    j = 0;
    do {
        j++;
    } while (j < 5);
    assert(j == 5);

    // Test for loops
    int k;
    for (k = 0; k < 5; k++) {
        assert(k >= 0 && k < 5);
    }

    assert(add(a, b) == 15);


    return 0;
}

// Test functions
int add(int x, int y) {
    return x + y;
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


void printn(char *s, int n){
  print(s);
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