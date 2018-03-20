import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;

Box2DProcessing Bisel;

int loading,lua,ki,timp,oelo,point = 0,win = 0,lost = 0;
float xme,yme;

Bloques Base_ini;
Bloques BaseMeta1;
Bloques BaseMeta2;
Bloques BaseMeta3;
Cyrcles Meta;
ArrayList <Bloques> stable;

float
posX1,
posY1,
posX2,
posY2,
angle;
boolean error, load;

void setup(){
 size(800,450);
 smooth();
 
 posX1 = random(70,width-70);
 posY1 = random(150,height/2);
 posX2 = random(70,width-70);
 posY2 = random(height/2+50,height-80);
 //posX2 = width/2;
 //posY2 = height-80;
 
 if (posX1 > width/2){
  angle = -20;
 }
 else{
  angle = 20;
 }
 
 Bisel = new Box2DProcessing(this);
 Bisel.createWorld();
 Bisel.setGravity(0,-90);
 
 // X Y Ancho Alto Fisica Material
 Base_ini = new Bloques(posX1,posY1,100,10,angle,2,1);
 BaseMeta1 = new Bloques(posX2,posY2+40,100,10,0,2,0);
 BaseMeta2 = new Bloques(posX2-45,posY2,10,70,0,2,0);
 BaseMeta3 = new Bloques(posX2+45,posY2,10,70,0,2,0);
 Meta = new Cyrcles(posX1,posY1-50,30);
 
 stable = new ArrayList <Bloques>();
 
 loading = 0; lua = 0; ki = 0; timp = 0; oelo = 0;
 
 if ((xme < -300 || xme > width+300) || (yme < -300 || yme > height+300) || load){
  point -= 5;
  lost += 1;
 }
 if (error){
  point += 5;
  win += 1;
 }
}
void draw(){
 //Bisel.step();
 background(#5A5A5A);
 error = (xme > posX2-40 && xme < posX2+40) && (yme > posY2-35 && yme < posY2+35);
 load = loading == 1;
 //print(posX2,posY2,"\t\t",xme,"\t",yme,"\n");
 
 Base_ini.Visible();
 BaseMeta1.Visible();
 BaseMeta2.Visible();
 BaseMeta3.Visible();
 Meta.Visible();
 
 if (mouseX < width && mouseX > 0 && mouseY < height && mouseY > 0){
  if (mousePressed && mouseButton == LEFT && lua != 1 && ki != 1){
   stable.add(new Bloques(mouseX,mouseY,10,10,0,2,2));
  }
 }
 for(Bloques kya: stable){
  kya.Visible();
 }
 
 if (loading == 1){
  Bad_msg();
  lua = 1;
 }
 //xme > 680 && xme < 760 && yme > 345 && yme < 415
 if (xme > posX2-40 && xme < posX2+40 && yme > posY2-35 && yme < posY2+35){
  Good_msg();
  loading = 2;
  lua = 1;
 }
 if (ki == 1){
  Bisel.step();
  timp += 10;
 }
 if (frameRate < 10){
  setup();
 }
 if (timp > 9000 && ki == 1){
  loading = 1;
 }
 
 if(key == 'a' || key == 'A'){oelo = 1;} if (oelo == 1){help();}else{}
 
 stroke(240,128); strokeWeight(2);
 fill(10,45,60,64); rectMode(CORNERS); rect(posX2-40,posY2-35,posX2+40,posY2+35);
 
 textSize(25); fill(255); textAlign(RIGHT,TOP);// text(timp,width-10,10);
 textAlign(RIGHT,TOP); text("puntos",width-10,10); text(point,width-100,10); text(lost,width/2-130,10);
 text("perdidas",width/2-10,10); textAlign(LEFT,TOP); text("ganadas",width/2+10,10); text(win,width/2+130,10);
 textAlign(LEFT,TOP); if (ki == 0){text("Pause",10,10);} if (ki == 1){text("Play",10,10);}
 textSize(16);
 textAlign(CENTER,BOTTOM); text("¿Necesitas ayuda?, presiona 'A'",width/2,height-10);
 stroke(240); strokeWeight(3); line(width/2,0,width/2,50); line(0,50,width,50); strokeWeight(1); line(width/2-210,0,width/2-190,50); line(width/2+210,0,width/2+190,50);
}

void keyPressed(){
 if (loading == 1 || loading == 2){
  if (key == ENTER){
   setup();
  }
 }
 if (key == 'p' || key == 'P'){
  ki = 1;
 }
}

// - ( external )
void Bad_msg(){
 rectMode(CORNERS);
 fill(10,10,10,120);
 rect(0,0,width,height);
 fill(255);
 textAlign(CENTER,CENTER);
 textSize(50);
 text("Level Failed",width/2,height/2-40);
 textSize(20);
 text("Presione 'Enter' para volver a intentar",width/2,height/2+40);
}
void Good_msg(){
 rectMode(CORNERS);
 fill(210,210,210,80);
 rect(0,0,width,height);
 fill(255);
 textAlign(CENTER,CENTER);
 textSize(50);
 text("Level Finish",width/2,height/2-40);
 textSize(20);
 text("Presione 'Enter' para el siguiente nivel",width/2,height/2+40);
}
void help(){
 stroke(240,128); strokeWeight(2);
 fill(10,45,60,64); rectMode(CENTER); rect(width/2,height/2,500,300,8);
 fill(255);
 textAlign(CENTER,TOP); textSize(24);
 text("Ventana de Ayuda",width/2,height/2-140);
 textAlign(LEFT,TOP); textSize(16);
 text("Manten presionado el boton izquierdo del raton para\ndibujar el camino.\nSi despues de un rato la Bola se queda estancado, \npierdes el nivel",width/2-220,height/2-90);
 //text("Presiona 'T' para la puntuación",width/2-220,height/2+60);
 text("Presiona 'P' para ejecutar",width/2-220,height/2+85);
 text("Presiona 'Enter' para salir de ayuda",width/2-220,height/2+110);
 if (key == ENTER && oelo == 1){
  oelo = 0;
 }
}
void noLoop(){
}