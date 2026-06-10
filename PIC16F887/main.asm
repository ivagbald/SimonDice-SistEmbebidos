
_melodiaInicio:

;main.c,3 :: 		void melodiaInicio()
;main.c,5 :: 		Sound_Play(523,150);
	MOVLW      11
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      150
	MOVWF      FARG_Sound_Play_duration_ms+0
	CLRF       FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,6 :: 		Delay_ms(180);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      212
	MOVWF      R12+0
	MOVLW      133
	MOVWF      R13+0
L_melodiaInicio0:
	DECFSZ     R13+0, 1
	GOTO       L_melodiaInicio0
	DECFSZ     R12+0, 1
	GOTO       L_melodiaInicio0
	DECFSZ     R11+0, 1
	GOTO       L_melodiaInicio0
;main.c,8 :: 		Sound_Play(659,150);
	MOVLW      147
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      150
	MOVWF      FARG_Sound_Play_duration_ms+0
	CLRF       FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,9 :: 		Delay_ms(180);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      212
	MOVWF      R12+0
	MOVLW      133
	MOVWF      R13+0
L_melodiaInicio1:
	DECFSZ     R13+0, 1
	GOTO       L_melodiaInicio1
	DECFSZ     R12+0, 1
	GOTO       L_melodiaInicio1
	DECFSZ     R11+0, 1
	GOTO       L_melodiaInicio1
;main.c,11 :: 		Sound_Play(784,200);
	MOVLW      16
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      200
	MOVWF      FARG_Sound_Play_duration_ms+0
	CLRF       FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,12 :: 		}
L_end_melodiaInicio:
	RETURN
; end of _melodiaInicio

_turnoJugador:

;main.c,14 :: 		void turnoJugador()
;main.c,16 :: 		Sound_Play(1000,100);
	MOVLW      232
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,17 :: 		Delay_ms(120);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      56
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_turnoJugador2:
	DECFSZ     R13+0, 1
	GOTO       L_turnoJugador2
	DECFSZ     R12+0, 1
	GOTO       L_turnoJugador2
	DECFSZ     R11+0, 1
	GOTO       L_turnoJugador2
;main.c,19 :: 		Sound_Play(1000,100);
	MOVLW      232
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,20 :: 		}
L_end_turnoJugador:
	RETURN
; end of _turnoJugador

_melodiaError:

;main.c,22 :: 		void melodiaError()
;main.c,24 :: 		Sound_Play(250,500);
	MOVLW      250
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	CLRF       FARG_Sound_Play_freq_in_hz+1
	MOVLW      244
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,25 :: 		}
L_end_melodiaError:
	RETURN
; end of _melodiaError

_melodiaVictoria:

;main.c,27 :: 		void melodiaVictoria()
;main.c,29 :: 		Sound_Play(523,100);
	MOVLW      11
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,30 :: 		Delay_ms(120);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      56
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_melodiaVictoria3:
	DECFSZ     R13+0, 1
	GOTO       L_melodiaVictoria3
	DECFSZ     R12+0, 1
	GOTO       L_melodiaVictoria3
	DECFSZ     R11+0, 1
	GOTO       L_melodiaVictoria3
;main.c,32 :: 		Sound_Play(659,100);
	MOVLW      147
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,33 :: 		Delay_ms(120);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      56
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_melodiaVictoria4:
	DECFSZ     R13+0, 1
	GOTO       L_melodiaVictoria4
	DECFSZ     R12+0, 1
	GOTO       L_melodiaVictoria4
	DECFSZ     R11+0, 1
	GOTO       L_melodiaVictoria4
;main.c,35 :: 		Sound_Play(784,100);
	MOVLW      16
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,36 :: 		Delay_ms(120);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      56
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_melodiaVictoria5:
	DECFSZ     R13+0, 1
	GOTO       L_melodiaVictoria5
	DECFSZ     R12+0, 1
	GOTO       L_melodiaVictoria5
	DECFSZ     R11+0, 1
	GOTO       L_melodiaVictoria5
;main.c,38 :: 		Sound_Play(1046,300);
	MOVLW      22
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      4
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      44
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,39 :: 		}
L_end_melodiaVictoria:
	RETURN
; end of _melodiaVictoria

_nivel1:

;main.c,41 :: 		void nivel1()
;main.c,43 :: 		Sound_Play(400,100);
	MOVLW      144
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,44 :: 		}
L_end_nivel1:
	RETURN
; end of _nivel1

