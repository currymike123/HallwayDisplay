class Drop{
  float r; //radius of drop 
  Body body; 
  color c; 
  float dying; 
  float alpha; 
  
  Drop(){
    r = 20; 
    dying = 0; 
    alpha = 0; 
    BodyDef bd = new BodyDef(); 
    bd.type = BodyType.DYNAMIC; 
    float posxrand = calcPosx(); 
    bd.position.set(box2d.coordPixelsToWorld(posxrand, -40)); 
    body = box2d.createBody(bd); 
    
    CircleShape cs = new CircleShape(); 
    cs.m_radius = box2d.scalarPixelsToWorld(r); 
    
    body.createFixture(cs, 1.0); 
    
    body.setUserData(this); 
    c = #b5f3f7; 
  }
  
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body); 
    float a = body.getAngle(); 
    pushMatrix(); 
    translate(pos.x, pos.y);
    rotate(-a); 
    fill(175); 
    stroke(0); 
    rectMode(CENTER); 
    fill(c); 
    noStroke(); 
    if(dying<1){
          fill(#b5f3f7);
          noStroke();
          for (int i = 2; i < 8; i++ ) {
            ellipse(0, 0 + i*4, i*2, i*2);
          }
        } else{
          fill(#b5f3f7, 200);
          for (int i = 8; i > 2; i--) {
            ellipse(0, 0 - i*2, i*1.5, i*1.5);
          }
        }
    popMatrix(); 
    
  }
  
  //void killBody(){
  //  box2d.destroyBody(body); 
  //}
  
  float calcPosx(){
    return random(-10, width+10); 
  }
}
