// PIC16F887 — Receptor de comandos y reproductor de melodías
// MikroC for PIC, oscilador externo 8 MHz

// Configuración de bits (MikroC pragma)
// Config: XT oscillator, WDT off, MCLR on, LVP off
// Bits de config en MikroC: Project > Edit Project > Device Flags

// -- Pines del bus paralelo (PORTB) ----------------------
// RB0 = D0, RB1 = D1, RB2 = D2, RB3 = STROBE
#define STROBE_PIN  RB3_bit

// -- Buzzer en RC2 (CCP1, PWM Timer2) --------------------
// MikroC tiene librería Sound que usa RC2 automáticamente

// -- Frecuencias de cada color (Hz) ----------------------
#define FREQ_GREEN   262u   // Do4
#define FREQ_RED     330u   // Mi4
#define FREQ_BLUE    392u   // Sol4
#define FREQ_YELLOW  523u   // Do5

// -- Duración nota simple (ms) ----------------------------
#define NOTE_DUR     400u

// -- Prototipos -------------------------------------------
void play_note(unsigned int freq, unsigned int dur_ms);
void melody_start(void);
void melody_win(void);
void melody_fail(void);
void process_command(unsigned char cmd);

// -- Leer bus: 3 bits de datos ----------------------------
unsigned char read_bus(void) {
    return (unsigned char)(PORTB & 0x07);  // máscara bits 0-2
}

// -- Tocar nota usando Sound_Play de MikroC ---------------
void play_note(unsigned int freq, unsigned int dur_ms) {
    Sound_Play(freq, dur_ms);
}

// -- Melodías de evento -----------------------------------
void melody_start(void) {
    // Escala ascendente rápida
    play_note(262, 120);
    play_note(330, 120);
    play_note(392, 120);
    play_note(523, 200);
}

void melody_win(void) {
    // Fanfarria corta
    play_note(523, 150);
    play_note(523, 150);
    play_note(523, 150);
    play_note(659, 400);
}

void melody_fail(void) {
    // Descenso grave
    play_note(200, 150);
    play_note(150, 150);
    play_note(100, 300);
}

// -- Procesar comando recibido ----------------------------
void process_command(unsigned char cmd) {
    switch (cmd) {
        case 0: break;  // silencio
        case 1: play_note(FREQ_GREEN,  NOTE_DUR); break;
        case 2: play_note(FREQ_RED,    NOTE_DUR); break;
        case 3: play_note(FREQ_BLUE,   NOTE_DUR); break;
        case 4: play_note(FREQ_YELLOW, NOTE_DUR); break;
        case 5: melody_start(); break;
        case 6: melody_win();   break;
        case 7: melody_fail();  break;
    }
}

// -- main -------------------------------------------------
void main(void) {
    unsigned char prev_strobe = 0;
    unsigned char cmd = 0;

    // Configurar PORTB como entrada
    TRISB = 0xFF;
    TRISC = 0x00;   // RC2 salida (PWM buzzer)

    // Inicializar librería Sound (usa Timer2 + CCP1 en RC2)
    Sound_Init(&PORTC, 2);  // RC2

    while (1) {
        unsigned char strobe_now = STROBE_PIN;

        // Detectar flanco ascendente del strobe
        if (strobe_now && !prev_strobe) {
            cmd = read_bus();
            process_command(cmd);
        }

        prev_strobe = strobe_now;
    }
}