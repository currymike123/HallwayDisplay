class UmbrellaBack{
  
  PVector initLoc; 
  PVector velocity; 
  int state; 
  boolean up; 
  
  UmbrellaBack(PVector l){
    initLoc = l; 
    velocity = new PVector(0, 1); 
    state = 0; 
    up = false; 
  }
  
  void run(){
    update(); 
    drawUmbrella(); 
  }
  
  void update(){
      initLoc.x = mouseX; 
      initLoc.y = mouseY;   
  }
  
  void drawUmbrella(){
     fill(#b5f3f7);
     arc(initLoc.x, initLoc.y, 100, 80, PI, 2*PI);
     rect(initLoc.x-7, initLoc.y, 5, 35);
     noFill(); 
     stroke(#54dfe8);
     strokeWeight(5); 
     arc(initLoc.x-15, initLoc.y+31, 20, 20, 0, PI);
     noStroke(); 
     fill(#54dfe8);
     triangle(initLoc.x+4, initLoc.y-38, initLoc.x-6, initLoc.y-38, initLoc.x-1, initLoc.y-48);  
     noStroke(); 
     noFill(); 
  }  
}
