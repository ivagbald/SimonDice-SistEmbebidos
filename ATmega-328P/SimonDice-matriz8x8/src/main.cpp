// ATmega328P — Simon Says
// PlatformIO, framework: avr, board: uno
// main.c

#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <stdlib.h>

// ── Pines ──────────────────────────────────────────────
#define BTN_GREEN  PD2
#define BTN_RED    PD3
#define BTN_BLUE   PD4
#define BTN_YELLOW PD5
#define COM_D0     PC0   // bus paralelo datos
#define COM_D1     PC1
#define COM_D2     PC2
#define COM_STB    PC3   // strobe

// MAX7219 SPI (manual bitbang — más claro en C nativo)
#define MAX_CS     PB2
#define MAX_DIN    PB3
#define MAX_CLK    PB5

// ── Registros MAX7219 ───────────────────────────────────
#define REG_DECODE   0x09
#define REG_INTENSITY 0x0A
#define REG_SCANLIMIT 0x0B
#define REG_SHUTDOWN 0x0C
#define REG_TEST     0x0F

// ── Colores / comandos ──────────────────────────────────
#define COLOR_GREEN   1
#define COLOR_RED     2
#define COLOR_BLUE    3
#define COLOR_YELLOW  4
#define CMD_MELODY_START   5
#define CMD_MELODY_WIN     6
#define CMD_MELODY_FAIL    7
#define CMD_SILENCE        0

// ── Niveles ─────────────────────────────────────────────
#define LVL1_MAX  5
#define LVL2_MAX  8
#define LVL3_MAX  12
#define LVL1_DLY  800
#define LVL2_DLY  500
#define LVL3_DLY  300

// ── Patrones LED por cuadrante (8 filas, bit=columna) ──
// Verde: cuadrante inferior-izquierdo (filas 4-7, cols 0-3)
const uint8_t pat_green[8]  = {0x00,0x00,0x00,0x00,0x0F,0x0F,0x0F,0x0F};
// Rojo:  cuadrante superior-izquierdo (filas 0-3, cols 0-3)
const uint8_t pat_red[8]    = {0x0F,0x0F,0x0F,0x0F,0x00,0x00,0x00,0x00};
// Azul:  cuadrante superior-derecho   (filas 0-3, cols 4-7)
const uint8_t pat_blue[8]   = {0xF0,0xF0,0xF0,0xF0,0x00,0x00,0x00,0x00};
// Amarillo: cuadrante inferior-derecho (filas 4-7, cols 4-7)
const uint8_t pat_yellow[8] = {0x00,0x00,0x00,0x00,0xF0,0xF0,0xF0,0xF0};
// Error: X en toda la pantalla
const uint8_t pat_error[8]  = {0x81,0x42,0x24,0x18,0x18,0x24,0x42,0x81};
// Win: carita feliz
const uint8_t pat_win[8]    = {0x3C,0x42,0xA5,0x81,0xA5,0x99,0x42,0x3C};
// Pantalla vacía
const uint8_t pat_blank[8]  = {0,0,0,0,0,0,0,0};

// Letras L1, L2, L3 para mostrar nivel (simplificadas 8x8)
const uint8_t pat_L1[8] = {0x60,0x20,0x20,0x20,0x20,0x23,0x3F,0x00};
const uint8_t pat_L2[8] = {0x60,0x20,0x20,0x0E,0x10,0x30,0x3F,0x00};
const uint8_t pat_L3[8] = {0x60,0x20,0x20,0x0E,0x02,0x22,0x1C,0x00};

// ── Variables globales ──────────────────────────────────
uint8_t sequence[LVL3_MAX];
uint8_t seq_len = 0;
uint8_t nivel   = 1;

// ── MAX7219: funciones SPI bitbang ──────────────────────
static void max_write_byte(uint8_t b) {
    for (int i = 7; i >= 0; i--) {
        if (b & (1 << i)) PORTB |=  (1 << MAX_DIN);
        else               PORTB &= ~(1 << MAX_DIN);
        PORTB |=  (1 << MAX_CLK);
        PORTB &= ~(1 << MAX_CLK);
    }
}

static void max_write(uint8_t reg, uint8_t data) {
    PORTB &= ~(1 << MAX_CS);
    max_write_byte(reg);
    max_write_byte(data);
    PORTB |=  (1 << MAX_CS);
}

static void max_init(void) {
    max_write(REG_TEST,     0x00);
    max_write(REG_SHUTDOWN, 0x01);  // normal operation
    max_write(REG_DECODE,   0x00);  // sin decodificación BCD
    max_write(REG_SCANLIMIT,0x07);  // 8 dígitos
    max_write(REG_INTENSITY,0x08);  // brillo medio
}

static void max_display(const uint8_t *pat) {
    for (uint8_t row = 0; row < 8; row++)
        max_write(row + 1, pat[row]);
}

// ── Comunicación con PIC ────────────────────────────────
static void pic_send(uint8_t cmd) {
    // escribir 3 bits de datos
    if (cmd & 1) PORTC |=  (1 << COM_D0); else PORTC &= ~(1 << COM_D0);
    if (cmd & 2) PORTC |=  (1 << COM_D1); else PORTC &= ~(1 << COM_D1);
    if (cmd & 4) PORTC |=  (1 << COM_D2); else PORTC &= ~(1 << COM_D2);
    _delay_us(10);                          // bus settle
    PORTC |=  (1 << COM_STB);             // strobe HIGH
    _delay_us(50);
    PORTC &= ~(1 << COM_STB);             // strobe LOW
}

