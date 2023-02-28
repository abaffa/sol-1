#inc_asm "lib/stdio.asm"
char *ss = "\n";

int datum[123];

int instruction[120];

int cmdadr = 0;
int opr = 0;
int datadr1 = 0;
int datadr2 = 0;
int datadr3 = 0;

int pc = 0;
int h = 0;
int i = 0;
int j = 0;
int k = 0;
int l = 0;
int p = 0;

int infi = 0;

int runlimit = 0;

int readint() {
  int n;
  asm{
       call scan_u16d
       mov @n, a
  }
  return n;
}

void displaynumber(int n){
  asm{
    mov a, @n
    call print_u16d
    mov a, @ss
    mov d, a
    call puts
  }
  return;
}

void main(void) {

  for (infi = 0; infi < 10; infi = infi+1) {
    pc = 0; 
    displaynumber(12312);
    cmdadr = readint();

    if (cmdadr <= 120) {

      opr = readint();
      
      datadr1 = readint();
      
      datadr2 = readint();
      
      datadr3 = readint();

      instruction[cmdadr * 4] = opr;
      instruction[(cmdadr * 4) + 1] = datadr1;
      instruction[(cmdadr * 4) + 2] = datadr2;
      instruction[(cmdadr * 4) + 3] = datadr3;
      displaynumber(cmdadr);
      displaynumber(opr);
      displaynumber(datadr1);
      displaynumber(datadr2);
      displaynumber(datadr3);

      if (cmdadr == 0) {
        break; 
      }
    } 
  }

  return;
}