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
  void display(){
    
  // draw Paddle
  x = mouseX;
  y = 700;
  fill(255);
  rect(x,y, 200, 50);
  }
  
}