// ── Lectura de botones (retorna 0 si ninguno) ───────────
static uint8_t read_button(void) {
    if (!(PIND & (1 << BTN_GREEN)))  return COLOR_GREEN;
    if (!(PIND & (1 << BTN_RED)))    return COLOR_RED;
    if (!(PIND & (1 << BTN_BLUE)))   return COLOR_BLUE;
    if (!(PIND & (1 << BTN_YELLOW))) return COLOR_YELLOW;
    return 0;
}

static void wait_button_release(void) {
    while (read_button()) _delay_ms(10);
}

// ── Mostrar un color con sonido ─────────────────────────
static void show_color(uint8_t color, uint16_t dur_ms) {
    const uint8_t *pat;
    switch (color) {
        case COLOR_GREEN:  pat = pat_green;  break;
        case COLOR_RED:    pat = pat_red;    break;
        case COLOR_BLUE:   pat = pat_blue;   break;
        case COLOR_YELLOW: pat = pat_yellow; break;
        default: return;
    }
    pic_send(color);
    max_display(pat);
    _delay_ms(dur_ms);
    max_display(pat_blank);
    pic_send(CMD_SILENCE);
    _delay_ms(100);
}

// ── Mostrar nivel brevemente ────────────────────────────
static void show_level(void) {
    const uint8_t *pat;
    switch (nivel) {
        case 1: pat = pat_L1; break;
        case 2: pat = pat_L2; break;
        default:pat = pat_L3; break;
    }
    max_display(pat);
    _delay_ms(1200);
    max_display(pat_blank);
    _delay_ms(300);
}

// ── Animación de error ──────────────────────────────────
static void anim_error(void) {
    pic_send(CMD_MELODY_FAIL);
    for (uint8_t i = 0; i < 3; i++) {
        max_display(pat_error);
        _delay_ms(250);
        max_display(pat_blank);
        _delay_ms(150);
    }
    pic_send(CMD_SILENCE);
}

// ── Animación de victoria ───────────────────────────────
static void anim_win(void) {
    pic_send(CMD_MELODY_WIN);
    max_display(pat_win);
    _delay_ms(2000);
    max_display(pat_blank);
    pic_send(CMD_SILENCE);
}

// ── Parámetros según nivel ──────────────────────────────
static uint8_t nivel_max_seq(void) {
    if (nivel == 1) return LVL1_MAX;
    if (nivel == 2) return LVL2_MAX;
    return LVL3_MAX;
}
static uint16_t nivel_delay(void) {
    if (nivel == 1) return LVL1_DLY;
    if (nivel == 2) return LVL2_DLY;
    return LVL3_DLY;
}
static uint16_t nivel_timeout(void) {
    // timeout por pulsación (ms), nivel 3 más corto
    if (nivel == 1) return 8000;
    if (nivel == 2) return 5000;
    return 3000;
}

// ── Lógica principal del juego ──────────────────────────
static void game_loop(void) {
    seq_len = 0;

    while (1) {
        // Agregar color aleatorio a la secuencia
        sequence[seq_len] = (rand() % 4) + 1;
        seq_len++;

        // Mostrar secuencia completa
        _delay_ms(600);
        for (uint8_t i = 0; i < seq_len; i++)
            show_color(sequence[i], nivel_delay());

        // Leer respuesta del jugador
        for (uint8_t i = 0; i < seq_len; i++) {
            uint16_t timeout = nivel_timeout();
            uint8_t pressed = 0;

            // Esperar pulsación con timeout
            while (timeout > 0) {
                pressed = read_button();
                if (pressed) break;
                _delay_ms(10);
                timeout -= 10;
            }

            if (!pressed) { anim_error(); return; }  // timeout

            // Mostrar feedback visual del botón presionado
            show_color(pressed, 300);
            wait_button_release();
            _delay_ms(50);

            if (pressed != sequence[i]) { anim_error(); return; }  // error
        }

        // Verificar victoria de nivel
        if (seq_len >= nivel_max_seq()) {
            anim_win();
            // Subir de nivel si no está en 3
            if (nivel < 3) { nivel++; show_level(); }
            return;  // reinicia el juego con nueva secuencia
        }
    }
}

// ── main ────────────────────────────────────────────────
int main(void) {
    // Configurar pines
    DDRB |=  (1 << MAX_CS) | (1 << MAX_DIN) | (1 << MAX_CLK);
    DDRC |=  (1 << COM_D0) | (1 << COM_D1) | (1 << COM_D2) | (1 << COM_STB);
    DDRD &= ~((1<<BTN_GREEN)|(1<<BTN_RED)|(1<<BTN_BLUE)|(1<<BTN_YELLOW));
    PORTD |=  (1<<BTN_GREEN)|(1<<BTN_RED)|(1<<BTN_BLUE)|(1<<BTN_YELLOW); // pull-ups

    PORTB |= (1 << MAX_CS);   // CS inactivo
    PORTC  = 0x00;

    max_init();
    srand(42);  // semilla fija (en producción usar ADC flotante)

    // Inicio
    pic_send(CMD_MELODY_START);
    show_level();
    _delay_ms(500);

    while (1) {
        game_loop();
        _delay_ms(1000);
        show_level();
    }
}