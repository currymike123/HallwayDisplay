class Star {
  
  //Data---------------------------------------------------------
  PVector starLocation;
  PVector starVelocity;
  float size;
  int maxSize = 5;
  float Color;
  
  //Constructor--------------------------------------------------
  Star() {
    size = random(maxSize);
    starLocation = new PVector(random(width), random(height));
    starVelocity = new PVector(-2, 0);
    Color = (255 / maxSize) * size;
  }
  
  
  
  //Methods------------------------------------------------------
  void display() {
    noStroke();
    fill(Color);
    ellipse(starLocation.x, starLocation.y, size, size);
  }
  
  void update() {
    starLocation.add(starVelocity);
    
    if (starLocation.x <= 0) {
      starLocation.x = width;
    }
  }
}
