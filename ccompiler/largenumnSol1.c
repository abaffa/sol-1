#inc_asm "lib/stdio.asm"

char *ss = "\n";
char *sp = " ";

int ionum[6];
int ionr = 0;
int ioshift = 0;

int datum[36];
int datumpos = 0;

int anarr[12];
int bnarr[12];

int anarrbkp[12];
int bnarrbkp[12];

int cnarr[12];
int mulres[24];
int divres[12];
int asign = 0;
int bsign = 0;
int csign = 0;
int protopos = 0;
int pos = 0;
int carry = 0;
int nextcarry = 0;
int agtb = 0;
int bgta = 0;
int aeqb = 0;
int aneqb = 0;
int ageb = 0;
int bgea = 0;
int eqflag = 0;
int sizepos = 0;
int psizepos = 0;
int swappos = 0;
int swaptmp = 0;

int toolarge = 0;
int normal = 0;
int mulpos1 = 0;
int mulpos2 = 0;
int mulpos3 = 0;

int brshift = 0;
int blshift = 0;
int alshift = 0;
int divcounter = 0;
int segmentcounter = 0;
int divi = 0;
int allzeroes = 0;
int bkpcsign = 0;
int divshift = 0;

int readint() {
  int n;
  asm{
       call scan_u16d
       mov @n, a
  }
  return n;
}

void prnnumspace(int n){
  asm{
    mov a, @n
    call print_u16d
    mov a, @sp
    mov d, a
    call puts
  }
  return;
}

void prnnum(int n){
  asm{
    mov a, @n
    call print_u16d
  }
  return;
}

void prnnl(){
  asm{
    mov a, @ss
    mov d, a
    call puts
  }
  return;
}

void prnsp(){
  asm{
    mov a, @sp
    mov d, a
    call puts
  }
  return;
}


void fixsignin() {
  asign = 0;
  bsign = 0;
  csign = 0;
  if (anarr[11] > 9) {
    pos = anarr[11]/10;
    anarr[11] = anarr[11] - (pos * 10);
    asign = 1;
  }
  if (bnarr[11] > 9) {
    pos = bnarr[11]/10;
    bnarr[11] = bnarr[11] - (pos * 10);
    bsign = 1;
  }
  return;
}

void fixsignout() {
  if (csign == 1) {
    cnarr[11] = cnarr[11] + 10;
    csign = 0;
  }
  return;
}

void fixcsizezero() {
  allzeroes = 1;
  for (pos = 1; pos < 12; pos++) {
    if (cnarr[pos] != 0) {
      allzeroes = 0;
      break;
    }
  }
  if (allzeroes == 1) {
    csign = 0;
  }
  if (cnarr[11] > 9) {
    csign = 0;
    for (pos = 1; pos < 12; pos++) {
      cnarr[pos] = 0;
    }
  }
  return;
}


void swapab () {
  for (swappos = 0; swappos < 12; swappos++) {
    anarr[swappos] = anarr[swappos] + bnarr[swappos];
    bnarr[swappos] = anarr[swappos] - bnarr[swappos];
    anarr[swappos] = anarr[swappos] - bnarr[swappos];
  }
  return;
}

void checkabsabsize() {
  agtb = 0;
  bgta = 0;
  ageb = 0;
  bgea = 0;
  aeqb = 0;
  aneqb = 0;

  
  for (psizepos = 12; psizepos > 0; psizepos--) {
    sizepos = psizepos - 1;
    if (anarr[sizepos] > bnarr[sizepos]) {
      aneqb = 1;
      agtb = 1;
      ageb = 1;
    }
    if (anarr[sizepos] < bnarr[sizepos]) {
      aneqb = 1;
      bgta = 1;
      bgea = 1;
    }

    if (aneqb == 1) {
      break;
    }

  }
  if (aneqb == 0) {
    aeqb = 1;
    ageb = 1;
    bgea = 1;
  }
  return;
}

void protoplus() {
  carry = 0;
  for (pos = 0; pos < 12; pos++) {
    cnarr[pos] = anarr[pos] + bnarr[pos] + carry;
    carry = 0;
    if (cnarr[pos] > 99) {
      carry = 1;
      cnarr[pos] = cnarr[pos] - 100;
    }
  }
  return;
}

void protominus() {
  carry = 0;
  for (pos = 0; pos < 12; pos++) {
    nextcarry = 0;
    if ((bnarr[pos] + carry) > anarr[pos]) {
      anarr[pos] = anarr[pos] + 100;
      nextcarry = 1;
    }
    cnarr[pos] = anarr[pos] - bnarr[pos] - carry;
    carry = nextcarry;
  }
  if (carry == 1) {
    csign = 1;
    carry = 0;
  }
  return;
}

