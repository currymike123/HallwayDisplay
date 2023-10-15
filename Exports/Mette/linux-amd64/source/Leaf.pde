class Leaf {
  //initialize
  PImage leaf;
  PVector Loc; 
  int x = 10;
  int y = -1;
  boolean done; 
  
  Leaf(PVector _location, PImage _leaf) { //location
    Loc = _location; 
    leaf = _leaf; //load image of leaf
    done = false; //if leaf is not done falling
  }
  
  void Update() { //update
    if(done == false){ // if leaf is not done falling
    y = y + 2; //leafs movement on the y axis
    x = int(cos(radians(y*5))*50);// leafs movement on the x axis
    }
    
   
  } 
  
  void DisplayLeaf() {
    
       image(leaf, Loc.x + x, Loc.y + y, 100, 75); //image of leaf appears at mouse x and y location
     
  }
  

}
