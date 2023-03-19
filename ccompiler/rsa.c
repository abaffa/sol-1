#inc_asm "lib/stdio.asm"


int main() {
    int p = 61, q = 53;
    int n = p * q;
    int phi = (p - 1) * (q - 1);
    int e = find_e(phi);
    int d = find_d(e, phi);

    printf("Public Key: (%u, %u)\n", n, e);
    printf("Private Key: (%u, %u)\n", n, d);

    char input_str[100];
    printf("Enter a string: ");
    fgets(input_str, 100, stdin);

    int encrypted_chars[100];
    int encrypted_chars_len = 0;
    printf("Encrypted text: ");
    for (int i = 0; input_str[i] != '\0' && input_str[i] != '\n'; i++) {
        encrypted_chars[i] = mod_exp((int)input_str[i], e, n);
        printf("%u ", encrypted_chars[i]);
        encrypted_chars_len++;
    }
    printf("\n");

    printf("Decrypted text: ");
    for (int i = 0; i < encrypted_chars_len; i++) {
        int decrypted_char = mod_exp(encrypted_chars[i], d, n);
        printf("%c", (char)decrypted_char);
    }
    printf("\n");

    return 0;
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
        exp >>= 1;
        base = (base * base) % mod;
    }
    return result;
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