void pminus() {
  for (divi = 0; divi < 12; divi++) {
    cnarr[divi] = 0;
  }
  checkabsabsize();
  if ((asign == bsign) && (aeqb == 1)) {
    csign = 0;
    for (pos = 1; pos < 12; pos++) {
      cnarr[pos] = 0;
    }
  }

  if ((asign == 0) && (bsign == 0) && (ageb == 1)) {
    csign = 0;
    protominus();
  }

  if ((asign == 0) && (bsign == 0) && (bgta == 1)) {
    csign = 1;
    swapab();
    protominus();
  }

  if ((asign == 1) && (bsign == 1) && (ageb == 1)) {
    csign = 1;
    protominus();
  }

  if ((asign == 1) && (bsign == 1) && (bgta == 1)) {
    csign = 0;
    swapab();
    protominus();
  }

  if ((asign == 0) && (bsign == 1)) {
    csign = 0;
    protoplus();
  }

  if ((asign == 1) && (bsign == 0)) {
    csign = 1;
    protoplus();
  }

  return;
}

void minus() {
  fixsignin();
  pminus();
  fixcsizezero();
  fixsignout();
  return;
}

void pplus() {

  for (divi = 0; divi < 12; divi++) {
    cnarr[divi] = 0;
  }
  checkabsabsize();
  if (((asign == 0) && (bsign == 1)) && (aeqb == 1)) {
    asign = 0;
    bsign = 0;
    csign = 0;
    for (pos = 1; pos < 12; pos++) {
      cnarr[pos] = 0;
    }
    return;
  }

  if (((asign == 1) && (bsign == 0)) && (aeqb == 1)) {
    asign = 0;
    bsign = 0;
    csign = 0;
    for (pos = 1; pos < 12; pos++) {
      cnarr[pos] = 0;
    }
    return;
  }

  if ((asign == 0) && (bsign == 0)) {
    asign = 0;
    bsign = 0;
    csign = 0;
    protoplus();
    return;
  }

  if ((asign == 1) && (bsign == 1)) {
    asign = 0;
    bsign = 0;
    csign = 1;
    protoplus();
    return;
  }

  if ((asign == 0) && (bsign == 1) && (agtb == 1)) {
    asign = 0;
    bsign = 0;
    csign = 0;
    protominus();
    return;
  }

  if ((asign == 0) && (bsign == 1) && (bgta == 1)) {
    asign = 0;
    bsign = 0;
    csign = 1;
    swapab();
    protominus();
    return;
  }

  if ((asign == 1) && (bsign == 0) && (agtb == 1)) {
    csign = 1;
    swapab();
    asign = 0;
    bsign = 0;
    pminus();
    return;
  }

  if ((asign == 1) && (bsign == 0) && (bgta == 1)) {
    asign = 0;
    bsign = 0;
    csign = 0;
    swapab();
    protominus();
    return;
  }
  return;
}

void plus() {
  fixsignin();
  pplus();
  fixcsizezero();
  fixsignout();
  return;
}


void normmulres() {
  if (mulres[23] > 99) {
    toolarge = mulres[23]/100;
    mulres[23] = mulres[23] - (toolarge * 100);
  }

  normal = 0;
  while (normal == 0) {
    normal = 1;

    for (protopos = 0; protopos < 23; protopos++) {
      pos = 22 - protopos;

      if (mulres[pos] > 99) {
          normal = 0;
          toolarge = mulres[pos]/100;
          mulres[pos] = mulres[pos] - (toolarge * 100);
          mulres[pos + 1] = mulres[pos + 1] + toolarge;
      }
    }
  }

  if (mulres[23] > 99) {
    toolarge = mulres[23]/100;
    mulres[23] = mulres[23] - (toolarge * 100);
  }
  return;
}

void prototimes() {
  for (divi = 0; divi < 12; divi++) {
    cnarr[divi] = 0;
  }
  for (divi = 0; divi < 24; divi++) {
    mulres[divi] = 0;
  }
  for (mulpos1 = 0; mulpos1 < 12; mulpos1++) {
    for (mulpos2 = 0; mulpos2 < 12; mulpos2++) {
      mulres[mulpos1+mulpos2] = mulres[mulpos1+mulpos2] + (bnarr[mulpos2]*anarr[mulpos1]);
    }

    normmulres();
  }
  return;
}

