#include "lib/stdio.asm"
char *s1= "Enter a positive integer: ";
char *s2= "Factors are: ";
char *nl = "\n";
int num;

char *s3 = "Enter the number of rows: ";
char *s4 = "    ";
int coef = 1;
int rows, space;


int x = 20;
int y = 5;
int z = 10;
int n, i, j;
int nn;
int count = 0;
int divides;
int option;
char *opt = "Choose option: ";

int main(void) {
	asm{
		mov d, _var_opt
		mov a, [d]
		mov d, a
		call puts
		call scan_u16d
		mov [_var_option], a
	}

	if(option == 0){
		factors();
	}
	else if(option==1){
		pascal();
	}
	else{
		primes();
	}

	asm{
		syscall sys_terminate_proc
	}
}

void factors(void){
	asm{
		mov d, _var_s1
		mov a, [d]
		mov d, a
		call puts
		call scan_u16d
		mov [_var_num], a
		mov d, _var_s2
		mov a, [d]
		mov d, a
		call puts
	}

    for (i = 1; i < num; i=i+1) {
        if (num % i == 0) {
			asm{
				mov a, [_var_i]
				call print_u16d
				mov d, _var_nl
				mov a, [d]
				mov d, a
				call puts
			}
        }
    }
	return;
}

void pascal(void){
	asm{
		mov d, _var_s3
		mov a, [d]
		mov d, a
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
			mov a, [d]
			mov d, a
			call puts
		}
   }

	return;
}

void print(void){
	
	asm{
		mov d, _var_s4
		mov a, [d]
		mov d, a
		call puts
		}
	return;
}


void primes(void){
	n = 2;
	while(n < 500){
		nn = n;
		divides = 0;

		i = 2;
		while(i < nn){

			if(n % i == 0){
				divides = 1;
				break;
			}
			i = i + 1;
			if(i==n) break;
		}
		
		if(divides==0){
			count=count+1;	
			asm{
				mov a, [_var_n]
				call print_u16d
				mov d, _var_nl
				mov a, [d]
				mov d, a
				call puts
			}
		}
		n = n + 1;
	}
	return;
}
