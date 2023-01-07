#include "lib/stdio.asm"
char *s = "Enter the number of rows: ";
char *ss = "    ";
int coef = 1;
int rows, space, i, j;
char *nl = "\n";

int main(void) {
	asm{
		mov d, _var_s
		call puts
		call scan_u16d
		mov [_var_rows], a
	}

   for (i = 0; i < rows; i=i+1) {
      for (space = 1; space <= rows - i; space=space+1) print();
		
      for (j = 0; j <= i; j=j+1) {
         if (j == 0 || i == 0)
            coef = 1;
         else
            coef = coef * (i - j + 1) / j;
		print();
		asm{
			mov a, [_var_coef]
			call print_u16d
		}
      }
		asm{
			mov d, _var_nl
			call puts
		}
   }

	asm{
		syscall sys_terminate_proc
	}
}
void print(void){
	
	asm{
		mov d, _var_ss
		call puts
		}
	return;
}