_nivel2:

;main.c,46 :: 		void nivel2()
;main.c,48 :: 		Sound_Play(700,100);
	MOVLW      188
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      2
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,49 :: 		}
L_end_nivel2:
	RETURN
; end of _nivel2

_nivel3:

;main.c,51 :: 		void nivel3()
;main.c,53 :: 		Sound_Play(1000,100);
	MOVLW      232
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      3
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,54 :: 		}
L_end_nivel3:
	RETURN
; end of _nivel3

_nivel4:

;main.c,56 :: 		void nivel4()
;main.c,58 :: 		Sound_Play(1200,100);
	MOVLW      176
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      4
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,59 :: 		}
L_end_nivel4:
	RETURN
; end of _nivel4

_nivel5:

;main.c,61 :: 		void nivel5()
;main.c,63 :: 		Sound_Play(1400,100);
	MOVLW      120
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      5
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;main.c,64 :: 		}
L_end_nivel5:
	RETURN
; end of _nivel5

_main:

;main.c,66 :: 		void main()
;main.c,68 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;main.c,69 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;main.c,71 :: 		TRISB = 0xFF;
	MOVLW      255
	MOVWF      TRISB+0
;main.c,73 :: 		TRISC2_bit = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;main.c,75 :: 		Sound_Init(&PORTC,2);
	MOVLW      PORTC+0
	MOVWF      FARG_Sound_Init_snd_port+0
	MOVLW      2
	MOVWF      FARG_Sound_Init_snd_pin+0
	CALL       _Sound_Init+0
;main.c,77 :: 		while(1)
L_main6:
;main.c,81 :: 		actual = PORTB & 0x0F;
	MOVLW      15
	ANDWF      PORTB+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      main_actual_L1+0
;main.c,83 :: 		if(actual != anterior)
	MOVF       R1+0, 0
	XORWF      _anterior+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main8
;main.c,85 :: 		switch(actual)
	GOTO       L_main9
;main.c,87 :: 		case 1:
L_main11:
;main.c,88 :: 		melodiaInicio();
	CALL       _melodiaInicio+0
;main.c,89 :: 		break;
	GOTO       L_main10
;main.c,91 :: 		case 2:
L_main12:
;main.c,92 :: 		turnoJugador();
	CALL       _turnoJugador+0
;main.c,93 :: 		break;
	GOTO       L_main10
;main.c,95 :: 		case 3:
L_main13:
;main.c,96 :: 		melodiaError();
	CALL       _melodiaError+0
;main.c,97 :: 		break;
	GOTO       L_main10
;main.c,99 :: 		case 4:
L_main14:
;main.c,100 :: 		melodiaVictoria();
	CALL       _melodiaVictoria+0
;main.c,101 :: 		break;
	GOTO       L_main10
;main.c,103 :: 		case 5:
L_main15:
;main.c,104 :: 		nivel1();
	CALL       _nivel1+0
;main.c,105 :: 		break;
	GOTO       L_main10
;main.c,107 :: 		case 6:
L_main16:
;main.c,108 :: 		nivel2();
	CALL       _nivel2+0
;main.c,109 :: 		break;
	GOTO       L_main10
;main.c,111 :: 		case 7:
L_main17:
;main.c,112 :: 		nivel3();
	CALL       _nivel3+0
;main.c,113 :: 		break;
	GOTO       L_main10
;main.c,115 :: 		case 8:
L_main18:
;main.c,116 :: 		nivel4();
	CALL       _nivel4+0
;main.c,117 :: 		break;
	GOTO       L_main10
;main.c,119 :: 		case 9:
L_main19:
;main.c,120 :: 		nivel5();
	CALL       _nivel5+0
;main.c,121 :: 		break;
	GOTO       L_main10
;main.c,122 :: 		}
L_main9:
	MOVF       main_actual_L1+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVF       main_actual_L1+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main12
	MOVF       main_actual_L1+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main13
	MOVF       main_actual_L1+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main14
	MOVF       main_actual_L1+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main15
	MOVF       main_actual_L1+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main16
	MOVF       main_actual_L1+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main17
	MOVF       main_actual_L1+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	MOVF       main_actual_L1+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main19
L_main10:
;main.c,124 :: 		anterior = actual;
	MOVF       main_actual_L1+0, 0
	MOVWF      _anterior+0
;main.c,125 :: 		}
L_main8:
;main.c,126 :: 		}
	GOTO       L_main6
;main.c,127 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
