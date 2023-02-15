#include "lib/stdio.asm"

char *s= "Enter a positive integer: ";
char *nl = "\n";

int i;
int num;

void main(void) {

	asm{
		mov d, s_data
		call puts
		call scan_u16d
		mov [num], a
	}

    for (i = 1; i < num; i++) {
        asm{
            mov a, [i]
            call print_u16d
            mov d, nl_data
            call puts
        }
    }

    return;
}

