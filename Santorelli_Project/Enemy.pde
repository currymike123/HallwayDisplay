class Enemy {
  
  //Data--------------------------------------------------------
  PImage enemyShip;

  PVector enemyLocation;
  PVector enemyVelocity;
  
  //PImage[] explosions = new PImage[6];
  //int count = 1;
  //int displayTime = 1000;
  //int lastTime;
  
  //Constructor-------------------------------------------------
  Enemy() {
    enemyShip = loadImage("enemyShip.png");
    
    //for (int i = 1; i < explosions.length; i++) {
    //  explosions[i] = loadImage("Explosion" + nf(i,1) + ".png");
    //}
    //This loads a series of explosion sprites into an array to be displayed when the enemy ship is shot
    
    enemyLocation = new PVector(width + 100, random(0 + 50 + enemyShip.height, height - enemyShip.height));
    
    if (score < 100) {
      enemyVelocity = new PVector(-5, random(-3, 3));
    }
    if (score >= 100) {
      enemyVelocity = new PVector(random(-10, -5), random(-3, 3));
    }
  }
  
  //Methods-----------------------------------------------------
  void display() {
    
    //Check if the enemy is off screen and delete it
    for (int j = enemies.size() - 1; j >= 0; j--) {
        Enemy enemy = enemies.get(j);
        
        if(enemy.enemyLocation.x < 0){
          enemies.remove(j);
          
        }
    }
    enemyLocation.add(enemyVelocity);
    
    if(enemyLocation.y < 70 || enemyLocation.y > height - 30) {
      enemyVelocity.y = enemyVelocity.y * (-1);
    }
    
    image(enemyShip, enemyLocation.x, enemyLocation.y);
    
  }
  
  
  void collision() {
    for (int i = projectiles.size() - 1; i >= 0; i--) {
      Projectile projectile = projectiles.get(i);
      
      for (int j = enemies.size() - 1; j >= 0; j--) {
        Enemy enemy = enemies.get(j);
        
        float distance = dist(projectile.projectileLocation.x, projectile.projectileLocation.y, enemy.enemyLocation.x, enemy.enemyLocation.y);
     
        if (distance < 30) {


          println("Index: " + j + " was deleted. There are: " + enemies.size() + " enemies in the arraylist.");
          projectiles.remove(i);
          enemies.remove(j);
          
          score = score + 1;
                    
          //if (millis() - lastTime >= displayTime) {
          //  count = ++count % explosions.length;
          //  lastTime = millis();
          //}
          //image(explosions[count], enemyLocation.x, enemyLocation.y);
          
          //This is supposed to load a series of explosion sprites once the enemy is "shot", but it doesn't seem to work right
          //There is a time delay to display the images in order with a space inbetween them, but I can't get it functioning properly
          //It also seems to run randomly over enemies that were not the ones "shot"
          
          //The projectile is gone do we don't have to check it against all the other enemies.  Break out of the loop. 
          break;
        }
      }
    }
  }
  

}
