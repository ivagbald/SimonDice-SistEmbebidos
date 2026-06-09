#line 1 "C:/Users/User/Desktop/TAREAEMBEBIDOS/SimonDice-SistEmbebidos/PIC16F887/main.c"
#line 25 "C:/Users/User/Desktop/TAREAEMBEBIDOS/SimonDice-SistEmbebidos/PIC16F887/main.c"
void play_note(unsigned int freq, unsigned int dur_ms);
void melody_start(void);
void melody_win(void);
void melody_fail(void);
void process_command(unsigned char cmd);


unsigned char read_bus(void) {
 return (unsigned char)(PORTB & 0x07);
}


void play_note(unsigned int freq, unsigned int dur_ms) {
 Sound_Play(freq, dur_ms);
}


void melody_start(void) {

 play_note(262, 120);
 play_note(330, 120);
 play_note(392, 120);
 play_note(523, 200);
}

void melody_win(void) {

 play_note(523, 150);
 play_note(523, 150);
 play_note(523, 150);
 play_note(659, 400);
}

void melody_fail(void) {

 play_note(200, 150);
 play_note(150, 150);
 play_note(100, 300);
}


void process_command(unsigned char cmd) {
 switch (cmd) {
 case 0: break;
 case 1: play_note( 262u ,  400u ); break;
 case 2: play_note( 330u ,  400u ); break;
 case 3: play_note( 392u ,  400u ); break;
 case 4: play_note( 523u ,  400u ); break;
 case 5: melody_start(); break;
 case 6: melody_win(); break;
 case 7: melody_fail(); break;
 }
}


void main(void) {
 unsigned char prev_strobe = 0;
 unsigned char cmd = 0;


 TRISB = 0xFF;
 TRISC = 0x00;


 Sound_Init(&PORTC, 2);

 while (1) {
 unsigned char strobe_now =  RB3_bit ;


 if (strobe_now && !prev_strobe) {
 cmd = read_bus();
 process_command(cmd);
 }

 prev_strobe = strobe_now;
 }
}
