#include "lib/stdio.asm"

void main(void){

  gen_clk();

  return;
}

void gen_clk(void){
  int clk;
  int count;

  clk = 0;

  for(count = 0; count < 20; count++){
    if(clk == 0) clk = 1;
    else clk = 0;
    print(clk);
  }

  return;
}


void print(int n){
  asm{
    mov a, @n
    call print_u16d
    mov ah, $0A
    call putchar
  }
  return;
}