void protodividedby() {
  brshift = 0;
  blshift = 0;
  alshift = 0;
  divcounter = 0;
  segmentcounter = 0;

  allzeroes = 1;
  for (divi = 0; divi < 12; divi++) {
    cnarr[divi] = 0;
    divres[divi] = 0;
    if (bnarr[divi] != 0) {
      allzeroes = 0;
    }
  }
  if (allzeroes == 1) {
    return;
  }

  if (bnarr[11] != 0) {
    for (divi = 0; divi < 11; divi++) {
      bnarr[divi] = bnarr[divi+1];
    }
    brshift = 1;
    bnarr[11] = 0;
  }
  while (bnarr[10] == 0) {
    for (divi = 0; divi < 10; divi++) {
      bnarr[10-divi] = bnarr[10-divi-1];
    }
    bnarr[0] = 0;
    blshift++;
  }

  allzeroes = 1;
  for (divi = 0; divi < 12; divi++) {
    if (anarr[divi] != 0) {
      allzeroes = 0;
    }
  }
  if (allzeroes == 1) {
    return;
  }
  while (anarr[11] == 0) {
    for (divi = 0; divi < 12; divi++) {
      anarr[11-divi] = anarr[11-divi-1];
    }
    anarr[0] = 0;
    alshift++;
  }

  segmentcounter = 0;
  divcounter = 0;

  while (segmentcounter < 12) {
    while (anarr[11] != 0) {
      pminus();
      divcounter++;
      for (divi = 0; divi < 12; divi++) {
        anarr[divi] = cnarr[divi];
        cnarr[divi] = 0;
      }
    }

    divres[11-segmentcounter] = divcounter;
    divcounter = 0;
    segmentcounter++;   

    allzeroes = 1;
    for (divi = 0; divi < 12; divi++) {
      if (anarr[divi] != 0) {
        allzeroes = 0;
      }
    }
    if (allzeroes == 1) {
      return;
    }

    while (anarr[11] == 0) {
      for (divi = 0; divi < 12; divi++) {
        anarr[11-divi] = anarr[11-divi-1];
      }
      anarr[0] = 0;
      if (anarr[11] == 0) {
        divres[11-segmentcounter] = 0;
        anarr[0] = 0;
        segmentcounter++;
        if (segmentcounter == 12) {
          return;
        }
      }
    }
  }
  return;
}

void normdivres() {

  for (divi = 12; divi < 24; divi++) {
    mulres[divi] = 0;
  }
  for (divi = 0; divi < 12; divi++) {
    mulres[divi] = divres[divi];
  }

  normmulres();

  for (divshift = 0; divshift < 11; divshift++) {
    for (divi = 0; divi < 24; divi++) {
      mulres[23-divi] = mulres[23-divi-1];
    }
    mulres[0] = 0;
  }

  for (divi = 0; divi < 12; divi++) {
    divres[divi] = mulres[divi + 12];
  }

  return;
}

void times() {

  fixsignin();

  csign = 0;
  if (asign != bsign) {
    csign = 1;
  }
  asign = 0;
  bsign = 0;

  prototimes();

  allzeroes = 1;
  for (pos = 15; pos < 24; pos++) {
    if (mulres[pos] != 0) {
      allzeroes = 0;
    }
  }

  if (allzeroes == 1) {
    for (pos = 4; pos < 15; pos++) {
      cnarr[pos-4] = mulres[pos];
    }
  }
  if (cnarr[11] > 9) {
    for (pos = 0; pos < 10; pos++) {
      cnarr[pos] = 0;
    }
  }

  fixcsizezero();
  fixsignout();
  return;
}

void dividedby() {
  fixsignin();

  csign = 0;
  if (asign != bsign) {
    csign = 1;
  }
  asign = 0;
  bsign = 0;
  bkpcsign = csign;

  protodividedby();

  normdivres();

  if ((blshift + 6) > (alshift + brshift)) {
    blshift = blshift + 6 - alshift - brshift;
    divi = 12 - blshift;
    for (pos = 0; pos < blshift; pos++) {
      if ((pos + divi) < 12) {
        cnarr[pos] = divres[pos + divi];
      }
    }
  }

  csign = bkpcsign;

  fixcsizezero();
  fixsignout();
  return;
}

