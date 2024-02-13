

//All notes will be pretty similar to Ball Class, reference both


class Player
{
  //The diameter
 int size;
 
 //PVector for the location of the object
 PVector location;
 
 //PVector for the  velocity of the object. Defines the vector (angle and magnitude) of change in location
 PVector velocity;
 
 //PVector for the acceleration of the object . Defines the vector (angle and magnitude) of the change in velocity
 PVector acceleration;
 
 //Color value of the ball.
 color to;
 
 color from;
 
 //Temp value to change the alpha
 color tempC;
 
 //Variable for the velocity top speed
 float topSpeed;
 
 //Variable for mass
 float mass;
 
 
 //Constructor (Class's setup function)
 Player()
 {
  size = 50;
  location = new PVector(width/2, height/2);

  velocity = new PVector(0,0);
  
  acceleration = new PVector(0,0);
  
  topSpeed = 6;
  

 
  
  mass = 5;
  
 }
  
  //Methods
  void speed()
  {
    velocity.add(acceleration);
    velocity.limit(topSpeed);
    location.add(velocity);
    acceleration.mult(0);
   
  }
  
  void applyForce(PVector force)
  {
   PVector f = force.get();
   f.div(mass);
   acceleration.add(f); 
  }
  
  void bounce()
  {
   if((location.x>width-size/2) || (location.x <size/2))
   {
     velocity.x = velocity.x * -1;
   }
   
   if((location.y>height-size/2) || (location.y<size/2))
   {
     velocity.y = velocity.y * -1;
     
  }
  }
  
  void dampen(){
   velocity.mult(.97);
  }

 

void display()
{
  noStroke();
  fill(255);
  ellipse(location.x,location.y,size+5,size+5);
  fill(0);
  ellipse(location.x,location.y,size,size);

  
}
}
