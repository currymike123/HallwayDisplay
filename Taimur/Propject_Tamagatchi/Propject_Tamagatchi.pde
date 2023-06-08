int total_played;
Table table;
Tama tama;

int numIcons = 8; // number of icons
int yTop = 20; // y position of icons on top
int xIcon = 85;//x location of icons
PImage[] icons = new PImage[numIcons]; // array of icon images
int selectedIcon = -1; // index of selected icon
PImage poop;

//Icons and variables for heart monitor page
PImage dino0000;//Dino Icon for the stats page
PImage fullHeart;//Full and half heart images for health monitor
PImage halfHeart;
double tempHearts;//To help with printing of the right type of heart
int heartXLoc;//XLoc of heart icons
double tempHunger;//To help with printing of the right type of icon
int hungerXLoc;//XLoc of meat icons
PImage fullHunger;//Full and half meat images for 
PImage halfHunger;

//Icons and data for game
PImage dinoRun1;
PImage dinoRun2;
PImage dinoJump;
PImage dinoDuck;
PImage dinoDuck1;
PImage smallCactus;
PImage bigCactus;
PImage manySmallCactus;
PImage bird;
PImage bird1;
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Bird> birds = new ArrayList<Bird>();
ArrayList<Ground> grounds = new ArrayList<Ground>();
int obstacleTimer = 0;
int minTimeBetObs = 60;
int randomAddition = 0;
int groundCounter = 0;
float speed = 10;
int groundHeight = 50;
int playerXpos = 100;
int highScore;//add this to csv load for stats page and game

//booleans to check what page we should be on home always starts true
boolean play = false;
boolean home = true;
boolean stats = false;
boolean heartMonitor = false;
boolean feed = false;

//initialize for the game
Player dino;



void setup(){
  //sets background color and window size
  size(800, 480);
  background(255);
  
  //loads image for heart monitor
  dino0000 = loadImage("dino0000.png");
  fullHeart = loadImage("fullheart.png");
  halfHeart = loadImage("halfheart.png");
  fullHunger = loadImage("bigmeat.png");
  halfHunger = loadImage("halfmeat.png");
  
  
  //loads images for the game 
  dinoRun1 = loadImage("dinorun0000.png");
  dinoRun2 = loadImage("dinorun0001.png");
  dinoJump = loadImage("dinoJump0000.png");
  dinoDuck = loadImage("dinoduck0000.png");
  dinoDuck1 = loadImage("dinoduck0001.png");
  smallCactus = loadImage("cactusSmall0000.png");
  bigCactus = loadImage("cactusBig0000.png");
  manySmallCactus = loadImage("cactusSmallMany0000.png");
  bird = loadImage("berd.png");
  bird1 = loadImage("berd2.png");
  
  //loads table from data.csv, this is the only place that we load the table in the project
  //i tried loading it in multiple places and it was causing me issues so I tried to keep it in just one spot
  table = loadTable("data/data.csv", "header");
  
  //initializes player and tama classes
  dino = new Player();
  tama = new Tama();
  
  
  //table.print();
  //loading in the highscore value from our data.csv
  for(TableRow row: table.rows()){
    highScore = row.getInt("Highscore");
  }
  
  //print(highScore);
  //load image by itterating through the array, the icons are labelled with increasing numbers
  for (int i = 0; i < numIcons; i++) {
    icons[i] = loadImage("icon" + i + ".png");
  }
  poop = loadImage("poop.png");
  
}


