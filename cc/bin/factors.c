#include "lib/stdio.asm"
char *s= "Enter a positive integer: ";
char *s2= "Factors are: ";
char *nl = "\n";

int num, i;

int main(void) {
	asm{
		mov d, _var_s
		call puts
		call scan_u16d
		mov [_var_num], a
		mov d, _var_s2
		call puts
	}

    for (i = 1; i < num; i=i+1) {
        if (num % i == 0) {
			asm{
				mov a, [_var_i]
				call print_u16d
				mov d, _var_nl
				call puts
			}
        }
    }

	asm{
		syscall sys_terminate_proc
	}
}

