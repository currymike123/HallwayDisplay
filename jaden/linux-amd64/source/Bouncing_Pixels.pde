
import processing.net.*;

//Global Variables

//Variables for the server.
Client c;
String data;


//Array of pixel objects
square[] arrsquare;
 
//Number variable.
int num = 40;


void setup(){
  size(800,700,P2D);
  background(40);
  smooth();
  rectMode(CENTER);
  
//Set the size of the array.
  arrsquare = new square[num];
  
//Use a loop to create instances of square object
  for(int i = 0; i < arrsquare.length; i++){
    arrsquare[i] = new square();
  }
  
  //Connect to the server for the mouse position.
  c = new Client(this, "localhost", 9999);
}

float myMouseY = -100;

float myMouseX = -100;

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
  }
    
//Array of pixels -- Update, Collide, Display
  for(int i = 0; i < arrsquare.length; i++){
    
    arrsquare[i].moveAwayFromCursor(myMouseX, myMouseY);
    
//Update pixel location
    arrsquare[i].update();
    
//Check if they have collided with the walls
    arrsquare[i].collide();
    
    
     float distance = dist(arrsquare[i].location.x, arrsquare[i].location.y, myMouseX, myMouseY); 
      if(distance < arrsquare[i].size){
        arrsquare[i].rgb = color(255,255,255,30);
      }
  
    
//Check if the current pixel is touching all the other pixels
    for(int n = 0; n < arrsquare.length; n++){
//Calculate the distance between pixels
        distance = dist(arrsquare[i].location.x, arrsquare[i].location.y, arrsquare[n].location.x,arrsquare[n].location.y); 
        
//If distance from one pixel to every other pixel is < the the pixel's radius, they are touching
        if(i != n && (distance < arrsquare[i].size/2 + arrsquare[n].size/2)){
          
//Change the alpha of the pixels
           arrsquare[i].highlight();
           arrsquare[n].highlight();
        }
     }
     arrsquare[i].display();
   }
   checktime();
   fill(255,5);
   noStroke();
   println(myMouseX);
   ellipse(myMouseX,myMouseY,50,50);
}


void checktime(){
   
  if(millis() > 30000){
   
    exit();
  }
  
}
