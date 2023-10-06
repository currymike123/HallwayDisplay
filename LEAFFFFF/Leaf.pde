class Leaf {
  //initialize
  PImage leaf;
  PVector Loc; 
  int x = 10;
  int y = -1;
  boolean done; 
  
  Leaf(PVector _location) { //location
    Loc = _location; 
    leaf = loadImage("./data/leaf2.png"); //load image of leaf
    done = false; //if leaf is not done falling
  }
  
  void Update() { //update
    if(done == false){ // if leaf is not done falling
    y = y + 2; //leafs movement on the y axis
    x = int(cos(radians(y*5))*50);// leafs movement on the x axis
    }
    
    //if(millis() > 15000 && millis() < 22000){
    //  x = x + 2;
    //  y = int(cos(radians(x*5))*50);// leafs movement on the x axis
    //}
  } 
  
  void DisplayLeaf() {
    if(leafState == 1); //if mousepressed once
       image(leaf, Loc.x + x, Loc.y + y, 100, 75); //image of leaf appears at mouse x and y location
       println(Loc.y + y, Loc.x); //print location
  }
  
  void mousePressed() {
    if(leafState == 0){ //if mouse has not been pressed
    //only shows if mouse has been pressed at x or y location
      leafInitloc.x = myMouseX; 
      leafInitloc.y = myMouseY;
    }
  }
}
