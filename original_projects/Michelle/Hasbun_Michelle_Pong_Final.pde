
Ball[] arrBall;
Paddle paddle;

//Number variable.
int num = 3;
int lives = 3;
int score = 0;
boolean lost=false;
boolean win=false;

void setup() {
  size(600, 800);
  paddle = new Paddle(0,0);

  //Set the size of the array.
  arrBall = new Ball[num];
  
  //Use a loop to create instances of Ball object
  for(int i = 0; i < arrBall.length; i++){
    arrBall[i] = new Ball();
  }
}

void draw() {
  background(0);
 pushMatrix();
int radius = 25; // Radius of each circle
  int spacing = radius * 2; // Spacing between circles
  
  color[] customColors = {
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
  for (int y = 0; y < height; y += spacing) {
    // Get the current color
    int colorIndex = (rowMod + y/spacing) % customColors.length;
    color c = customColors[colorIndex];
    
    // Draw circles with the current color
    for (int x = 0; x < width; x += spacing) {
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
