//find a way to keep location changes static so that objects remain in the same place from their creation

//click and drag to move sqaures in columns

//create a style and look at other projects you are interested in, sketch
//out what you want the final project to look like. Simple concept and play off of it.

import processing.net.*;

//Global Variables

//Variables for the server.
Client c;
String data;

//Number variable
int num=50;
PVector pos;
Strand[] strands;

void setup() {
  size(900, 900);
  frameRate(60);
  //smooth();
  background(0);
  
  //Changed the number of strands to 36 so it fits within your frame.
  strands=new Strand[64];
  
  //Offset the y location by -125 so it centers in the frame.
  pos=new PVector(-75, -175);

  //Create your stands with an increasing loop.
  for (int i=0; i<strands.length; i++) {
   
    //Check add to the y location at every 6th strand.  Make sure to skip the first strand.
    if (i % 8 == 0 && i != 0) {
      pos.x = -75;
      pos.add(0, 125);
    }
    //Add the strand.
    strands[i] = new Strand(pos.copy());
    
    //Increase the x location by 125.
    pos.add(125, 0);
  }
  
  //Connect to the server for the mouse position.
  c = new Client(this, "localhost", 9999);
}

float myMouseY = -100;

float myMouseX = -100;

void draw() {
  
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
  background(0);
  
  //Draw the strands to the screen with a decreasing for loop.  This way the layering is correct.
  //Start from the length of the array - 1.  Draw the strands until you reach index 0.
  for (int i=strands.length-1; i>=0; i--) {
    strands[i].display();
  }
  
}
