class Drop{
  PVector location; 
  PVector velocity; 
  PVector acceleration; 
  boolean isDead; 
  int dying; 
  int alpha; 
  boolean blocked; 
  
  Drop(PVector l, PVector v, int a, boolean blocked){
    this.location = l.copy(); 
    this.velocity = v.copy(); 
    this.acceleration = new PVector(0, 0); 
    this.isDead = false; 
    dying = 0; 
    alpha = a; 
    this.blocked = blocked; 
  }
  
  void run(){
    update(); 
    display(); 
  }
  
  void update(){
    location.add(velocity); 
    velocity.add(acceleration); 
  }
  
  void display(){
    if(dying<1){
      fill(#b5f3f7, alpha);
      noStroke();
      for (int i = 2; i < 8; i++ ) {
        ellipse(location.x, location.y + i*4, i*2, i*2);
      }
    } else{
      for (int i = 8; i > 2; i--) {
        ellipse(location.x, location.y - i*2, i*1.5, i*1.5);
      }
    }
  }
  
  boolean isBottom(){
    if(this.location.y>715){
      dying++; 
      return true; 
    } else{
    return false; 
    }
  }
}
