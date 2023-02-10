
void print(char *s){
    asm{
        mov a, @s
        mov d, a
        call puts
    }
    return;
}