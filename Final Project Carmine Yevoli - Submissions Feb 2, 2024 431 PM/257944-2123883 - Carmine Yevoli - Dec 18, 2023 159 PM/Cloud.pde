class clouds {
  float x;
  float y;
  float width;
  float height;
  float speed;
  PImage image;
  clouds(float width, float height, float speed, PImage image) {
    this.x = random(-width, width); // Random x-coordinate within the canvas width
    this.y = 10; // Fixed y-coordinate of -10
    this.width = width;
    this.height = height;
    this.speed = random(1, 3);
    this.image = image;
  }
  void update() {
    // Update the x-coordinate based on the speed
    x = x + speed;
    if (x > width * 2) {
      x = -width; // Moves the cloud at the right, back to left
    }
  }
  void display() {
    image(image, x, y, width, height);
  }
}
