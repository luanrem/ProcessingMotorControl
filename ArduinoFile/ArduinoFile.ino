#include <Stepper.h>
#define LED 13

const int stepsPerRevolution = 500;
int i=0;

//Bit control. This is what Serial recieve.
int w=1;
int s=2;
int d=3;
int a=4;
//Bit that control the distance the motor will run
float distH = 128;
int distZ = 1000;

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

    while(Serial.available() > 0){
        caractere = Serial.read();
        delay(10);

        //Subir andar
        if(caractere == w*1){
            for(i = 0; i < 60; i++) {
                myStepper2.step(+distZ);
            }
        }else if(caractere == w*5){
            for(i = 0; i < 60; i++) {
                myStepper2.step(+distZ/4);
            }
        }else if(caractere == w*9){
            for(i = 0; i < 60; i++) {
                myStepper2.step(+distZ/8);
            }
        }

        //Descer andar
        if(caractere == s*1){
            for(i = 0; i < 60; i++) {
                myStepper2.step(-distZ);
            }
        }else if(caractere == s*5){
            for(i = 0; i < 60; i++) {
                myStepper2.step(-distZ/4);
            }
        }else if(caractere == s*9){
            for(i = 0; i < 60; i++) {
                myStepper2.step(-distZ/8);
            }
        }

        //Rodar para direita
        if(caractere == d*1){
            myStepper1.step(-distH);
        }else if(caractere == d*5){
            myStepper1.step(-distH/2);
        }else if(caractere == d*9){
            myStepper1.step(-distH/4);
        }

        //Rodar para Esquerda
        if(caractere == a*1){
            myStepper1.step(+distH);
        }else if(caractere == a*5){
            myStepper1.step(+distH/2);
        }else if(caractere == a*9){
            myStepper1.step(+distH/4);
        }
caractere = 0;

digitalWrite(2, LOW);
digitalWrite(3, LOW);
digitalWrite(4, LOW);
digitalWrite(5, LOW);
digitalWrite(6, LOW);
digitalWrite(7, LOW);
digitalWrite(22, LOW);
digitalWrite(24, LOW);
 
    }
}
