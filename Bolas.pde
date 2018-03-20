class Cyrcles{
 float x,y,r; Body BG;
 Cyrcles(float x_,float y_,float r_){
  x = x_;
  y = y_;
  r = r_;
  
  
  Vec2 V1 = Bisel.coordPixelsToWorld(new Vec2(x,y));
  
  BodyDef Cog = new BodyDef();
  Cog.type = BodyType.DYNAMIC;
  Cog.position.set(V1);
  
  BG = Bisel.createBody(Cog);
  
  CircleShape POL = new CircleShape();
  POL.m_radius = Bisel.scalarPixelsToWorld(r);
  
  FixtureDef Prop = new FixtureDef();
  Prop.shape = POL;
  Prop.density = 0.8; Prop.friction = 0.8; Prop.restitution = 0.6;
  
  BG.createFixture(Prop);
 }
 
 void Visible(){
  Vec2 V2 = Bisel.getBodyPixelCoord(BG);
  float Age = BG.getAngle();
  
  pushMatrix();
   translate(V2.x,V2.y); rotate(-Age);
   noStroke();
   fill(20,20,20); ellipseMode(CENTER); ellipse(0,0,r*2,r*2);
   strokeWeight(2); stroke(190); line(-r,0,r,0); line(0,r,0,-r);
   ellipse(0,0,r,r);
  popMatrix();
  if ((V2.x < -300 || V2.x > width+300) || (V2.y < -300 || V2.y > height+300)){loading = 1;}
  xme = V2.x;
  yme = V2.y;
 }
}