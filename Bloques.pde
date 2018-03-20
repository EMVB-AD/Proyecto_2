class Bloques{
 float x,y,w,h,a; int prop,matt; Body BG;
 Bloques(float x_,float y_,float w_,float h_,float a_,int prop_,int mattel){
  x = x_;
  y = y_;
  w = w_;
  h = h_;
  a = a_;
  prop = prop_;
  matt = mattel;
  
  Vec2 V1 = Bisel.coordPixelsToWorld(new Vec2(x,y));
  
  BodyDef Cog = new BodyDef();
  switch (prop){
   case 1: Cog.type = BodyType.DYNAMIC; break;
   case 2: Cog.type = BodyType.STATIC; break;
   //default: Cog.type = BodyType.KINEMATIC; break;
   default: Cog.type = BodyType.DYNAMIC; break;
  }
  Cog.angle = a * -0.0174533;
  Cog.position.set(V1);
  
  BG = Bisel.createBody(Cog);
  
  PolygonShape POL = new PolygonShape();
  float wii = Bisel.scalarPixelsToWorld(w/2);
  float hei = Bisel.scalarPixelsToWorld(h/2);
  POL.setAsBox(wii,hei);
  FixtureDef Prop = new FixtureDef();
  Prop.shape = POL;
  switch(prop){
   case 1: Prop.density = 0.8; Prop.friction = 0.8; Prop.restitution = 0.6; break; // bola
   case 2: Prop.density = 1; Prop.friction = 0.8; Prop.restitution = 0.2; break; // road | piso
   default: Prop.density = 0.1; Prop.friction = 0; Prop.restitution = 0.9; break; // default
  }
  
  BG.createFixture(Prop);
 }
 
 void Visible(){
  Vec2 V2 = Bisel.getBodyPixelCoord(BG);
  float Age = BG.getAngle();
  
  pushMatrix();
   translate(V2.x,V2.y); rotate(-Age);
   noStroke();
   switch(matt){
    //case 1: fill(20,20,20); ellipseMode(CENTER); ellipse(0,0,w,h); rectMode(CENTER); noFill(); stroke(0); rect(0,0,w,h); break;
    case 1: fill(240,240,240); rectMode(CENTER); rect(0,0,w,h,5); break;
    case 2: fill(240,240,240,70); ellipseMode(CENTER); ellipse(0,0,w,h); break;
    default: fill(0); fill(240,240,240); rectMode(CENTER); rect(0,0,w,h); break;
   }
  popMatrix();
 }
}