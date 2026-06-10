#include <avr/io.h>
#include <util/delay.h>
#include <stdlib.h>

#define DIN   PB3
#define LOAD  PB2
#define CLK   PB5

#define BTN1 PD2
#define BTN2 PD3
#define BTN3 PD4
#define BTN4 PD5

uint8_t nivel = 1;
uint8_t secuencia[8];

void enviarPIC(uint8_t dato)
{
    PORTC = (PORTC & 0xF0) | dato;

    _delay_ms(100);

    PORTC &= 0xF0;
}

void maxSend(uint8_t reg, uint8_t data)
{
    PORTB &= ~(1 << LOAD);

    for(int8_t i=7;i>=0;i--)
    {
        if(reg & (1<<i))
            PORTB |= (1<<DIN);
        else
            PORTB &= ~(1<<DIN);

        PORTB |= (1<<CLK);
        PORTB &= ~(1<<CLK);
    }

    for(int8_t i=7;i>=0;i--)
    {
        if(data & (1<<i))
            PORTB |= (1<<DIN);
        else
            PORTB &= ~(1<<DIN);

        PORTB |= (1<<CLK);
        PORTB &= ~(1<<CLK);
    }

    PORTB |= (1<<LOAD);
}

void maxInit()
{
    maxSend(0x09,0x00);
    maxSend(0x0A,0x08);
    maxSend(0x0B,0x07);
    maxSend(0x0C,0x01);
    maxSend(0x0F,0x00);
}

void clearDisplay()
{
    for(uint8_t i=1;i<=8;i++)
        maxSend(i,0);
}

void draw(uint8_t bmp[])
{
    for(uint8_t i=0;i<8;i++)
        maxSend(i+1,bmp[i]);
}

/* FLECHAS */

uint8_t up[8]={
0x18,0x3C,0x7E,0x18,
0x18,0x18,0x18,0x00};

uint8_t right[8]={
0x10,0x18,0x1C,0xFE,
0xFE,0x1C,0x18,0x10};

uint8_t down[8]={
0x18,0x18,0x18,0x18,
0x7E,0x3C,0x18,0x00};

uint8_t left[8]={
0x08,0x18,0x38,0xFE,
0xFE,0x38,0x18,0x08};

/* OK */

uint8_t okBmp[8]={
0x00,0x01,0x03,0x66,
0x3C,0x18,0x00,0x00};

/* ERROR */

uint8_t errBmp[8]={
0x81,0x42,0x24,0x18,
0x18,0x24,0x42,0x81};

/* NUMEROS */

uint8_t num1[8]={
0x18,0x38,0x18,0x18,
0x18,0x18,0x7E,0x00};

uint8_t num2[8]={
0x3C,0x66,0x06,0x0C,
0x18,0x30,0x7E,0x00};

uint8_t num3[8]={
0x3C,0x66,0x06,0x1C,
0x06,0x66,0x3C,0x00};

uint8_t num4[8]={
0x0C,0x1C,0x3C,0x6C,
0x7E,0x0C,0x0C,0x00};

uint8_t num5[8]={
0x7E,0x60,0x7C,0x06,
0x06,0x66,0x3C,0x00};

void mostrarNivel(uint8_t n)
{
    switch(n)
    {
        case 1: draw(num1); break;
        case 2: draw(num2); break;
        case 3: draw(num3); break;
        case 4: draw(num4); break;
        case 5: draw(num5); break;
    }

    _delay_ms(1000);

    clearDisplay();
}

void mostrarFlecha(uint8_t n)
{
    switch(n)
    {
        case 0: draw(up); break;
        case 1: draw(right); break;
        case 2: draw(down); break;
        case 3: draw(left); break;
    }
}

uint8_t leerBoton()
{
    while(1)
    {
        if(!(PIND & (1<<BTN1)))
        {
            _delay_ms(50);
            while(!(PIND & (1<<BTN1)));
            return 0;
        }

        if(!(PIND & (1<<BTN2)))
        {
            _delay_ms(50);
            while(!(PIND & (1<<BTN2)));
            return 1;
        }

        if(!(PIND & (1<<BTN3)))
        {
            _delay_ms(50);
            while(!(PIND & (1<<BTN3)));
            return 2;
        }

        if(!(PIND & (1<<BTN4)))
        {
            _delay_ms(50);
            while(!(PIND & (1<<BTN4)));
            return 3;
        }
    }
}

int main()
{
    DDRB |= (1<<DIN) | (1<<LOAD) | (1<<CLK);

    DDRC |= 0x0F;

    DDRD &= ~((1<<BTN1)|(1<<BTN2)|(1<<BTN3)|(1<<BTN4));

    PORTD |= (1<<BTN1)|(1<<BTN2)|(1<<BTN3)|(1<<BTN4);

    maxInit();

    srand(123);

    for(uint8_t i=0;i<8;i++)
        secuencia[i] = rand()%4;

    while(1)
    {
        uint8_t longitud = nivel + 3;

        mostrarNivel(nivel);

        switch(nivel)
        {
            case 1: enviarPIC(5); break;
            case 2: enviarPIC(6); break;
            case 3: enviarPIC(7); break;
            case 4: enviarPIC(8); break;
            case 5: enviarPIC(9); break;
        }

        enviarPIC(1);

        for(uint8_t i=0;i<longitud;i++)
        {
            mostrarFlecha(secuencia[i]);

            switch(nivel)
            {
                case 1: _delay_ms(500); break;
                case 2: _delay_ms(450); break;
                case 3: _delay_ms(400); break;
                case 4: _delay_ms(300); break;
                case 5: _delay_ms(250); break;
            }

            clearDisplay();

            _delay_ms(120);
        }

        enviarPIC(2);

        uint8_t error = 0;

        for(uint8_t i=0;i<longitud;i++)
        {
            uint8_t tecla = leerBoton();

            if(tecla != secuencia[i])
            {
                error = 1;
                break;
            }
        }

        if(error)
        {
            draw(errBmp);

            enviarPIC(3);

            _delay_ms(2000);

            nivel = 1;

            for(uint8_t i=0;i<8;i++)
                secuencia[i] = rand()%4;
        }
        else
        {
            draw(okBmp);

            _delay_ms(1000);

            if(nivel == 5)
            {
                enviarPIC(4);

                _delay_ms(2500);

                nivel = 1;

                for(uint8_t i=0;i<8;i++)
                    secuencia[i] = rand()%4;
            }
            else
            {
                nivel++;
            }
        }

        clearDisplay();
    }
}
