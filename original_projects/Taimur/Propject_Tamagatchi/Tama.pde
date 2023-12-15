import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.time.Duration;
import java.time.Month;
class Tama {
  
  //Data necessary for functions
  String last_fed;
  String last_played;
  double hearts;
  double hunger;
  String last_bath;
  int isSick;
  int needBath;
  
  //data necessary for stats
  String Name;
  int total_fed;
  int total_played;
  int total_sick;
  boolean disciplineRequired;  
  String birthday;
  
  Tama(){
    //load table
    for(TableRow row: table.rows()){
      //check what an empty table will give you
      //if(row.getString("Name")){
      //  createTama();
      //}
      
        //get data from table 
        Name = row.getString("Name");
        total_played = row.getInt("Total Played");
        total_fed = row.getInt("Total Fed");
        hearts = row.getInt("Hearts");
        
        last_fed = row.getString("Last Fed");
        last_played = row.getString("Last Played");
        last_bath = row.getString("Last Bath");
        
        //randomize sick, bath, and more
        checkSick();
        checkBath();
        
      

    }
  }
  //functions for actions like feeding, giving medicine and more, basically checks if the tama is full and if not adds value to its hunger 
  void feed(){
    hunger = table.getDouble(0, "Hunger");
    if(this.hunger < 4.0){
      total_fed = table.getInt(0, "Total Fed");
      hunger = hunger + 0.5;
      last_fed = getCurrentDateTime();
      total_fed++;
      table.setInt(0,"Total Fed", total_fed);
      table.setDouble(0, "Hunger", hunger);
      table.setString(0, "Last Fed", last_fed);
      saveTable(table, "data/data.csv");
    }
  }
  
