//Ball Class

class Ball
{
  
  //Data
  
  //The diameter
 int size;
 
 //PVector for the location of the object
 PVector location;
 
 //PVector for the  velocity of the object. Defines the vector (angle and magnitude) of change in location
 PVector velocity;
 
 //PVector for the acceleration of the object . Defines the vector (angle and magnitude) of the change in velocity
 PVector acceleration;
 
 //Color value of the ball.
 color c;
 
 //Temp value to change the alpha
 color tempC;
 
 //Variable for the velocity top speed
 float topSpeed;  
 
 //Image variable
 
 float xMouse=width/2;
 float yMouse=height/2;
 
 color projectile = color(240, 208, 46, 240); //Color the projectile should be when targeting enemy

 color dormant = color(8,75,255,175);    //Color of projectile when following the player
 
 
 //Constructor (Class's setup function)
 Ball()
 {
  size = int(random(5,10));
  location = new PVector(random(size ,width-size),random(size ,height-size));

  velocity = new PVector(0,0);
  
  acceleration = new PVector(random(-.01,.01),random(-.01,.01));
  
  topSpeed = 12;
  
  c = color(int(random(50,255)), int(random(50,255)), int(random(50,255)));
  
  tempC = c;
  
  
  
 }
  
  //Methods
  
  //Speed method built from the example given in class, with some changes
  void speed(PVector input, PVector enemy, boolean target, int time)         //This method now needs a PVector for the player, enemy, the boolean for if the focus is on player or enemy, and an int to take the frame count
  {
    PVector focus = input;                //Creates another PVector for the focus, which is a variable that can change depending on the intended "focus" to be targeted. Default value being the PVector of the player location
             
    
    int timePassed = frameCount - time;   //Sets timePassed to the tempFrame variable in the main class, this is all being used to determine how many frames have passed since the mouse was pressed
    
    if(target==true)  //If target boolean is true, this will make the projectile focus on the enemy
    {
      focus=enemy;
      PVector dir = PVector.sub(focus,location);   //Pvector for direction of the acceleration to apply to the projectile, and set it to be influenced by the enemy location
      dir.normalize();            //Taken from reference in class example
      dir.mult(map(timePassed,0,60,1,2));      //Mapping the time passed since the mouse has been pressed, and maps it to a smaller range to affect the magnitude of the acceleration
      //dir.mult(1);
        topSpeed=12;
        if(timePassed<60)      
        {
         topSpeed=12;              //if the mouse isn't being pressed, this is the influence the focuses location should be have (Half the magnitude of the acceleration)
          dir.mult(.5);
        }
        acceleration = dir;      //Sets the acceleration of the projectile to the value of dir
      
    }
    else
    {   PVector dir = PVector.sub(focus,location);     //If target is false then that means to target the player, following the same logic as above
        dir.normalize();
        dir.mult(.3);
        acceleration = dir;
    }
    
    acceleration.add(random(0,0.1),random(0,0.01));    //Adds a bit of random acceleration in the mix to prevent particles from overlapping and seeming to disappear
    
    velocity.add(acceleration);
    velocity.limit(topSpeed);          //Applies all the movement to the projetile   
    location.add(velocity);
   
  }
  
  void bounce()    //Taken from in class reference to allow the projectiles to collide with the border of the screen
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


void display(boolean target)    //Displays the projectile
{
  noStroke();
  if(target == true)        //When targting the enemy, use the "projectile" color
  {
    fill(projectile);
  }
  else
  {
    fill(dormant);    //When following player, use the dormant color
  }  
  ellipse(location.x,location.y,size,size);
  fill(255,150);                                        //Draws the projectile 
  ellipse(location.x,location.y,size-2,size-2);
  
  
  //Reset the color
  c = tempC;
  
}
}