void main() {

  for (pos = 0; pos < 60; pos++) {
    prnnum(0);
  }
  prnnl();



  for (pos = 6; pos > 0; pos--) {
    ionr = readint();
    ioshift = ionr / 10000;
    ioshift = ioshift * 10000;
    ionr = ionr - ioshift;
    ionum[pos-1] = ionr;
    for (datumpos = 6; datumpos >= pos; datumpos--) {
      if (ionum[datumpos-1] < 1000) {
        prnnum(0);
      }
      if (ionum[datumpos-1] < 100) {
        prnnum(0);
      }
      if (ionum[datumpos-1] < 10) {
        prnnum(0);
      }
      prnnum(ionum[datumpos-1]);
    }
    prnnl();
  }

  datumpos = 0;

  for (pos = datumpos*6; pos < (datumpos*6) + 6; pos++) {
    datum[pos] = ionum[pos - (datumpos*6)];
  }



  for (pos = 0; pos < 60; pos++) {
    prnnum(0);
  }
  prnnl();



  for (pos = 6; pos > 0; pos--) {
    ionr = readint();
    ioshift = ionr / 10000;
    ioshift = ioshift * 10000;
    ionr = ionr - ioshift;
    ionum[pos-1] = ionr;
    for (datumpos = 6; datumpos >= pos; datumpos--) {
      if (ionum[datumpos-1] < 1000) {
        prnnum(0);
      }
      if (ionum[datumpos-1] < 100) {
        prnnum(0);
      }
      if (ionum[datumpos-1] < 10) {
        prnnum(0);
      }
      prnnum(ionum[datumpos-1]);
    }
    prnnl();
  }

  datumpos = 1;

  for (pos = datumpos*6; pos < (datumpos*6) + 6; pos++) {
    datum[pos] = ionum[pos - (datumpos*6)];
  }



  datumpos = 0;

  for (pos = datumpos*6; pos < (datumpos*6) + 6; pos++) {
    ioshift = datum[pos]/100;
    anarr[(pos - (datumpos*6))*2+1] = ioshift;
    anarr[(pos - (datumpos*6))*2] = datum[pos]-(ioshift*100);
  }

  datumpos = 1;

  for (pos = datumpos*6; pos < (datumpos*6) + 6; pos++) {
    ioshift = datum[pos]/100;
    bnarr[(pos - (datumpos*6))*2+1] = ioshift;
    bnarr[(pos - (datumpos*6))*2] = datum[pos]-(ioshift*100);
  }



  for (pos = 0; pos < 12; pos++) {
    anarrbkp[pos] = anarr[pos];
    bnarrbkp[pos] = bnarr[pos];
  }

  for (pos = 0; pos < 60; pos++) {
    prnnum(0);
  }
  prnnl();



  plus();

  datumpos = 2;

  for (pos = datumpos*6; pos < (datumpos*6) + 6; pos++) {
    datum[pos] = (cnarr[(pos - (datumpos*6))*2+1]) * 100 + cnarr[(pos - (datumpos*6))*2];
  }

  for (pos = 18; pos > 12; pos--) {
    if (datum[pos-1] < 1000) {
      prnnum(0);
    }
    if (datum[pos-1] < 100) {
      prnnum(0);
    }
    if (datum[pos-1] < 10) {
      prnnum(0);
    }
    prnnumspace(datum[pos-1]);
  }
  prnnl();

  for (pos = 0; pos < 12; pos++) {
    anarr[pos] = anarrbkp[pos];
    bnarr[pos] = bnarrbkp[pos];
  }

  minus();

  datumpos = 2;

  for (pos = datumpos*6; pos < (datumpos*6) + 6; pos++) {
    datum[pos] = (cnarr[(pos - (datumpos*6))*2+1]) * 100 + cnarr[(pos - (datumpos*6))*2];
  }

  for (pos = 18; pos > 12; pos--) {
    if (datum[pos-1] < 1000) {
      prnnum(0);
    }
    if (datum[pos-1] < 100) {
      prnnum(0);
    }
    if (datum[pos-1] < 10) {
      prnnum(0);
    }
    prnnumspace(datum[pos-1]);
  }
  prnnl();

  for (pos = 0; pos < 12; pos++) {
    anarr[pos] = anarrbkp[pos];
    bnarr[pos] = bnarrbkp[pos];
  }

  dividedby();

  datumpos = 2;

  for (pos = datumpos*6; pos < (datumpos*6) + 6; pos++) {
    datum[pos] = (cnarr[(pos - (datumpos*6))*2+1]) * 100 + cnarr[(pos - (datumpos*6))*2];
  }

  for (pos = 18; pos > 12; pos--) {
    if (datum[pos-1] < 1000) {
      prnnum(0);
    }
    if (datum[pos-1] < 100) {
      prnnum(0);
    }
    if (datum[pos-1] < 10) {
      prnnum(0);
    }
    prnnumspace(datum[pos-1]);
  }
  prnnl();

  for (pos = 0; pos < 12; pos++) {
    anarr[pos] = anarrbkp[pos];
    bnarr[pos] = bnarrbkp[pos];
  }
/*
  dividedby();

  datumpos = 2;

  for (pos = datumpos*6; pos < (datumpos*6) + 6; pos++) {
    datum[pos] = (cnarr[(pos - (datumpos*6))*2+1]) * 100 + cnarr[(pos - (datumpos*6))*2];
  }

  for (pos = 18; pos > 12; pos--) {
    if (datum[pos-1] < 1000) {
      prnnum(0);
    }
    if (datum[pos-1] < 100) {
      prnnum(0);
    }
    if (datum[pos-1] < 10) {
      prnnum(0);
    }
    prnnumspace(datum[pos-1]);
  }
  prnnl();
*/
  return;
}