void draw(){
  //time based checks that decrease specific attributes or even kills the tama if too much time has passed
  table = loadTable("data/data.csv", "header");
  tama.checkHunger();
  tama.dirty();
  tama.death();
  
  //if the game is selected
  if(play){
    //clean background
    background(250);
    
    //draw ground line
    stroke(0);
    strokeWeight(2);
    line(0, height - groundHeight - 30, width, height - groundHeight - 30);
    
    //updates the obstacles, decides what obstacles come next
    updateObstacles();
    
    //updates highscore
    if(dino.score > highScore){
      highScore = dino.score;
    }
    
    //shows the score an highscore 
    textSize(20);
    fill(0);
    textAlign(LEFT);
    text("Score: " + dino.score, 5, 20);
    text("High Score: " + highScore, width- (140 + (str(highScore).length() * 10)) , 20);
    textAlign(CENTER);
  }
  //if nothing is selected it will remain home
  else if(home){
    //loads variables that decide if the warnings will show up on the right side of the home screen
    int sick = table.getInt(0, "Sick");
    int needBath = table.getInt(0, "Bath");
    double hunger = table.getDouble(0, "Hunger");
    double heart =table.getDouble(0, "Hearts");
    //these draw over the warnings and the poop icons on the screen 
    stroke(255);
    fill(255);
    rect(0,80, 100, 300);
    rect(300, 200, 32,32);
    rect(450, 275, 32,32);
    stroke(0);
    fill(0);
    
    //conditional statements that decide if icons show up on the left of the screen
    if(sick == 1){ 
      image(icons[2], 50, 150);
    }
    if(hunger < 2.0){
      image(icons[0], 50, 180);
    }
    if(heart < 2.0){
      image(icons[3], 50, 210);
    }
    if(needBath == 1){
      image(poop, 300, 200);
      image(poop, 450, 275);
      
    }
    
    //placement of the main tama character
    float mainTamaX = width/2 - dinoRun1.width/2; // calculate x-coordinate of image center
    float mainTamaY = height/2 - dinoRun1.height/2; // calculate x-coordinate of image center
    image(dinoRun1, mainTamaX, mainTamaY);
    
    
    //mapping of the icons and formatting of the main menu 
    line(200, 0, 200, 70);
    line(400, 0, 400, 70);
    line(600, 0, 600, 70);
    line(200, height - 70, 200, height);
    line(400, height - 70, 400, height);
    line(600, height - 70, 600, height);
    line(0,70, 800, 70);
    line(0, height - 70, 800, height-70);
    for(int i = 0; i < numIcons; i++){
      if(i<4){
        image(icons[i], xIcon, yTop);
        xIcon = xIcon + 200; 
      }
      else{
        if(xIcon >780){
          xIcon = 85;
        }
        image(icons[i], xIcon, height - 50);
        xIcon = xIcon + 200;
      }
    }
    xIcon = 85;
  }
  //if stats are selected
  else if(stats){
    textSize(30);
    fill(0);
    textAlign(CENTER);
    
    //shows different stats from the tama such as age, total games played, highscore, etc
    //get them by just pulling from data.csv
    text(tama.getName(), width/2, 100);
    textSize(20);
    text("Age: " + tama.getAge(), width/2, 120);
    
    textSize(18);
    text("Total Games Played: "+ tama.getTotalPlayed(), width/2, 150);
    text("High Score: " + highScore, width/2, 170);
    text("Last Played: " + tama.getLastPlayed(), width/2, 190);
    text("Total Meals Fed: " + tama.getTotalFed(), width/2, 210);
    text("Last Fed: " + tama.getLastFed(), width/2, 230);
    text("Last Bath: " + tama.getLastBath(), width/2, 250);
    
    textSize(15);
    text("press 'b' to go back to the home screen", width/2, 400 );
     
  }
  //if heart monitor is selected
  else if(heartMonitor){
    
    float dinox = width/2 - dino0000.width/2; // calculate x-coordinate of image center
    image(dino0000, dinox, 100);
    textSize(30);
    fill(0);
    textAlign(CENTER);
    
    text(tama.getName(), width/2, 150);
    
    //placement of the heart and hunger bars they only are shown in intervals of 0.5
    tempHearts = table.getDouble(0, "Hearts");
    heartXLoc = 355;
    while(tempHearts >= 0){
      println(tempHearts);
      if(tempHearts - 1 >= 0){
        image(fullHeart, heartXLoc, 160);
      }
      else if(tempHearts - 1 ==-0.5){
        image(halfHeart, heartXLoc, 160);
      }
      heartXLoc = heartXLoc + 20;
      tempHearts = tempHearts -1;
    }
    
    tempHunger = table.getDouble(0, "Hunger");
    hungerXLoc = 355;
    while(tempHunger >= 0){
      println(tempHunger);
      if(tempHunger - 1 >= 0){
        image(fullHunger, hungerXLoc, 190);
      }
      else if(tempHunger - 1 ==-0.5){
        image(halfHunger, hungerXLoc, 190);
      }
      hungerXLoc = hungerXLoc + 20;
      tempHunger = tempHunger - 1;
      
    }
    
    textSize(15);
    text("press 'b' to go back to the home screen", width/2, 400 );
    
  }
  
}

