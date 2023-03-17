#inc_asm "lib/stdio.asm"

int n, i, j;
int s;
int count = 0;
int divides;
char *newline = "\n";
char *prompt = "Max: ";
int top;

void main(void){
	asm{
		mov a, @prompt
		mov d, a
		call puts
		call scan_u16d
		mov @top, a
	}	
	primes();

	return;
}

void primes(void){
	n = 2;
	while(n < top){
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
				mov a, @n
				call print_u16d
				mov a, @newline
				mov d, a
				call puts
			}
		}
		n = n + 1;
	}
	return;
}

