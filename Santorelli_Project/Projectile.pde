class Projectile {
  
  //Data--------------------------------------------------------
  PImage shot;

  PVector projectileLocation;
  PVector projectileVelocity;

  //Constructor-------------------------------------------------
  Projectile(int x, int y) {
    shot = loadImage("shot.png");
    
    projectileLocation = new PVector(x, y);
    projectileVelocity = new PVector(7, 0);
  }
  //Methods-----------------------------------------------------
  void update() {
    projectileLocation.add(projectileVelocity);
  }
  
  void fireProjectile() { 
    if(projectileLocation.y > 50 && projectileLocation.x < width) {
      fill(255);
      noStroke();
      imageMode(CENTER);
      image(shot, projectileLocation.x, projectileLocation.y);
    }
  }
  
}
