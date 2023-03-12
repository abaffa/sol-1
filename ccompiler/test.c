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

    int matrix1[3][3] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
    int matrix2[3][3] = {9, 8, 7, 6, 5, 4, 3, 2, 1};
    int result1[3][3];
    int result2[3][3];
    int result3[3][3];
int main() {
    int i, j, k;

    matrix1[0];

    // Print matrix1
    print("Matrix1:\n");
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            printn(" ", matrix1[i][j]);
        }
        print("\n");
    }
    print("\n");

    // Print matrix2
    print("Matrix2:\n");
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            printn(" ", matrix2[i][j]);
        }
        print("\n");
    }
    print("\n");

    // Multiply matrix1 and matrix2
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            result1[i][j] = 0;
            for (k = 0; k < 3; k++) {
                result1[i][j] = result1[i][j] + matrix1[i][k] * matrix2[k][j];
            }
        }
    }

    // Add matrix1 and matrix2
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            result2[i][j] = matrix1[i][j] + matrix2[i][j];
        }
    }

    // Subtract matrix1 from matrix2
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            result3[i][j] = matrix2[i][j] - matrix1[i][j];
        }
    }

    // Print the results
    print("Result1 (matrix1 * matrix2):\n");
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            printn(" ", result1[i][j]);
        }
        print("\n");
    }
    print("\n");

    print("Result2 (matrix1 + matrix2):\n");
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            printn(" ", result2[i][j]);
        }
        print("\n");
    }
    print("\n");

    print("Result3 (matrix2 - matrix1):\n");
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            printn(" ", result3[i][j]);
        }
        print("\n");
    }
    print("\n");

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