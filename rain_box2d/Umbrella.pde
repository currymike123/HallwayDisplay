class Umbrella {
  
  float x, y; 
  Body body;
  BodyDef bd; 
  float[] randColor; 
  
  Umbrella(float[] randColor){
    this.randColor = randColor; 
    bd = new BodyDef(); //build body 
    bd.type = BodyType.DYNAMIC; 
    bd.position.set(box2d.coordPixelsToWorld(mouseX, mouseY));
    body = box2d.createBody(bd);
    
    PolygonShape ps = new PolygonShape(); // build shape 
    float box2dW =  box2d.scalarPixelsToWorld(80/2); //5/2
    float box2dH = box2d.scalarPixelsToWorld(80/2);
    ps.setAsBox(box2dW, box2dH);    
    
    body.setLinearVelocity(new Vec2(0, (random(-10, -1)))); 
    body.setAngularVelocity(random(-1.5, 1.5)); 
    
   CircleShape cs = new CircleShape(); 
    cs.m_radius = box2d.scalarPixelsToWorld(40); 
    
    //body.createFixture(cs, 1);    
   FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = .8;
    
    body.createFixture(fd);
  }
  
  void display(){
   colorMode(HSB); 
   Vec2 pos = box2d.getBodyPixelCoord(body); 
   float a = body.getAngle();  
    pushMatrix(); 
    translate(pos.x, pos.y);
    rotate(-a); 
    
     fill(randColor[0], randColor[1], randColor[2]);
     arc(0, 0, 100, 80, PI, 2*PI);
     rect(-5, 0, 5, 35);
     noFill(); 
    // stroke(#54dfe8);
    stroke(randColor[0], randColor[1], 200);
     strokeWeight(5); 
     arc(-13, 33, 20, 20, 0, PI);
     noStroke(); 
     fill(randColor[0], randColor[1], 200);
     triangle(4, -38, -6, -38, -1, -48);  
     noStroke(); 
     noFill(); 
   popMatrix();     
     noStroke(); 
     noFill(); 
  } 
}