  void giveMedicine(){
    isSick = table.getInt(0, "Sick");
    if(this.isSick == 1){
        isSick = 0;
        table.setInt(0,"Sick", isSick);
        saveTable(table, "data/data.csv");
    }
  }
  void giveBath(){
    needBath = table.getInt(0, "Bath");
    last_bath = table.getString(0, "Last Bath");
    if(this.needBath == 1){
        needBath = 0;
        table.setInt(0,"Bath", needBath);
        table.setString(0, "Last Bath", getCurrentDateTime());
        saveTable(table, "data/data.csv");
    }
  }
  
    
  //returns the current time as a string variable in a specific format
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
  //a random chance that the tama needs a bath
  //also sets the time variable
  void checkBath(){
    needBath = table.getInt(0,"Bath");
    if(needBath == 0){
      if(randomizer()){
        needBath = 1;
        table.setInt(0,"Bath", needBath);
        saveTable(table, "data/data.csv");
      }
    }
  }
  //a random chance that the tama gets sick
  //also sets the time variable
  void checkSick(){
    isSick = table.getInt(0, "Sick");
    total_sick = table.getInt(0, "Total Sick");
    if(isSick == 0){
      if(randomizer()){
        isSick = 1;
        total_sick++;
        table.setInt(0, "Total Sick", total_sick);
        table.setString(0, "Last Sick", getCurrentDateTime());
        table.setInt(0,"Sick", isSick);
        saveTable(table, "data/data.csv");
      }
    }
  }
  //checks if its been more than 3 hours since the last time the tama has been fed 
  //for every three hours the tama will lose .5 hunger
  void checkHunger(){
    last_fed = table.getString(0, "Last Fed");
     if( timeDiff(last_fed,"hour") % 3 == 0 ){
       double howHungry = (timeDiff(last_fed, "hour")/3)*0.5;
       double hunger = table.getDouble(0, "Hunger");
       if(howHungry> 4.0){
         hunger = 0.0;
         table.setDouble(0, "Hunger", hunger);
         saveTable(table, "data/data.csv");
       }
       else{
         hunger = hunger - howHungry;
         table.setDouble(0, "Hunger", hunger);
         saveTable(table, "data/data.csv");
       }
     }
  }
  //checks if its been more than 3 hours since the last time the tama has been played with
  //for every three hours the tama will lose .5 hearts
  void checkBored(){
    last_played = table.getString(0, "Last Played");
     if( timeDiff(last_played,"hour") % 3 == 0 ){
       double howBored = (timeDiff(last_played, "hour")/3)*0.5;
       double hearts = table.getDouble(0, "Hearts");
       if(howBored> 4.0){
         hearts = 0.0;
         table.setDouble(0, "Hearts", hearts);
         saveTable(table, "data/data.csv");
       }
       else{
         hearts = hearts - howBored;
         table.setDouble(0, "Hearts", hearts);
         saveTable(table, "data/data.csv");
       }
     }
  }
  //randomizer used in sick and bath variables, a 30% chance to get either sick or need a bath on start up 
  boolean randomizer(){
    int random = int(random(101));
    if(random < 30){
      return true;
    }
    else{
      return false;
    }   
  }
  //get function
  String getName(){
    return table.getString(0, "Name");
  }
  //a function to get the time difference between a datetime variable and the current date
  //it requires a starting string that represents time and then a string that dictates whether you want a 
  //hour difference or day difference between specific times 
  int timeDiff(String start, String interval){
    Month startMonth = Month.of(int(start.substring(0, 2)));
    Month endMonth = Month.of(month());
    LocalDateTime startDate = LocalDateTime.of(int(start.substring(6, 10)), startMonth, int(start.substring(3, 5)), int(start.substring(12,14)), int(start.substring(15,17)), int(start.substring(18)));; // Start date
    LocalDateTime endDate = LocalDateTime.of(year(), endMonth, day(), hour(), minute(), second()); // End date
    if(interval == "day"){
      int daysBetween = int(ChronoUnit.DAYS.between(startDate, endDate));
      return daysBetween;
    }
    else if(interval == "hour"){
      Duration duration = Duration.between(startDate, endDate);
      long hourDifference = duration.toHours();
      return int(hourDifference);
    }
    else{
      return 0;
    }
    
        
  }
  //a bunch of get functions
  int getAge(){
    birthday = table.getString(0, "Birthday");
    return timeDiff(birthday, "day");
  }
  int getTotalPlayed(){
    return table.getInt(0, "Total Played");
  }
  int getTotalFed(){
    return table.getInt(0, "Total Fed");
  }
  String getLastBath(){
    return table.getString(0, "Last Bath");
  }
  String getLastPlayed(){
    return table.getString(0, "Last Played");
  }
  String getLastFed(){
    return table.getString(0, "Last Fed");
  }
  //death conditions
  void death(){
    last_fed=table.getString(0, "Last Fed");
    last_bath = table.getString( 0, "Last Bath");
    int needBath = table.getInt(0, "Bath");
    int isSick = table.getInt(0, "Sick");
    String last_sick = table.getString(0, "Last Sick");
    last_played = table.getString(0, "Last Played");
    hearts = table.getInt(0, "Hearts");
    
    if(timeDiff(last_fed, "hour") > 27){
      tamagoestothefarm();
    }
    else if(needBath == 1 && timeDiff(last_bath, "hour") > 48){
      tamagoestothefarm();
    }
    else if(isSick == 1 && timeDiff(last_sick, "hour") > 24){
      tamagoestothefarm();
    }
    else if(hearts == 0.0 && timeDiff(last_played, "hour") > 24){
      tamagoestothefarm();
    }
    
    
}
//if the tama goes without a bath for too long it will become sick
void dirty(){
   last_bath = table.getString( 0, "Last Bath");
   int needBath = table.getInt(0, "Bath");
   int isSick = table.getInt(0, "Sick");
   if(needBath == 1 && timeDiff(last_bath, "hour") > 24 && isSick == 0){
     isSick = 1;
     table.setString(0, "Last Sick", getCurrentDateTime());
     table.setInt(0, "Sick", isSick);
     saveTable(table, "data/data.csv");
   }
}
//resets tama if it dies
void tamagoestothefarm(){
  table.setString(0, "Birthday", getCurrentDateTime());
  table.setDouble(0, "Hunger", 4.0);
  table.setDouble(0, "Hearts", 4.0);
  table.setString(0, "Last Fed", getCurrentDateTime());
  table.setString(0, "Last Bath", getCurrentDateTime());
  table.setString(0, "Last Played", getCurrentDateTime());
  table.setString(0, "Last Sick", getCurrentDateTime());
  table.setInt(0, "Total Fed", 0);
  table.setInt(0, "Total Sick", 0);
  table.setInt(0, "Sick", 0);
  table.setInt(0, "Bath", 0);
  table.setInt(0, "Highscore", 0);
  
  
  
}
}
