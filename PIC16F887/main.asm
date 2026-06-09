
_read_bus:

;main.c,32 :: 		unsigned char read_bus(void) {
;main.c,33 :: 		return (unsigned char)(PORTB & 0x07);  // máscara bits 0-2
	MOVLW      7
	ANDWF      PORTB+0, 0
	MOVWF      R0+0
;main.c,34 :: 		}
L_end_read_bus:
	RETURN
; end of _read_bus

_play_note:

;main.c,37 :: 		void play_note(unsigned int freq, unsigned int dur_ms) {
;main.c,38 :: 		Sound_Play(freq, dur_ms);
	MOVF       FARG_play_note_freq+0, 0
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVF       FARG_play_note_freq+1, 0
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVF       FARG_play_note_dur_ms+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       FARG_play_note_dur_ms+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,39 :: 		}
L_end_play_note:
	RETURN
; end of _play_note

_melody_start:

;main.c,42 :: 		void melody_start(void) {
;main.c,44 :: 		play_note(262, 120);
	MOVLW      6
	MOVWF      FARG_play_note_freq+0
	MOVLW      1
	MOVWF      FARG_play_note_freq+1
	MOVLW      120
	MOVWF      FARG_play_note_dur_ms+0
	MOVLW      0
	MOVWF      FARG_play_note_dur_ms+1
	CALL       _play_note+0
;main.c,45 :: 		play_note(330, 120);
	MOVLW      74
	MOVWF      FARG_play_note_freq+0
	MOVLW      1
	MOVWF      FARG_play_note_freq+1
	MOVLW      120
	MOVWF      FARG_play_note_dur_ms+0
	MOVLW      0
	MOVWF      FARG_play_note_dur_ms+1
	CALL       _play_note+0
;main.c,46 :: 		play_note(392, 120);
	MOVLW      136
	MOVWF      FARG_play_note_freq+0
	MOVLW      1
	MOVWF      FARG_play_note_freq+1
	MOVLW      120
	MOVWF      FARG_play_note_dur_ms+0
	MOVLW      0
	MOVWF      FARG_play_note_dur_ms+1
	CALL       _play_note+0
;main.c,47 :: 		play_note(523, 200);
	MOVLW      11
	MOVWF      FARG_play_note_freq+0
	MOVLW      2
	MOVWF      FARG_play_note_freq+1
	MOVLW      200
	MOVWF      FARG_play_note_dur_ms+0
	CLRF       FARG_play_note_dur_ms+1
	CALL       _play_note+0
;main.c,48 :: 		}
L_end_melody_start:
	RETURN
; end of _melody_start

_melody_win:

;main.c,50 :: 		void melody_win(void) {
;main.c,52 :: 		play_note(523, 150);
	MOVLW      11
	MOVWF      FARG_play_note_freq+0
	MOVLW      2
	MOVWF      FARG_play_note_freq+1
	MOVLW      150
	MOVWF      FARG_play_note_dur_ms+0
	CLRF       FARG_play_note_dur_ms+1
	CALL       _play_note+0
;main.c,53 :: 		play_note(523, 150);
	MOVLW      11
	MOVWF      FARG_play_note_freq+0
	MOVLW      2
	MOVWF      FARG_play_note_freq+1
	MOVLW      150
	MOVWF      FARG_play_note_dur_ms+0
	CLRF       FARG_play_note_dur_ms+1
	CALL       _play_note+0
;main.c,54 :: 		play_note(523, 150);
	MOVLW      11
	MOVWF      FARG_play_note_freq+0
	MOVLW      2
	MOVWF      FARG_play_note_freq+1
	MOVLW      150
	MOVWF      FARG_play_note_dur_ms+0
	CLRF       FARG_play_note_dur_ms+1
	CALL       _play_note+0
;main.c,55 :: 		play_note(659, 400);
	MOVLW      147
	MOVWF      FARG_play_note_freq+0
	MOVLW      2
	MOVWF      FARG_play_note_freq+1
	MOVLW      144
	MOVWF      FARG_play_note_dur_ms+0
	MOVLW      1
	MOVWF      FARG_play_note_dur_ms+1
	CALL       _play_note+0
;main.c,56 :: 		}
L_end_melody_win:
	RETURN
; end of _melody_win

_melody_fail:

;main.c,58 :: 		void melody_fail(void) {
;main.c,60 :: 		play_note(200, 150);
	MOVLW      200
	MOVWF      FARG_play_note_freq+0
	CLRF       FARG_play_note_freq+1
	MOVLW      150
	MOVWF      FARG_play_note_dur_ms+0
	CLRF       FARG_play_note_dur_ms+1
	CALL       _play_note+0
;main.c,61 :: 		play_note(150, 150);
	MOVLW      150
	MOVWF      FARG_play_note_freq+0
	CLRF       FARG_play_note_freq+1
	MOVLW      150
	MOVWF      FARG_play_note_dur_ms+0
	CLRF       FARG_play_note_dur_ms+1
	CALL       _play_note+0
;main.c,62 :: 		play_note(100, 300);
	MOVLW      100
	MOVWF      FARG_play_note_freq+0
	MOVLW      0
	MOVWF      FARG_play_note_freq+1
	MOVLW      44
	MOVWF      FARG_play_note_dur_ms+0
	MOVLW      1
	MOVWF      FARG_play_note_dur_ms+1
	CALL       _play_note+0
;main.c,63 :: 		}
L_end_melody_fail:
	RETURN
