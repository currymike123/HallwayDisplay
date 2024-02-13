//CONTROLS::--------------------------------------------------------------
//
// W, A, S, D to move the player up, left, down, and right
//
//Move the mouse to control the "enemy" target
//
//Hold to mouse to fire projectiles at the enemy target
//
//Press "R" to reset the projectiles and make them return to the player
//
//
//------------------------------------------------------------------------


import processing.net.*;

//Global Variables

//Variables for the server.
Client c;
String data;
float myMouseY = -100;
float myMouseX = -100;

Ball[] balls;

Player player;

PVector mouseLoc; //PVector that will contain mouse location

int tempFrame;  //Integer to store a temporary frame value that can be referenced

//Number variable for the amount of projectiles balls
int num = 100;

//Int for how many projectiles are currently targeting an enemy
int amountFired;

//color from = color(185,185,245,100);
//color to = color(118,119,255,100);
//color to = color(99,255,49,100);


//float lastX = 0;
//float lastY = 0;

void setup()
{
   //Connect to the server for the mouse position.
   c = new Client(this, "localhost", 9999);
   fullScreen();
   frameRate(60);
   noCursor();
   smooth();
   background(0);
   player = new Player();

   mouseLoc = new PVector(0,0);

   

//Set the size of the array of projectiles
balls = new Ball[num];
for(int i = 0;i<balls.length;i++)
{
  balls[i] = new Ball();
}

}

void draw()
{
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
  //background(0);
  mouseLoc.set(myMouseX,myMouseY);
  fill(0,100);
  rect(0,0,width,height);
  
  player.speed();
  player.bounce();
  
  if(keyPressed)
    {
      PVector force = new PVector(0,0);
      
     //All of these if statements are to establish all of the keyboard inputs and result in a change to the "Force" that will be applied to the player
     if(key == 'w' && key=='a')
     {
       force.x = -1;
       force.y = -1;
     }
     else if(key == 'W' && key=='a')
     {
       force.x = -1;
       force.y = -1;
     }
     else if(key == 'w' && key=='A')
     {
       force.x = -1;
       force.y = -1;
     }
     else if(key == 'W' && key=='A')
     {
       force.x = -1;
       force.y = -1;
    }
     else if(key == 'w' || key == 'W')
     {
       force.x = 0;
       force.y = -1;
     }else if(key =='d' || key == 'D')
     {
       force.x = 1;
       force.y = 0;
     }else if(key =='s' || key == 'S')
     {
       force.x = 0;
       force.y = 1;
     }else if(key =='a' || key == 'A')
     {
       force.x = -1;
       force.y = 0;
     }else if(key =='r' || key == 'R')
     {
       amountFired = 0;                    //Using the "R" key will cause the projectiles to return to the player or "Reset"
     }
     else
     {
       force.x=0;
       force.y=0;
       
     }
     player.applyForce(force);          //Applies the force to the player object
    }
    
   

      player.dampen();         //This simply decreases the velocity by a small amount each frame to make the player come to a gradual stop
      
      
    

  
  for(int i = 0;i<balls.length;i++)
  {
    boolean thisTarget = false;      //The default state for the projectiles is to be tethered to the player, if thisTarget is true then the projectile will target the "enemy"
    
    if(i>amountFired-1)              //This compares the current index in the array of projectiles, and compares it to the amount of projectiles that should be "Fired"
    {                                                                          
    balls[i].speed(player.location, mouseLoc, thisTarget, tempFrame);        //If i is greater than the amount fired, perform normal speed operation with "thisTarget" false, meaning follow the player
    }
    else
    {                                                      //If i is less than the amountFired, then it will target the "enemy", thisTarget being set to false and used in the speed method
     thisTarget = true;
     balls[i].speed(player.location, mouseLoc, thisTarget, tempFrame);
     stroke(255);
    }
    
    //Check if we have hit the walls
    balls[i].bounce();
    
    //for(int n = 0;n< balls.length;n++)
    //{
    //  //Calculate the distance between the objects
    //  //PVector distance formular for calculating distance between 2 objects
    //  float distance = dist(balls[i].location.x, balls[i].location.y,balls[n].location.x,balls[n].location.y);
    //  //If the distance from one object to every other object is less than the ball's radius, then they are overlapping 
    //  if(i != n && (distance < balls[i].size/2 + balls[n].size/2))
    //  {
    //    stroke(255);
    //     line(balls[i].location.x,balls[i].location.y,balls[n].location.x,balls[n].location.y);
        
    //  }
      
      
    //}
    
    //Display the ball
    balls[i].display(thisTarget); //Takes "thisTarget" boolean to determine what the projectile is focusing on, and how it should be displayed (color)
    
    
   
   

    if(i>1)
    {
       
      if(thisTarget==false)
      {
      //stroke(lerpColor(to,from,map(timeColor,0,500,0,1)));
      //line(balls[i].location.x,balls[i].location.y,balls[i-1].location.x,balls[i-1].location.y);
      
      stroke(46,159,255,50);                                                                                //Sets the color of the line between the player and projectiles
      line(balls[i].location.x,balls[i].location.y,player.location.x,player.location.y);              //Draw a line between current projectile position and the player
      
      }
      //else
      //{
      // stroke(10,160,8,random(100,120));
      // line(balls[i].location.x,balls[i].location.y,balls[i-1].location.x,balls[i-1].location.y);
      // stroke(255,0,0,random(0,120));
      // line(balls[i].location.x,balls[i].location.y,mouseX,mouseY);
      //}
      //lastX = balls[i].location.x;
      //lastY = balls[i].location.y;
       
    }
  }
  noStroke();
  fill(0);
  ellipse(myMouseX,myMouseY, 15, 15);
  fill(255,0,0);                                    //These ellipses are for drawing the mouse cursor
  ellipse(myMouseX,myMouseY, 10, 10);
  player.display();                              //Displays the player (duh)
  
  if(mousePressed)                              //If the mouse is being held, the amount of projectiles fired goes up
  {
     amountFired++; 
     tempFrame=frameCount;
  }
  
}
  
  //void mouseClicked()
  //{
  //   tempFrame=frameCount;
  //}
