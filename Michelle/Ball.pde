//Ball class
class Ball{
  
  //Collision PVectors
  PVector paddle1;

  //Location and Velocity vectors.
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  //Size of the ball.
  float size = 90;
  
  //Color of the ball.
  color ballColor = color(255);
//color ballColor = color(random(20),random(200),random(255));

 
 boolean hit = false;
  
  //Constructor.
  Ball(){
    
    //Initialize the location and velocity vectors.
    location = new PVector(random(50,550),random(150,300));
    velocity = new PVector(random(-5,5), random(-5,5)); 
    acceleration = new PVector(0,0);
  }
  
  //Update the location and velocity of the ball.
  void update(){

    //Add the velocity vector to the location vector.
    location.add(velocity);
    
   velocity.add(acceleration);
  }
  
  //Check if the ball has collided with the walls.
  void collide(){
    
    //If the ball is touching the left or right wall, reverse the x velocity.
    if(location.x < size/2 || location.x > width - size/2){
      velocity.x *= -1;
    }
    
     //If the ball is touching the top or bottom wall, reverse the y velocity.
    if(location.y < 90 || location.y > height - size/2){
      velocity.y *= -1;
    }
    
   // Check for collision with paddle


   if (location.x >= paddle.x && 
    location.y >= paddle.y - 50 &&
    location.y <= paddle.y + 50) {

    velocity.y *= -1;
}
    
  }
  
  //Display the ball.
  void display(){
    
    //Set the fill color of the ball.
    fill(ballColor);
     strokeWeight(6);
    stroke(0);
    
    //Draw the ball.
    ellipse(location.x,location.y,size,size);
  
    
    if (hit) velocity.y *= -1;
  }
  
}
