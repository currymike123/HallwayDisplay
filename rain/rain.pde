import java.util.Iterator;

import processing.net.*;

//Global Variables

//Variables for the server.
Client c;
String data;

ArrayList<Drop> dList; 
Umbrella u; 
Sun s; 
float fade; 
int startTime;
void setup(){
  size(1440, 740); 
  dList = new ArrayList<Drop>(); 
  s = new Sun(new PVector(width, height), new PVector(0, 0));
  u = new Umbrella(new PVector(width/2, height/2), s.theta); 
  startTime = millis();
  
  //Connect to the server for the mouse position.
  c = new Client(this, "localhost", 9999);
}

float myMouseY = width-100;

float myMouseX = height-100;

void draw(){
  
  if (c.available() > 0) {
    // read the data from the client
    data = c.readString();
    //Split the msg.
    String[] xy = split(data, ',');
    
    float x = float(xy[0]);
    float y  = float(xy[1]);
    
    
    //Set the mouse position to the data from the server.
    myMouseX = int(map(int(x),0,640,0,width));
    myMouseY = int(map(int(y),0,480,0,height));
    println(myMouseX);
  }
  
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
   
 checktime();
}

void mousePressed(){
  if(u.up == false && mouseX>(width-100)-50 && mouseX<(width-100)+50 && mouseY>(height-100)-50 && mouseY<(height-100)+50){
      u.state = 1; 
  } else if(u.up==true){
    u.state--; 
    u.up = false; 
  }
}

void checktime(){
   
  if(int(frameCount/frameRate) == 30){
   
    exit();
  }
  
}
