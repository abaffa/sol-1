#include "lib/stdio.asm"

int x = 20;
int y = 5;
int z = 10;

int max;

int n, i, j;
int s;
int count = 0;
int divides;
char *newline = "\n";
char *s1 = "TRUE";

void main(void){
	
	primes();

	asm{
		syscall sys_terminate_proc
	}

}

void primes(void){
	n = 2;
	while(n < 500){
		s = n;
		divides = 0;

		i = 2;
		while(i < s){

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
				mov a, [n]
				call print_u16d
				mov d, newline
				mov a, [d]
				mov d, a
				call puts
			}
		}
		n = n + 1;
	}
	return;
}

