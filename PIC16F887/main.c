unsigned char anterior = 0;

void melodiaInicio()
{
   Sound_Play(523,150);
   Delay_ms(180);

   Sound_Play(659,150);
   Delay_ms(180);

   Sound_Play(784,200);
}




void turnoJugador()
{
   Sound_Play(1000,100);
   Delay_ms(120);

   Sound_Play(1000,100);
}

void melodiaError()
{
   Sound_Play(250,500);
}

void melodiaVictoria()
{
   Sound_Play(523,100);
   Delay_ms(120);

   Sound_Play(659,100);
   Delay_ms(120);

   Sound_Play(784,100);
   Delay_ms(120);

   Sound_Play(1046,300);
}

void nivel1()
{
   Sound_Play(400,100);
}

void nivel2()
{
   Sound_Play(700,100);
}

void nivel3()
{
   Sound_Play(1000,100);
}

void nivel4()
{
   Sound_Play(1200,100);
}

void nivel5()
{
   Sound_Play(1400,100);
}

void main()
{
   ANSEL = 0;
   ANSELH = 0;

   TRISB = 0xFF;

   TRISC2_bit = 0;

   Sound_Init(&PORTC,2);

   while(1)
   {
      unsigned char actual;

      actual = PORTB & 0x0F;

      if(actual != anterior)
      {
         switch(actual)
         {
            case 1:
               melodiaInicio();
               break;

            case 2:
               turnoJugador();
               break;

            case 3:
               melodiaError();
               break;

            case 4:
               melodiaVictoria();
               break;

            case 5:
               nivel1();
               break;

            case 6:
               nivel2();
               break;

            case 7:
               nivel3();
               break;

            case 8:
               nivel4();
               break;

            case 9:
               nivel5();
               break;
         }

         anterior = actual;
      }
   }
}