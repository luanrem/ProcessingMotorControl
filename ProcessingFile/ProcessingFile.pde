import processing.serial.*;

Serial myPort;

//defining the shapes
int rectX, rectY;
int rect1X, rect1Y;
int rect2X, rect2Y;
int rect3X, rect3Y;
int mod1X, mod1Y;
int mod2X, mod2Y;
int mod3X, mod3Y;
int rectSize = 120;
int modSize = 50;
color rectColor, rect1Color, rect2Color, rect3Color, baseColor, mod1Color, mod2Color, mod3Color;
color rectHighlight, rect1Highlight, rect2Highlight, rect3Highlight, mod1Highlight, mod2Highlight, mod3Highlight;
color pressColor, selectColor;
//setting the booleans for the mousover interaction
boolean[] Over;
boolean[] sizeRoute;

int mov;


void setup() {

    //Set the Over Array to "false"
    Over = new boolean[7];
    for (int i=0; i <7; i++){
        Over[i] = false; 
        println(Over[i]);
    }

    //Set the sizeRoute array to "false" except for the first one
    sizeRoute = new boolean[3];
    for (int i=1; i <3; i++){
        sizeRoute[i] = false; 
        println(sizeRoute[i]);
    } 
    sizeRoute[0] = true;

    size(1200, 800);
    //myPort = new Serial(this, "/dev/ttyACM0", 115200);
    myPort = new Serial(this, "COM6", 9600);
    
    //colors of the buttons
    rectColor = color(30);
    rectHighlight = color(100);
    rect1Color = color(30);
    rect1Highlight = color(100);
    rect2Color = color(30);
    rect2Highlight = color(100);
    rect3Color = color(30);
    rect3Highlight = color(100);
    mod1Color = color(30);
    mod1Highlight = color(100);
    mod2Color = color(30);
    mod2Highlight = color(100);
    mod3Color = color(30);
    mod3Highlight = color(100);

    pressColor = color(150, 50, 150);
    selectColor = color(90, 70, 200);


    //position of the buttons Rect
    rectX = width/4 -100;
    rectY = height/2;
    rect1X = width/4 -100;
    rect1Y = height*3/4;
    rect2X = width/4 + rectSize - 100;
    rect2Y = height/4;
    rect3X = width/4 - 100 - rectSize;
    rect3Y = height/4;

    //position of the butons MOD
    mod1X = width/2 - 50;
    mod1Y = height*2/3 - 100;
    mod2X = width/2 - 50;
    mod2Y = height*2/3;
    mod3X = width/2 - 50;
    mod3Y = height*2/3 + 100;



    background(100, 200, 200);
    //texts on the interface
    textSize(60);
    fill(100);
    text("Dispensador Automático - TCC2", 150, 60);
    textSize(30);
    fill(0);
    text("100%", width/2 + 20, height*2/3 - 60);
    text("50%", width/2 + 20, height*2/3 + 40);
    text("25%", width/2 + 20, height*2/3 + 140);

    text("Luan R. E. Martins", 800, 200);
    text("Flavia", 800, 200 + 40);
    text("Mathias", 800, 200 + 80);
    text("Alunos:", 700, 150);
    //textSize(40);
    //fill(0);
    //text("Node 3", 680, 150);

    //Faixa desenhada
    noStroke();
    fill(100);
    rect(0, 350, 1200, 20);

    //Rotational Axis Text
    textSize(30);
    fill(100);
    text("Eixo Rotacional", 150, 180);
    textSize(40);
    fill(0);

    //Text of Z axis
    float x = 180;
    float y = 550;
    textAlign(CENTER,BOTTOM);
    textSize(30);
    pushMatrix();
    translate(x,y);
    fill(100);
    rotate(-HALF_PI);
    text("Eixo Z",0,0);
    fill(0);
    popMatrix();




}

