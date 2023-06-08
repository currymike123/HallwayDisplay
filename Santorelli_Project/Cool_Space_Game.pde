Ship s;
ArrayList<Enemy> enemies;
ArrayList<Projectile> projectiles;
ArrayList<Star> stars;

PFont font1;

int health = 5;
int score = 0;

boolean start = false;
boolean restart = false;

void setup() {
  size(1600, 800);
  frameRate(60);
  smooth();
  background(0);
  noCursor();
  imageMode(CENTER);

  s = new Ship();
  enemies = new ArrayList<Enemy>();
  projectiles = new ArrayList<Projectile>();
  stars = new ArrayList<Star>();
  
  for (int i = 0; i < 1000; i++) {
    Star star = new Star();
    stars.add(star);
  }
  
  font1 = createFont("Arial Bold", 18);
}

void draw() {
  //Initial Start Screen
  if (start == false) {
      
    background(0);
  
    //Generate Stars in the background ----------------------------
    for (Star s : stars) {
      s.display();
      s.update();
    }
    
    showStartScreen();
    
  }
  
  //Begins Game==================================================================
  if (start == true){

    background(0);
  
    //Generate Stars in the background ----------------------------
    for (Star s : stars) {
      s.display();
      s.update();
    }
    
    //Create and Control User Ship ----------------------------------
    s.display();
    s.fire();
    s.damage();
  
    //Score Display -----------------------------------------------
    scoreDisplay();

    //Spawn Enemies -----------------------------------------------
    if (frameCount % 20 == 0) {   //  frameCount % (#) controls spawn rate
      enemies.add(new Enemy());
    }
  
    //Create and Control Enemies----------------------------------
    if(enemies.size() > 0) {
      for (int n = 0; n < enemies.size(); n++){
        Enemy enemy = enemies.get(n);
        enemy.display();
        enemy.collision();
       }
     }
  
    //Create and Control Projectiles (From User) --------------------
    if(projectiles.size() > 0) {
      for (int n = 0; n < projectiles.size(); n++){
        Projectile projectile = projectiles.get(n);
        projectile.update();
        projectile.fireProjectile();
      }
    }
  
  youLose();  //Checks for losing condition
  youWin();   //Checks for winning condition

  
  }
}

  
void keyReleased() {
  switch (key) {
     
     case 's':
       start = true;
       break;
       
     case ENTER:
       restart = true;
       break;
       
     case RETURN:
       restart = true;
       break;
     
     case ESC:
       exit();
       break;
      
     case 'b':
       score = 500;
       break;
        //Debugging win condition
        
      default:
        break;

  }
}

void showStartScreen() {
    fill(0);
    rect(400, 200, 800, 520);
    textFont(font1);
    fill(255);
    textSize(60);
    text("Greetings!", 640, 250);
    fill(#F0AB2C);
    textSize(30);
    text("Use your mouse to control the hero ship:", 500, 340);
    text(" - Move the mouse to dodge / aim", 520, 370);
    text(" - Left Click to shoot", 520, 400);
    fill(#5CDADE);
    text("Hit 200 enemy ships to win", 500, 520);
    text(" - Difficulty will increase at 100 points", 520, 550);
    textSize(50);
    fill(#FF0000);
    text("Godspeed.", 650, 660);
    textSize(30);
    text("Press the 's' key to start", 600, 710);  
}

void scoreDisplay() {
    fill(40);
    rect(0, 0, width, 50); 
    fill(255);
    rect(0, 47, width, 1);
    textFont(font1);
    textSize(30);
    text("Health: ", 630, 30);
    text("Score: ", 830, 30);
    text(health, 750, 30);
    text(score, 940, 30);
}

void youLose() {
    //Lose Condition -----------------------------------
    if (health <= 0) {
      background(0);
      textSize(50);
      text("Game Over!", 675, 350);
      textSize(30);
      text("Press Enter to Try Again", 660, 425);
      text("Press Esc to Exit", 695, 475);
    
      if(restart == true) {
        score = 0;
        health = 5;  
      
        enemies.clear();
        projectiles.clear();
        restart = false;
 
      }
    }
}

void youWin() {
    //Win Condition ---------------------------------------
    if (score >= 200) {
      background(0);
      textSize(70);
      fill(#D3CE1A);
      text("Congratulations, You Win!!!", 300, 300);
      textSize(30);
      fill(230);
      text("Press Enter to Do It Again", 520, 420);
      text(" - Try to Get Here Faster?", 540, 470);
      text(" - Or With Less Damage?", 560, 510);
      fill(#FF0000);
      text("Press Esc to Exit", 580, 700);
    
      if(restart == true) {
        score = 0;
        health = 5;  
      
        enemies.clear();
        projectiles.clear();
        restart = false;
      }
    }
}
  
