class Ship {
  
  //Data--------------------------------------------------------
  PImage userShip;
  
  //Constructor-------------------------------------------------
  Ship() {
    userShip = loadImage("userShip.png");
  }
  
  //Methods-----------------------------------------------------
  void display() {
    image(userShip, mouseX, mouseY);
  }
  
  void fire() {
    if(mousePressed) {
      if(frameCount % 20 == 0){
        projectiles.add(new Projectile(mouseX, mouseY));
      }
    }
  }
  
  void damage() {
    for (int j = enemies.size() - 1; j >= 0; j--) {
      Enemy enemy = enemies.get(j);
        
      float distance = dist(mouseX, mouseY, enemy.enemyLocation.x, enemy.enemyLocation.y);
        
      if (distance < userShip.height) {
          enemies.remove(j);
          
          health = health - 1;
                 
        }
      }
  }
}
