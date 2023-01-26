#include "lib/stdio.asm"

char *s = "Enter the number of rows: ";
char *ss = "    ";
int coef = 1;
int rows, space, i, j;
char *nl = "\n\r";

int main(void) {
	asm{
		mov a, $s
		mov d, a
		call puts
		call scan_u16d
		mov $rows, a
	}

   for (i = 0; i < rows; i=i+1) {
      for (space = 1; space <= rows - i; space=space+1) print();
		
      for (j = 0; j <= i; j=j+1) {
         if (j == 0 || i == 0)
            coef = 1;
         else
            coef = coef * (i - j + 1) / j;
		print();
		print_nbr(coef);
      }
		asm{
			mov a, $nl
			mov d, a
			call puts
		}
   }

	return;
}

void print_nbr(int n){
  asm{
	mov a, $n
	call print_u16d
  }
  return;
}

void print(void){
	asm{
		mov a, $s
		mov d, a
		call puts
	}
	return;
}
