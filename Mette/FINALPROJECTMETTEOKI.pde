//Due 15th

//initialize
PImage tree; 
PImage cloud;
PImage leaf;
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

void setup() {
  size(1000,900); //screen size
  tree = loadImage("./data/tree2.png"); //load image of tree 
  cloud = loadImage("./data/cloud.png"); //load image of cloud
  leafInitloc = new PVector(0,0); //initial P Vector (leaf)
  leafState = 0; //if mouse has been pressed (leaf)
  leafCount = 0; // leaf count
  leaves = new Leaf[100]; //array of leaf object
  frameRate(45); //framerate (leaf)
  leafEnd = 0; //end of movement (leaf)
}

void draw() {
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
  if(frameCount - leafCurrentframe > 20){ 
    if(mousePressed){
     if(mouseX > 246 && mouseX < 718 && mouseY > 79 && mouseY < 407) { //bounds of tree where mouse pressed mmakes leaves appear
      PVector tempLoc = new PVector(mouseX,mouseY); 
      leaves[leafCount] = new Leaf(tempLoc);
      leafCount++;
      leafCurrentframe = frameCount;
    }
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
}

float SelectRandom() { //random end position
  return random(760,900);
}

 




  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