void keyReleased(){
  //these are based on after the tama dies in the game
  if(play){
    switch(key){
      case 's': if(!dino.dead){
                  dino.ducking(false);
                }      
                break;
      case 'r': if(dino.dead){
                  reset();
                }      
                break;
      case 'b': if(dino.dead){
                  background(255);
                  play = false;
                  home = true;
                }
    }
  }
  else if(stats){
    //sends the player back to the home screen by setting home to true and stats to false
    switch(key){
      case 'b': background(255);
                stats = false;
                home = true;
    }
  }
  else if(heartMonitor){
    //sends the player back to the home screen by setting home to true and heartMonitor to false 
    switch(key){
      case 'b': background(255);
                heartMonitor = false;
                home = true;
    }
  }
}

void keyPressed(){
  //movement controls for the game
  if(play){
    switch(key){
      case ' ': dino.jump();
        break;
      case 's': if(!dino.dead){
                  dino.ducking(true);
                }      
                break;
    }
  }
}

void updateObstacles(){
  showObstacles();
  dino.show();
  if(!dino.dead){
    obstacleTimer++;
    speed+= 0.002;
    if(obstacleTimer > minTimeBetObs + randomAddition){
      addObstacle();
    }
    groundCounter++;
    if(groundCounter > 10){
      groundCounter = 0;
      grounds.add(new Ground());
      
    }
    moveObstacles();
    dino.update();
    
  }
  else{
    textSize(32);
    fill(0);
    textAlign(LEFT);
    text("Game Over :(", 300, 200);
    textSize(16);
    text("(press r to play again or b to go back home)", 250, 220);
    textAlign(CENTER);
    
  }
    
}

void showObstacles(){
  for(int i = 0; i < grounds.size(); i++){
    grounds.get(i).show();
  }
  for(int i = 0; i < obstacles.size(); i++){
    obstacles.get(i).show();
  }
  for(int i = 0; i < birds.size(); i++){
    birds.get(i).show();
  }
}

void addObstacle(){
  if(random(1) < 0.15){
    birds.add(new Bird(floor(random(3))));
  }
  else{
    obstacles.add(new Obstacle(floor(random(3))));
  }
  randomAddition = floor(random(50));
  obstacleTimer = 0;
}

void moveObstacles(){
  for(int i = 0; i < grounds.size(); i++){
    grounds.get(i).move(speed);
    if(grounds.get(i).posX < -playerXpos){
      grounds.remove(i);
      i--;
    }
  }
  for(int i = 0; i < obstacles.size(); i++){
    obstacles.get(i).move(speed);
    if(obstacles.get(i).posX < -playerXpos){
      obstacles.remove(i);
      i--;
    }
  }
  for(int i = 0; i < birds.size(); i++){
    birds.get(i).move(speed);
    if(birds.get(i).posX < -playerXpos){
      birds.remove(i);
      i--;
    }
  }
}

void reset(){
  //resets the game when the player dies
  dino = new Player();
  obstacles = new ArrayList<Obstacle>();
  birds = new ArrayList<Bird>();
  grounds = new ArrayList<Ground>();
  
  obstacleTimer = 0;
  randomAddition = floor(random(50));
  groundCounter = 0;
  speed = 10;
  
}
void mouseClicked(){
  //how the user navigates the home page
  if(mouseX>= 600 && mouseX<= 800 && mouseY <= 70 && mouseY >= 0){
    reset();
    home = false;
    play = true;
    
  }
  else if(mouseX >= 0 && mouseX <= 200 && mouseY <= 70 && mouseY >= 0 ){
    
    tama.feed();

    table.print();
  }
  else if(mouseX>= 400 && mouseX<= 600 && mouseY <= 70 && mouseY >= 0){
    tama.giveMedicine();
    table.print();
    
  }
  else if(mouseX >= 0 && mouseX <= 200 && mouseY <= height && mouseY >= height-70){
    tama.giveBath();
    table.print();
  }
  else if(mouseX >= 400 && mouseX <= 600 && mouseY <= height && mouseY >= height-70){
    background(255);
    home = false;
    stats =true;
    table.print();
  }
  else if(mouseX >= 200 && mouseX <= 400 && mouseY <= 70 && mouseY >= 0){
    background(255);
    home = false;
    heartMonitor =true;
    
    table.print();
  }
}

 
  
