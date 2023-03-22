#inc_asm "lib/stdio.asm"

int main() {
  asm{
    mov a, sp
    mov b, a
    call print_u16x
    push word $FFFF
    mov a, sp
    mov b, a
    call print_u16x
    push byte $FF
    mov a, sp
    mov b, a
    call print_u16x
  }
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