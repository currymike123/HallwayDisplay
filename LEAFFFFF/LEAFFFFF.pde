//Due 15th
import processing.net.*;

//Global Variables

//Variables for the server.
Client c;
String data;

//initialize
PImage tree; 
PImage cloud;
PImage mLeaf;
PVector leafInitloc; 
int leafState;
int leafCurrentframe = 0;
int leafCount;
int lY = -1;
int lX = 10;
float leafEnd;
int xPos = -300;
int xDir = 2;

Leaf[] leaves; //leaf array

PShape hand;

void setup() {
  size(1000,900); //screen size
  //int setX = int((displayWidth - width) / 2);
  //int setY = int((displayHeight - height) / 2);
  //surface.setSize(1000, 900);
  //surface.setLocation(int((displayWidth - width) / 2), int((displayHeight - height) / 2));
  
  translate(int(displayWidth - width) / 2, int(displayHeight - height) / 2);
  
  tree = loadImage("./data/tree2.png"); //load image of tree 
  cloud = loadImage("./data/cloud.png"); //load image of cloud
  mLeaf = loadImage("./data/leaf2.png");
  leafInitloc = new PVector(0,0); //initial P Vector (leaf)
  leafState = 0; //if mouse has been pressed (leaf)
  leafCount = 0; // leaf count
  leaves = new Leaf[100]; //array of leaf object
  frameRate(45);
  leafEnd = 0; //end of movement (leaf)
  
  hand = loadShape("data/Hand.svg");
  
   //Connect to the server for the mouse position.
  c = new Client(this, "localhost", 9999);
}

float myMouseY = -100;

float myMouseX = -100;

void draw() {
   if(millis() >= 30000){
      print("Done");
      exit();
   }
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
  }
    
   background(#D9F5FC); //background sky
   fill(#F2F284);
   noStroke();
   ellipse(100,100,280,280);
   
    
   image(cloud, xPos, -130, 400, 400); //cloud start position and size
    xPos = xPos + 3; //movement of cloud
     if (xPos > width) { //cloud bounds
     xPos = -300; //restart poition
  }
  
  image(tree,0,0); //draw background image
  
  println(mouseX+","+mouseY); //print mouse location
  
 // if pressed within x and y coordinate bounds, smooths out how many leaves appear with each click:
  if(frameCount - leafCurrentframe > 40){ 
   
     if(myMouseX > 246 && myMouseX < 718 && myMouseY > 79 && myMouseY < 407) { //bounds of tree where mouse pressed mmakes leaves appear
     
      PVector tempLoc = new PVector(myMouseX,myMouseY); 
      leaves[leafCount] = new Leaf(tempLoc,mLeaf);
      leafCount++;
      leafCurrentframe = frameCount;
     
    }
  
}
  
  if(leafCount > 0){ //if leaf count is greater than zero (mouse has been pressed)
    for(int i = 0; i < leafCount; i++){
     leafEnd = SelectRandom(); //random end position 
      if(leaves[i].Loc.y + leaves[i].y < leafEnd) {
       leaves[i].Update(); //update
      } else {
        leaves[i].done = true; //done falling
      }
        leaves[i].DisplayLeaf(); //leaf display
    }
  }
  
  shape(hand,myMouseX,myMouseY,hand.width/6,hand.height/6); 
  
}

float SelectRandom() { //random end position
  return random(760,900);
}

void checktime(){
   
  if(millis() > 30000){
   print("Done");
    exit();
  }
}
 




  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
