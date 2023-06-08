
//Class for our pixel object
class square {
  
//Data
//The diameter of the pixel
  int size;
  
//The color value
  color rgb;
  
//Temp value so alpha can be changed
  color tempRgb;
  
//PVector for the object location -- Defines x,y coordinates
  PVector location;
  
//PVector for the object velocity -- Defines the vector(angle & magnitude) of change in location
  PVector velocity;
  
//PVector for the object acceleration -- Defines the vector(angle & magnitude) of change in velocity
  PVector acceleration;
  
//Variable for the velocity top speed
  float topSpeed;

//Constructor: Where all the Data is intialized-- Run once
  square(){
    
//Random pixel size
    size = int(random(20,90));
    
//Random size for the location vector
    location = new PVector(random(size,width-size),random(size,height-size));
//If location is past the left and right sides of the screen, reverse the motion
    if((location.x > (width-size)) || (location.x < size)){
      velocity.x = velocity.x * -1;
    }
   
//If  location is past the top and bottom sides of the screen, reverse the motion
    if((location.y > (height-size)) || (location.y < size)){
      velocity.y = velocity.y * -1;
    }
//Velocity is set to an intial value of 0,0-- no velocity
    velocity = new PVector(0,0);
    
//Acceleration updates velocity
//first random makes them go to the side, second random makes them go down
    acceleration = new PVector(random(0,0),random(0,0.05));
    
//Limit top speed of pixel
    topSpeed = 10;
    
//RGB is a random color
//I chose to do any color between red and pink
    rgb = color(int(random(214,245)),int(random(57,60)),int(random(0,255)));
    
//Save the value of rgb in a temp variable so we can reset it after alpha change
    tempRgb = rgb;
  }
  
//Methods
  
//Update the location of the object
  void update(){
    
//Add acceleration to velocity
    velocity.add(acceleration);
    
//Limit the top speed to 1
    velocity.limit(topSpeed);
    
//Add velocity to acceleration
    location.add(velocity);
  }
  
void moveAwayFromCursor(float cursorX, float cursorY){
  
  PVector mouse = new PVector(cursorX, cursorY);
//calculate the vector pointing away from the cursor
  PVector direction = PVector.sub(location, mouse);
//setting the magnitude (amount) of the acceleration based on distance from cursor
  float distance = direction.mag();
//if less than 100, push
  if(distance < 100){
    float magnitude = map(distance, 0, 100, 0.25, 0);
    direction.normalize();
    direction.mult(magnitude);
    acceleration = direction;
  } else{
    //acceleration.mult(0);
  }
}
//Check if pixels touch the walls
  void collide(){
    
//If the location is past the left and right sides of the screen, reverse the motion
    if((location.x > (width - size/2)) || (location.x < size/2)){
      velocity.x = velocity.x * -1; 
    }
    
//If the location is past the top and bottom sides of the screen, reverse the motion
    if((location.y > (height - size)) || (location.y < size/2)){
      velocity.y = velocity.y * -1; 
    }
    
  }
  
//Change the alpha of the color
  void highlight(){
    rgb = color(rgb,150);
  }

//Display the pixel
  void display(){
    strokeWeight(4);
    stroke(214,11,130,50);
    fill(rgb);
    rect(location.x,location.y,size,size);
    
//Reset the rgb color to it's intial value
    rgb = tempRgb;
  }
}