void draw() {

    update(mouseX, mouseY);

    //to get the opacity on mouseover
    if (Over[0]) {
        if(mousePressed){
            fill(pressColor); 
        }else fill(rectHighlight);
    }else fill(rectColor);
    rect(rectX, rectY, rectSize, rectSize, 15);

    if (Over[1]) {
        if(mousePressed){
            fill(pressColor); 
        }else fill(rect1Highlight);
    } else fill(rect1Color);
    rect(rect1X, rect1Y, rectSize, rectSize, 15);

    if (Over[2]) {
        if(mousePressed){
            fill(pressColor); 
        }else fill(rect2Highlight);
    } else fill(rect2Color);
    rect(rect2X, rect2Y, rectSize, rectSize, 15);

    if (Over[3]) {
        if(mousePressed){
            fill(pressColor); 
        }else fill(rect3Highlight);
    } else fill(rect3Color);
    rect(rect3X, rect3Y, rectSize, rectSize, 15);

    if (Over[4]) {
        if(mousePressed){
            sizeRoute[0] = true;
            sizeRoute[1] = false;
            sizeRoute[2] = false;
            fill(pressColor); 
        }else fill(mod1Highlight);
    } else fill(mod1Color);
    if(sizeRoute[0] == true) fill(selectColor);
    rect(mod1X, mod1Y, modSize, modSize, 15);

    if (Over[5]) {
        if(mousePressed){
            sizeRoute[0] = false;
            sizeRoute[1] = true;
            sizeRoute[2] = false;
            fill(pressColor); 
        }else fill(mod2Highlight);
    } else fill(mod2Color);
    if(sizeRoute[1] == true) fill(selectColor);
    rect(mod2X, mod2Y, modSize, modSize, 15);

    if (Over[6]) {
        if(mousePressed){
            sizeRoute[0] = false;
            sizeRoute[1] = false;
            sizeRoute[2] = true;
            fill(pressColor); 
        }else fill(mod3Highlight);
    } else fill(mod3Color);
    if(sizeRoute[2] == true) fill(selectColor);
    rect(mod3X, mod3Y, modSize, modSize, 15);

}

//gets as input the mouse position and checks whether the cursor is on top of any of the three buttons
void update(int x, int y) {
    for (int i=0; i <7; i++){
        Over[i] = false; 
    }
    if ( overRect(rectX, rectY, rectSize, rectSize) ) {
        Over[0] = true;
    } else if ( overRect1(rect1X, rect1Y, rectSize, rectSize) ) {
        Over[1] = true;
    }  else if ( overRect2(rect2X, rect2Y, rectSize, rectSize) ) {
        Over[2] = true;
    }  else if ( overRect3(rect3X, rect3Y, rectSize, rectSize) ) {
        Over[3] = true;
    }  else if ( overMod1(mod1X, mod1Y, modSize, modSize) ) {
        Over[4] = true;
    }  else if ( overMod2(mod2X, mod2Y, modSize, modSize) ) {
        Over[5] = true;
    }  else if ( overMod3(mod3X, mod3Y, modSize, modSize) ) {
        Over[6] = true;
    }else{
        for (int i=0; i <7; i++){Over[i] = false;}
    }



}
//events when the mouse is pressed: send a value through serial. Also, a check on the monitor is done to see whether the values are actually sent.
void mousePressed() {

    if (mousePressed && Over[1]) {
        mov = size(0)* 1; 
        //myPort.write('w');
        
        myPort.write(mov);
        println(mov);
    }
    if (mousePressed && Over[0]) {
        mov = size(0)*2; 
        //myPort.write('s');

          myPort.write(mov);
    println(mov);
    }
    if (mousePressed && Over[2]) {
        mov = size(0)*3; 
        //myPort.write('d');

        myPort.write(mov);
    println(mov);    }
    if (mousePressed && Over[3]) {
        mov = size(0)*4; 
        //myPort.write('a');
        
       myPort.write(mov);
    println(mov);
    }
        //myPort.write(mov);
    //println(mov);
}

boolean overRect(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width &&
            mouseY >= y && mouseY <= y+height) {
        return true;
    } else {
        return false;
    }
}

boolean overRect1(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width &&
            mouseY >= y && mouseY <= y+height) {
        return true;
    } else {
        return false;
    }
}

boolean overRect2(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width &&
            mouseY >= y && mouseY <= y+height) {
        return true;
    } else {
        return false;
    }
}

boolean overRect3(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width &&
            mouseY >= y && mouseY <= y+height) {
        return true;
    } else {
        return false;
    }
}

boolean overMod1(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width &&
            mouseY >= y && mouseY <= y+height) {
        return true;
    } else {
        return false;
    }
}

boolean overMod2(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width &&
            mouseY >= y && mouseY <= y+height) {
        return true;
    } else {
        return false;
    }
}

boolean overMod3(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width &&
            mouseY >= y && mouseY <= y+height) {
        return true;
    } else {
        return false;
    }
}

int size(int X){
    if(sizeRoute[0] == true) X = 1; 
    if(sizeRoute[1] == true) X = 5; 
    if(sizeRoute[2] == true) X = 9;
    return X;
}