; end of _melody_fail

_process_command:

;main.c,66 :: 		void process_command(unsigned char cmd) {
;main.c,67 :: 		switch (cmd) {
	GOTO       L_process_command0
;main.c,68 :: 		case 0: break;  // silencio
L_process_command2:
	GOTO       L_process_command1
;main.c,69 :: 		case 1: play_note(FREQ_GREEN,  NOTE_DUR); break;
L_process_command3:
	MOVLW      6
	MOVWF      FARG_play_note_freq+0
	MOVLW      1
	MOVWF      FARG_play_note_freq+1
	MOVLW      144
	MOVWF      FARG_play_note_dur_ms+0
	MOVLW      1
	MOVWF      FARG_play_note_dur_ms+1
	CALL       _play_note+0
	GOTO       L_process_command1
;main.c,70 :: 		case 2: play_note(FREQ_RED,    NOTE_DUR); break;
L_process_command4:
	MOVLW      74
	MOVWF      FARG_play_note_freq+0
	MOVLW      1
	MOVWF      FARG_play_note_freq+1
	MOVLW      144
	MOVWF      FARG_play_note_dur_ms+0
	MOVLW      1
	MOVWF      FARG_play_note_dur_ms+1
	CALL       _play_note+0
	GOTO       L_process_command1
;main.c,71 :: 		case 3: play_note(FREQ_BLUE,   NOTE_DUR); break;
L_process_command5:
	MOVLW      136
	MOVWF      FARG_play_note_freq+0
	MOVLW      1
	MOVWF      FARG_play_note_freq+1
	MOVLW      144
	MOVWF      FARG_play_note_dur_ms+0
	MOVLW      1
	MOVWF      FARG_play_note_dur_ms+1
	CALL       _play_note+0
	GOTO       L_process_command1
;main.c,72 :: 		case 4: play_note(FREQ_YELLOW, NOTE_DUR); break;
L_process_command6:
	MOVLW      11
	MOVWF      FARG_play_note_freq+0
	MOVLW      2
	MOVWF      FARG_play_note_freq+1
	MOVLW      144
	MOVWF      FARG_play_note_dur_ms+0
	MOVLW      1
	MOVWF      FARG_play_note_dur_ms+1
	CALL       _play_note+0
	GOTO       L_process_command1
;main.c,73 :: 		case 5: melody_start(); break;
L_process_command7:
	CALL       _melody_start+0
	GOTO       L_process_command1
;main.c,74 :: 		case 6: melody_win();   break;
L_process_command8:
	CALL       _melody_win+0
	GOTO       L_process_command1
;main.c,75 :: 		case 7: melody_fail();  break;
L_process_command9:
	CALL       _melody_fail+0
	GOTO       L_process_command1
;main.c,76 :: 		}
L_process_command0:
	MOVF       FARG_process_command_cmd+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_process_command2
	MOVF       FARG_process_command_cmd+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_process_command3
	MOVF       FARG_process_command_cmd+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_process_command4
	MOVF       FARG_process_command_cmd+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_process_command5
	MOVF       FARG_process_command_cmd+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_process_command6
	MOVF       FARG_process_command_cmd+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_process_command7
	MOVF       FARG_process_command_cmd+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_process_command8
	MOVF       FARG_process_command_cmd+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_process_command9
L_process_command1:
;main.c,77 :: 		}
L_end_process_command:
	RETURN
; end of _process_command

_main:

;main.c,80 :: 		void main(void) {
;main.c,81 :: 		unsigned char prev_strobe = 0;
	CLRF       main_prev_strobe_L0+0
;main.c,85 :: 		TRISB = 0xFF;
	MOVLW      255
	MOVWF      TRISB+0
;main.c,86 :: 		TRISC = 0x00;   // RC2 salida (PWM buzzer)
	CLRF       TRISC+0
;main.c,89 :: 		Sound_Init(&PORTC, 2);  // RC2
	MOVLW      PORTC+0
	MOVWF      FARG_Sound_Init_snd_port+0
	MOVLW      2
	MOVWF      FARG_Sound_Init_snd_pin+0
	CALL       _Sound_Init+0
;main.c,91 :: 		while (1) {
L_main10:
;main.c,92 :: 		unsigned char strobe_now = STROBE_PIN;
	MOVLW      0
	BTFSC      RB3_bit+0, BitPos(RB3_bit+0)
	MOVLW      1
	MOVWF      main_strobe_now_L1+0
;main.c,95 :: 		if (strobe_now && !prev_strobe) {
	MOVF       main_strobe_now_L1+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
	MOVF       main_prev_strobe_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main14
L__main15:
;main.c,96 :: 		cmd = read_bus();
	CALL       _read_bus+0
;main.c,97 :: 		process_command(cmd);
	MOVF       R0+0, 0
	MOVWF      FARG_process_command_cmd+0
	CALL       _process_command+0
;main.c,98 :: 		}
L_main14:
;main.c,100 :: 		prev_strobe = strobe_now;
	MOVF       main_strobe_now_L1+0, 0
	MOVWF      main_prev_strobe_L0+0
;main.c,101 :: 		}
	GOTO       L_main10
;main.c,102 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
