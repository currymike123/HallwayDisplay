class rainDrop {
  PVector position;
  PVector velocity;
  float radius;
  int colorIndex; 
  color[] colors = {#307AD8, #1F70D8, #024CAA};  
  //color[] colors = {#FF0303,#FF8E03,#FFF703,#66FF03,#0393FF,#8C03FF};  
  rainDrop() {
    position = new PVector(random(1920), random(-height));
    velocity = new PVector(0, 7);
    radius = 5;
    colorIndex = int(random(colors.length));  
  }
  void fall() {
    position.add(velocity);
    if (position.y > height) {
      position.x = random(1920);
      position.y = random(0);
      colorIndex = (colorIndex + 1) % colors.length;
    }
  }
  boolean hitCharacter = false;
// from here to end of if statement was supplied by online information 
  void checkCharacter() {
    float distToCircle = dist(position.x, position.y, myMouseX, height - character.height);
    if (distToCircle > characterRadius - 10 && distToCircle < characterRadius + 10) {
      float angle = atan2(position.y - (height - character.height), position.x - myMouseX);
      float newX = myMouseX + cos(angle) * (characterRadius + radius + 5);
      float newY = height - character.height + sin(angle) * (characterRadius + radius + 5);
      position.set(newX, newY);
      hitCharacter = true;
      } else {
        hitCharacter = false;
      }
    }
// this is the end of the if statement
  void display() {
    fill(colors[colorIndex]);
    ellipse(position.x, position.y, radius, radius * 3);
  }
}
