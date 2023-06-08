import java.util.Iterator;
ArrayList<Drop> dList; 
Umbrella u; 
Sun s; 
float fade; 
void setup(){
  size(1440, 740); 
  dList = new ArrayList<Drop>(); 
  s = new Sun(new PVector(width, height), new PVector(0, 0));
  u = new Umbrella(new PVector(width/2, height/2), s.theta); 
}

void draw(){
  background(#EDFFFF);  
  s.run(); 
  u.run(); 
  dList.add(new Drop(new PVector(random(-10, width), -40), new PVector(0, random(1, 2)), 50, false));
  dList.add(new Drop(new PVector(random(-10, width), -40), new PVector(0, random(3, 4)), 100, true));
  dList.add(new Drop(new PVector(random(-10, width), -40), new PVector(0, random(4, 5)), 200, true));
  dList.add(new Drop(new PVector(random(-10, width), -40), new PVector(0, random(6, 7)), 255, true));
  Iterator<Drop> it = dList.iterator();
   while(it.hasNext()){
      Drop d = it.next(); 
      d.run(); 
      if(d.isBottom()){
         d.velocity = new PVector(random(-2, 2), random(-2, -7));  
         d.acceleration = new PVector(.01, .1); `
         if(d.dying==2){
           it.remove(); 
         }
      }
       if(dist(d.location.x, d.location.y, u.initLoc.x, u.initLoc.y)<45 && d.blocked==true){
         d.dying++; 
         d.velocity = new PVector(random(-2, 2), random(-1, -2));  
         d.acceleration = new PVector(.01, .1); 
      }
   }
}

void mousePressed(){
  if(u.up == false && mouseX>(width-100)-50 && mouseX<(width-100)+50 && mouseY>(height-100)-50 && mouseY<(height-100)+50){
      u.state = 1; 
  } else if(u.up==true){
    u.state--; 
    u.up = false; 
  }
}
