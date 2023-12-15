class SquareRot {
  //Data
  int size;
  color rgb;
  color tempRgb;
  PVector location;
  float angle=0; //location
  float aVelocity; //velocity
  float aAcceleration; //acceleration
  float factor;

  //Constructor
  SquareRot(PVector _location, color c, float x) {
    location=_location;
    size=(int)x;
    aVelocity=0;
    aAcceleration=0.001;
    rgb=color(c);
    factor = 0;
  }
  //Methods
  void display() {
    pushMatrix();
    rectMode(CENTER);
    translate(location.x, location.y);
    rotate(angle);
    fill(rgb);
    square(0, 0, size);
    noStroke();
    popMatrix();
    factor = (myMouseX/width) / 20;
    angle+=factor;
    angle+=aVelocity;
    //println(aVelocity);
  }
}
