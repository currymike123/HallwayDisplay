/* autogenerated by Processing revision 1293 on 2023-08-21 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import processing.net.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class Michelle extends PApplet {




//Global Variables

//Variables for the server.
Client c;
String data;



Ball[] arrBall;
Paddle paddle;

//Number variable.
int num = 3;
int lives = 3;
int score = 0;
boolean lost=false;
boolean win=false;

public void setup() {
  surface.setSize(600, 800);
  surface.setLocation((displayWidth-width)/2, (displayHeight - height) / 2);
  paddle = new Paddle(0,0);

  //Set the size of the array.
  arrBall = new Ball[num];
  
  //Use a loop to create instances of Ball object
  for(int i = 0; i < arrBall.length; i++){
    arrBall[i] = new Ball();
  }
  
   //Connect to the server for the mouse position.
  c = new Client(this, "localhost", 9999);
}

float myMouseY = -100;

float myMouseX = -100;

public void draw() {
    checktime();
   if (c.available() > 0) {
    // read the data from the client
    data = c.readString();
    //Split the msg.
    String[] xy = split(data, ',');
    
    float x = PApplet.parseFloat(xy[0]);
    float y  = PApplet.parseFloat(xy[1]);
    
    
    //Set the mouse position to the data from the server.
    myMouseX = PApplet.parseInt(map(PApplet.parseInt(x),0,640,0,width));
    myMouseY = PApplet.parseInt(map(PApplet.parseInt(y),0,480,0,height));
  }
 
  
  background(0);
 pushMatrix();
int radius = 25; // Radius of each circle
  int spacing = radius * 2; // Spacing between circles
  
  int[] customColors = {
    color(230,13,255), //pink magenta
    color(174,15,255), // magenta purple
    color(109,25,222), // deep purple
    color(72,5,232), // purple blue
    color(20,40,247), // deep blue
    color(20,105,247), // medium blue
    color(31,208,255), // light blue
    color(31,255,189), // blue green
    color(53,237,81), // green
    color(141,237,53) // yellow green
  };
 
  // Calculate the current frame modulo the number of frames per color
  int delayFrames = 6;
  int frameMod = frameCount % (customColors.length * delayFrames);
  
  // Calculate the current row modulo the number of colors
  int rowMod = floor((frameMod / delayFrames));
  
  // Loop through the rows and columns
  for (int y = 0; y < 800; y += spacing) {
    // Get the current color
    int colorIndex = (rowMod + y/spacing) % customColors.length;
    int c = customColors[colorIndex];
    
    // Draw circles with the current color
    for (int x = 0; x < 600; x += spacing) {
      fill(c);
      ellipse(x + radius, y + radius, radius * 2, radius * 2);
    }
  }
     popMatrix();

  strokeWeight(6);
  stroke(0);
  smooth();
 
for (int i = 0; i < arrBall.length; i++) {
    // Update the location of the balls.
    arrBall[i].update();
    // Check if they have collided with the walls.
    arrBall[i].collide();
    // Check if the current ball is touching all the other balls.
    for (int n = 0; n < arrBall.length; n++) {
        // Calculate the distance between the balls
        float distance = dist(arrBall[i].location.x, arrBall[i].location.y, arrBall[n].location.x, arrBall[n].location.y);

        // If the distance from the ball to every other ball is less than the sum of their radii, they are overlapping.
        if (i != n && (distance < arrBall[i].size / 2 + arrBall[n].size / 2)) {

            // Calculate the direction away from the other ball
            PVector awayFromOtherBall = PVector.sub(arrBall[i].location, arrBall[n].location);
            awayFromOtherBall.normalize();

            // Move the balls away from each other
            arrBall[i].location.add(awayFromOtherBall);
            arrBall[n].location.sub(awayFromOtherBall);
        }
    }

    arrBall[i].display();
    paddle.display();
}
   
  // put in score and miss text
   strokeWeight(100);
  fill(150);
  line(0,0,600,0);
  strokeWeight(6);
  textSize(35);
  fill(255);
  text("Score:"+score,100,40);
  text("Lives:"+lives,400,40);
 
  
  
  // Win + Loss Requirements
   for(int i = 0; i < arrBall.length; i++){
  if (arrBall[i].location.y <= 90)
  {
    score=score+10;
    lives=lives+1;
  }
  if(arrBall[i].location.y >= 755)
  {
    lives=lives-1;
    score=score-5;
  }
   }
  if (lost==true)
  {
    lives=5;
    score=0;
    lost=false;
    loop();
  }
  
  if (lives==0)
  {
    lost=true;
    noLoop();
    textSize(35);
    fill(255,0,0);
    text("Click to Restart", 180,100);
  }
  if (score==500)
  {
    win=true;
    noLoop();
    textSize(35);
    fill(0,255,0);
    text("Congratulations, You Won!!!", 100,100);
  }
  

}

public void checktime(){
   
  if(millis() > 30000){
   
    exit();
  }
  
}
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
  int ballColor = color(255);
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
  public void update(){

    //Add the velocity vector to the location vector.
    location.add(velocity);
    
   velocity.add(acceleration);
  }
  
  //Check if the ball has collided with the walls.
  public void collide(){
    
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
  public void display(){
    
    //Set the fill color of the ball.
    fill(ballColor);
     strokeWeight(6);
    stroke(0);
    
    //Draw the ball.
    ellipse(location.x,location.y,size,size);
  
    
    if (hit) velocity.y *= -1;
  }
  
}
class Paddle{
  float x; // width of the paddle
  float y; // height of the paddle
  float rectWidth;
  float rectHeight;
  
  Paddle(float x1, float y1) {
    x = x1;
    y = y1;
  }
  
  //Display Paddle.
  public void display(){
    
  // draw Paddle
  x = myMouseX;
  y = 700;
  fill(255);
  rect(x,y, 200, 50);
  }
  
}


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "Michelle" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}