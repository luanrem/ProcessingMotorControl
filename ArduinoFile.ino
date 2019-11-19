#include <Stepper.h>
#define LED 13

const int stepsPerRevolution = 500;
int i=0;


//Inicializa a biblioteca utilizando as portas 8 a 11 para ligação do motor
Stepper myStepper1(stepsPerRevolution, 22, 6, 5, 7);
Stepper myStepper2(stepsPerRevolution, 24, 3, 2, 4);
int contador = 0;
int caractere = 0;

void setup() {
    myStepper1.setSpeed(27);
    myStepper2.setSpeed(50);
    pinMode(LED, OUTPUT);
    Serial.begin(9600);
}

void loop() {
    // put your main code here, to run repeatedly:

    while(Serial.available() > 0){
        caractere = serial.read();
        delay(10);

        if(caractere == "w"){

            //1º - Descer um andar (eixo Z)
            for(i = 0; i < 60; i++) {
                myStepper2.step(+1000);
            }
        }

        if(caractere == "s"){

            //1º - Descer um andar (eixo Z)
            for(i = 0; i < 60; i++) {
                myStepper2.step(-1000);
            }
        }

        if(caractere == "a"){
            //2º - Rodar meia casa para uma direação(Horizontal)
            myStepper1.step(-127);
        }

        if(caractere == "d"){
            //2º - Rodar meia casa para outra direção(Horizontal)
            myStepper1.step(+127);
        }

    }

    //1º - Descer um andar (eixo Z)
    for(i = 0; i < 60; i++) {
        myStepper2.step(+1000);
    }

    //2º - Rodar meia casa (Horizontal)
    myStepper1.step(-127);



    //3º - Levantar casinha (Eixo Z)
    for(i = 0; i < 35; i++) {
        myStepper2.step(-1000);
    }

    //4º - Descer casinha (Eixo Z)
    for(i = 0; i < 35; i++) {
        myStepper2.step(+1000);
    }

    //5º - Retorna meia casinha (Horizontal)
    myStepper1.step(+127);


    //6º - Zubir para o Zero novamente (Eixo Z)
    for(i = 0; i < 60; i++) {
        myStepper2.step(-1000);
    }

}
