class Player{
  float posY = 0;
  float velY = 0;
  float gravity = 1.2;
  int size = 20;
  double hearts;
  
  boolean duck = false;
  boolean dead = false;
  
  int runCount = -5;
  int lifespan;
  int score;
  
  
  
  Player(){
    
  }
  
  void jump(){
    gravity = 1.2;
    velY = 16;
  }
  
  void show(){
    if(duck && posY == 0){
      if(runCount < 0){
        image(dinoDuck, playerXpos - dinoDuck.width /2, height - groundHeight - (posY + dinoDuck.height));
      }
      else{
        image(dinoDuck1, playerXpos - dinoDuck1.width /2, height - groundHeight - (posY + dinoDuck1.height));
      }
    }
    else{
      if(posY == 0){
        if(runCount < 0){
          image(dinoRun1, playerXpos - dinoRun1.width /2, height - groundHeight - (posY + dinoRun1.height));
        }
        else{
          image(dinoRun2, playerXpos - dinoRun2.width /2, height - groundHeight - (posY + dinoRun2.height));
        }
      }
      
      else{
        image(dinoJump, playerXpos - dinoJump.width /2, height - groundHeight - (posY + dinoJump.height));
      }
    }
    
    if(!dead){
      runCount++;
    }
    if(runCount > 5){
      runCount = -5;
    }
  }
  
  void move(){
    posY += velY;
    if(posY > 0){
      velY -= gravity;
    }
    else{
      velY = 0;
      posY = 0;
    }
    
    for(int i =0; i< obstacles.size(); i++){
      if(dead){
        if(obstacles.get(i).collided(playerXpos, posY + dinoRun1.height /2, dinoRun1.width* 0.5, dinoRun1.height)){
          dead = true;
          int total_played = table.getInt(0, "Total Played");
          hearts = table.getDouble(0, "Hearts");
          if(hearts<4.0){
            hearts = hearts+ 0.5;
          }
          total_played++;
          table.setDouble(0, "Hearts", hearts);
          table.setString(0, "Last Played", this.getCurrentDateTime());
          table.setInt(0, "Total Played", total_played);
          table.setInt(0, "Highscore", highScore);
          table.print();
          saveTable(table, "data/data.csv");
        }
      }
      else{
        if(obstacles.get(i).collided(playerXpos, posY + dinoRun1.height /2, dinoRun1.width* 0.5, dinoRun1.height)){
          dead = true;
          int total_played = table.getInt(0, "Total Played");
          total_played++;
          hearts = table.getDouble(0, "Hearts");
          if(hearts<4.0){
            hearts = hearts+ 0.5;
          }
          table.setDouble(0, "Hearts", hearts);
          table.setString(0, "Last Played", this.getCurrentDateTime());
          table.setInt(0, "Total Played", total_played);
          table.setInt(0, "Highscore", highScore);
          table.print();
          saveTable(table, "data/data.csv");
        
        } 
      }
    }
    for(int i =0; i< birds.size(); i++){
      if(duck && posY == 0){
        if(birds.get(i).collided(playerXpos, posY + dinoDuck.height /2, dinoDuck.width* 0.5, dinoDuck.height)){
         dead = true;
        }
        
      }
      else{
        if(birds.get(i).collided(playerXpos, posY + dinoRun1.height /2, dinoRun1.width* 0.5, dinoRun1.height)){
          dead = true;
        }
      }
    }
  }
  
  void ducking(boolean isDucking){
    if(posY != 0 && isDucking){
      gravity = 3;
    }
    duck = isDucking;
  }
  
  void update(){
    incrementCounter();
    move();
  }
  
  void incrementCounter(){
    lifespan++;
    if(lifespan% 3 == 0){
      score += 1;
    }
  }
  //gets the current date and time for the data entries after the dino dies in the game
  String getCurrentDateTime(){
    int d = day();
    String day;
    if(d<10){
      day = "0"+String.valueOf(d);
    }else{
      day = String.valueOf(d);
    }
    
    int m = month();
    String month;
    if(m<10){
      month = "0"+String.valueOf(m);
    }else{
      month = String.valueOf(m);
    }
    
    int y = year();
    
    int s = second();
    String second;
    if(s<10){
      second = "0"+String.valueOf(s);
    }else{
      second = String.valueOf(s);
    }
    
      
    int min = minute();
    String minute;
    if(min<10){
      minute = "0"+String.valueOf(min);
    }else{
      minute = String.valueOf(min);
    }
    
    
    int h = hour();
    String hour;
    if(h<10){
      hour = "0"+String.valueOf(h);
    }else{
      hour = String.valueOf(h);
    }
    
    
    String currentDateTime = month + "/" + day + "/" + String.valueOf(y) + " T" + hour + ":" + minute+ ":" + second;
    return currentDateTime;
  }
}
