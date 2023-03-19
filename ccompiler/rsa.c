#inc_asm "lib/stdio.asm"


int main() {
    int p, q, n, phi, e, d;
    p = 61;
    q = 53;
    n = p * q;
    phi = (p - 1) * (q - 1);
    e = find_e(phi);
    d = find_d(e, phi);

    print("Public Key: (");
    print_num(n);
    print(", ");
    print_num(e);
    print(")\n");

    print("Private Key: (");
    print_num(n);
    print(", ");
    print_num(d);
    print(")\n");

    char input_str[100];
    print("Enter a string: ");
    _gets(input_str);

    int encrypted_chars[100];
    int encrypted_chars_len = 0;
    print("Encrypted text: ");
    int i;
    for (i = 0; input_str[i] != '\0' && input_str[i] != '\n'; i++) {
        encrypted_chars[i] = mod_exp(input_str[i], e, n);
        print_num(encrypted_chars[i]);
        print(" ");
        encrypted_chars_len++;
    }
    print("\n");

    int decrypted_char;
    char c;
    print("Decrypted text: ");
    for (i = 0; i < encrypted_chars_len; i++) {
        decrypted_char = mod_exp(encrypted_chars[i], d, n);
        c = decrypted_char;
        print(&c);
    }
    print("\n");

    return 0;
}

void _gets(char *s){
  asm{
    mov a, @s
    mov d, a
    call gets
  }
  return;
}

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

int mod_exp(int base, int exp, int mod) {
    int result = 1;
    while (exp > 0) {
        if (exp & 1) {
            result = (result * base) % mod;
        }
        exp = exp >> 1;
        base = (base * base) % mod;
    }
    return result;
}

void _putchar(char c){
  asm{
    mov al, @c
    mov ah, al
    call putchar
  }
}
void print(char *s){
    asm{
        mov a, @s
        mov d, a
        call puts
    }
}
void print_num(int num) {
  char digits[5];
  int i;
  i = 0;
  if(num == 0){
    _putchar('0');
    return;
  }
  while (num > 0) {
      digits[i] = '0' + (num % 10);
      num = num / 10;
      i++;
  }
  // Print the digits in reverse order using putchar()
  while (i > 0) {
      i--;
      _putchar(digits[i]);
  }
}
int find_e(int phi) {
    int e;
    for (e = 2; e < phi; e++) {
        if (gcd(e, phi) == 1) {
            return e;
        }
    }
    return 0;
}

int find_d(int e, int phi) {
    int d;
    for (d = 2; d < phi; d++) {
        if ((d * e) % phi == 1) {
            return d;
        }
    }
    return 0;
}
