class Ship {
  
  //Data--------------------------------------------------------
  PImage userShip;
  
  //Constructor-------------------------------------------------
  Ship() {
    userShip = loadImage("userShip.png");
  }
  
  //Methods-----------------------------------------------------
  void display() {
    image(userShip, myMouseX, myMouseY);
  }
  
  void fire() {
    
      if(frameCount % 20 == 0){
        println("fire");
        projectiles.add(new Projectile(myMouseX, myMouseY));
      }
    
  }
  
  void damage() {
    for (int j = enemies.size() - 1; j >= 0; j--) {
      Enemy enemy = enemies.get(j);
        
      float distance = dist(myMouseX, myMouseY, enemy.enemyLocation.x, enemy.enemyLocation.y);
        
      if (distance < userShip.height) {
          enemies.remove(j);
          
          health = health - 1;
                 
        }
      }
  }
}
