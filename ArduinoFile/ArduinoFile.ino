#include <Stepper.h>
#define LED 13

const int stepsPerRevolution = 500;
int i=0;

int w=1;
int s=2;
int d=3;
int a=4;
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
    // put your main code here, to run repeatedly:

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
                myStepper2.step(+distZ/2);
            }
        }else if(caractere == w*9){
            for(i = 0; i < 60; i++) {
                myStepper2.step(+distZ/4);
            }
        }



        //Descer andar
        if(caractere == s*1){
            for(i = 0; i < 60; i++) {
                myStepper2.step(-distZ);
            }
        }else if(caractere == s*5){
            for(i = 0; i < 60; i++) {
                myStepper2.step(-distZ/2);
            }
        }else if(caractere == s*9){
            for(i = 0; i < 60; i++) {
                myStepper2.step(-distZ/4);
            }
        }

        //Rodar para direita
        if(caractere == d*1){
            myStepper1.step(-distH);
       }else if(caractere == d*5){
            myStepper1.step(-distH);
        }else if(caractere == d*9){
            myStepper1.step(-distH);
        }

        //Rodar para Esquerda
        if(caractere == a*1){
            myStepper1.step(+distH);
       }else if(caractere == a*5){
            myStepper1.step(+distH);
        }else if(caractere == a*9){
            myStepper1.step(+distH);
        }





        if(caractere == w*5){

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
