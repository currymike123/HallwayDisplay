// Hallway Display
// Michael Curry, 2023

//////////////////////////////////////////////////////////////////////////////////////////////////////////

//Libraries 

import processing.net.*;

//Global Variables

//Variables for the server.
Client c;
String data;

//All the paths to the applications.

//String baseDir = "./Exports/";

//String path  = baseDir + "Jaden/linux-amd64/jaden";
//String path2 = baseDir + "Lara/linux-amd64/rain";
//String path3 = baseDir + "Kevin/linux-amd64/Santorelli_Project";
//String path4 = baseDir + "Ethan/linux-amd64/Ethan";
//String path5 = baseDir + "Michelle/linux-amd64/Michelle";
//String path6 = baseDir + "Mette/linux-amd64/LEAFFFFF";

// String path = "/home/mike/Desktop/HallwayDisplay/Exports/Jaden/linux-amd64/jaden";
// String path2 = "/home/mike/Desktop/HallwayDisplay//Exports/Lara/linux-amd64/rain";
// String path3 = "/home/mike/Desktop/HallwayDisplay/Exports/Kevin/linux-amd64/Santorelli_Project";
// String path4 = "/home/mike/Desktop/HallwayDisplay/Exports/Ethan/linux-amd64/Ethan";
// String path5 = "/home/mike/Desktop/HallwayDisplay/Exports/Michelle/linux-amd64/Michelle";
// String path6 = "/home/mike/Desktop/HallwayDisplay/Exports/Mette/linux-amd64/LEAFFFFF";


 String path = "/home/display/Desktop/HallwayDisplay/Exports/Jaden/linux-amd64/jaden";
 String path2 = "/home/display/Desktop/HallwayDisplay//Exports/Lara/linux-amd64/rain";
 String path3 = "/home/display/Desktop/HallwayDisplay/Exports/Kevin/linux-amd64/Santorelli_Project";
 String path4 = "/home/display/Desktop/HallwayDisplay/Exports/Ethan/linux-amd64/Ethan";
 String path5 = "/home/display/Desktop/HallwayDisplay/Exports/Michelle/linux-amd64/Michelle";
 String path6 = "/home/display/Desktop/HallwayDisplay/Exports/Mette/linux-amd64/LEAFFFFF";

//All the window names.

String windowName = "Jaden Daniels";
String windowName2 = "Lara Palombi";
String windowName3 = "Kevin Santorelli";
String windowName4 = "Ethan McDermott";
String windowName5 = "Michelle Hasbun";
String windowName6 = "Mette Oki";

//All text strings.
String findHand = "Hold one hand up. .  . The other hand behind your back. . . Keep only one hand in the frame. . ."; 
String handSearch = "Searching for a hand (just one). . .";
String title = "Select a Project to Launch . . . ";
String jaden = "Jaden Daniels invites the user to create a sketch by moving rectangles around a screen and changing there color when your hand intersects a rectangle's path.";
String lara = "Lara Palombi creates a rain simulation for the user to explore.  Move the umbrella around the screen to stay dry and watch the light change from day to night.";
String kevin = "Kevin Santorelli built a project referencing early atari games such as Space Invaders.  Move the space ship and destory the alien invaders!";
String ethan = "Ethan McDermott creates a rotating world of gradient strands.  Move your hand left to right to increase and decrease the speed of the rotation.";
String michelle = "Michelle Hasbun designs a traditional Pong game infused with psychedelic elemnts.  Use your hand to move the paddle.";
String mette = "Mette Oki creates a serene environment of falling leaves.  Move your hand over the tree to see them drop.";

//All text objects.
TextTitle handText;
TextTitle handSearching;
TextTitle t1;
TextTitle t2;
TextBox jadenText;
TextBox laraText;
TextBox kevinText;
TextBox ethanText;
TextBox michelleText;
TextBox metteText;

//Preview images.
PImage img1;
PImage img2;
PImage img3;
PImage img4;
PImage img5;
PImage img6;

//Hand Images.
PShape hand;
PShape hand1;
PShape hand2;
PShape hand3;

//All the window objects.
Window w1;
Window w2;
Window w3;
Window w4;
Window w5;
Window w6;

//Background Image. 
PGraphics bg;

//Screen Size
int screenX;
int screenY;

//Mouse position
int myMouseX;
int myMouseY;

//Custom Font
PFont myFont;

// Add a counter.
int counter;



//////////////////////////////////////////////////////////////////////////////////////////////////////////

public void settings() {

  screenX = 1920;
  screenY = 1080;
 
  size(screenX,screenY, P2D); // Set the desired width and height
 
}

// Check how many hands are on the screen to set the UI.

int currentState = -1;  // -1 for initial state
int nextSetState = -1;  // Stores next state to set
int delayTime = 8000;  // Delay time of 6 seconds in milliseconds
int lastChangeTime;  // Time when the last state change happened
int nextStateStartTime; // Time when the next state should be set

void setup(){

  surface.setResizable(true);
  //Set the times to delay the change of UI.
  lastChangeTime = millis();
  nextStateStartTime = millis();

  //Load all the images.
  img1 = loadImage("images/Jaden.png");
  img2 = loadImage("images/Lara.png");
  img3 = loadImage("images/Kevin.png");
  img4 = loadImage("images/Ethan.png");
  img5 = loadImage("images/Michelle.png");
  img6 = loadImage("images/Mette.png");

  //Load hand shapes.
  hand = loadShape("images/Hand.svg");
  hand1 = loadShape("images/Hand1.svg");
  hand2 = loadShape("images/Hand2.svg");
  hand3 = loadShape("images/Hand3.svg");

  //Load font.
  myFont = createFont("SyneMono-Regular.ttf",100);
  textFont(myFont);


  //Create all the objects.
  handText = new TextTitle(width/18,height-400,findHand,80);
  handSearching = new TextTitle(setPos(4.1,0),setPos(7.5,1),handSearch,30);

  //Title
  t1 = new TextTitle(setPos(2,0),setPos(1,1),title,20);

  //Jaden's Project
  w1 = new Window(setPos(2,0),setPos(2,1),150,150,img1,windowName,path);
  jadenText = new TextBox(jaden,setPos(3,0),setPos(2,1),400,w1.h,15);
  //t2 = new TextTitle(width/3,height/4,jaden,30);

  //Lara's Project
  w2 = new Window(setPos(2,0),setPos(5,1),150,150,img2,windowName2,path2);
  laraText = new TextBox(lara,setPos(3,0),setPos(5,1),400,w2.h,15);
  
  //Kevin's Project
  w3 = new Window(setPos(2,0),setPos(8,1),150,150,img3,windowName3,path3);
  kevinText = new TextBox(kevin,setPos(3,0),setPos(8,1),400,w3.h,15);
  
  //Ethan's Project
  w4 = new Window(setPos(6,0), setPos(2,1),150,150,img4,windowName4,path4);
  ethanText = new TextBox(ethan,setPos(7,0),setPos(2,1),400,w4.h,15);
  
  //Michelle's Project
  w5 = new Window(setPos(6,0),setPos(5,1),150,150,img5,windowName5,path5);
  michelleText = new TextBox(michelle,setPos(7,0),setPos(5,1),400,w5.h,15);
 
  //Mette's Project
  w6 = new Window(setPos(6,0),setPos(8,1),150,150,img6,windowName6,path6);
  metteText = new TextBox(mette,setPos(7,0),setPos(8,1),400,w6.h,15);
 

  //Create the background image to be drawn to the screen.  Calculate it once and save it as an image. 
  bg = createGraphics(width,height);
  noiseBackground();

  //Draw the background image to the screen.
  image(bg,0,0);

  //Connect to the server for the mouse position.
  c = new Client(this, "localhost", 9999);
  
  //Default mouse
  myMouseX = setPos(7,0);
  myMouseY = setPos(6,1);

  // // If counter.csv exists open it and set counter to the number.
  // if (new File(sketchPath("counter.csv")).exists()) {
  //   Table table = loadTable("counter.csv");
  //   TableRow row = table.getRow(0);
  //   counter = row.getInt(0);
  // } else {
  //   counter = 1;
  // }

}


void draw(){
  
  //Draw the image to the screen.
  image(bg,0,0);

  //Display the counter in a white box on the bottom right. Bug in animation carry over. 
  //displayCounter();
  

  //Get the data from the server.
  if (c.available() > 0) {
    // read the data from the client
    data = c.readString();
    
    String[] xy = split(data, ',');
    
    float x = float(xy[0]);
    float y = float(xy[1]);
    float test = float(xy[2]);
    nextSetState = int(float(xy[2]));
    println(nextSetState);
    //Scaline factor
    
    //Set the mouse position to the data from the server.
    myMouseX = int(map(int(x),0,640,0,screenX));
    myMouseY = int(map(int(y),0,480,0,screenY));
  }


   // Check if it's time to change the state
  if (millis() - lastChangeTime >= delayTime) {
    // Only change the state if nextSetState has been the same for 6 seconds
    if (nextSetState != -1 && millis() - nextStateStartTime >= delayTime) {
      currentState = nextSetState;
      lastChangeTime = millis();  // Update last change time
      nextSetState = -1; // Reset next state
      nextStateStartTime = millis(); // Reset next state start time
    }
  }

    // Display UI based on the state
  if (currentState == -1) {
    handSearchUI();
  } else if (currentState == 0) {
    handSearchUI();
  } else if (currentState == 1) {
    projectUI();
  } else if (currentState == 2) {
    handSearchUI();
  }

  // Every 20 seconds save the counter variable to a csv file.
  // if (millis() % 20000 == 0) {
  //   Table table = new Table();
  //   TableRow newRow = table.addRow();
  //   newRow.setInt("counter", counter);
  //   saveTable(table, "counter.csv");
  // }


  //Draw the hand.
  shape(hand,myMouseX,myMouseY,hand.width/4,hand.height/4); 
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

//Function to return position on screen.

int setPos(float pos,int dir){
  if(dir == 0){
    float x = (pos/12) * screenX;
    return int(x);
  }else if(dir == 1){
    float y = (pos/12) * screenY;
    return int(y);
  }else{
    return 0;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

void displayCounter(){
  pushStyle();
  fill(255);
  rect(width-400, height-200, 350, 75);
  fill(0);
  textSize(30);
  text("Number of user: " + counter, width-390, height-150);
  popStyle();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

int count = 0;

void handSearchUI(){
  fill(80,170,220,50);
      noStroke();
      rectMode(CENTER);
      rect(setPos(6,0),setPos(6,1),setPos(4,0),setPos(8,1));
      rectMode(CORNER);
      textSize(85);
      fill(160);
      text("Computational",setPos(4.1,0),setPos(2.9,1));
      text("Media",setPos(6.4,0),setPos(3.8,1));
      textSize(25);
      text("(1) Hold one hand up.",setPos(4.1,0),setPos(8.5,1));
      text("(2) The other behind your back.",setPos(4.1,0),setPos(9,1));
      text("(3) Keep only one hand in the frame.",setPos(4.1,0),setPos(9.5,1));

      shape(hand,setPos(7,0),setPos(6,1),hand.width/4,hand.height/4);
      
      // text("Media",width/2-605,1710);
      
      //Check for hand control.  Hand detection is only seeing one hand.  It will take you through the sequence of putting your hand behind your back.
      shapeMode(CENTER);
      if(count<60){
        
        shape(hand1,setPos(5,0),setPos(5.2,1),hand.width/2,hand.height/2);
        count++;
      }else if(count>=60 && count<120){
        shape(hand2,setPos(5,0),setPos(5.2,1),hand.width/2,hand.height/2);
        count++;
      }else if(count>=120 && count<180){
        shape(hand3,setPos(5,0),setPos(5.2,1),hand.width/2,hand.height/2);
        count++;
      }else{
        count = 0;
      }

      handSearching.draw();
      

}
//////////////////////////////////////////////////////////////////////////////////////////////////////////

void projectUI(){
   //Check to see if the apps should launch
    w1.launch();
    w2.launch();
    w3.launch();
    w4.launch();
    w5.launch();
    w6.launch();

    //Draw the windows.
    w1.draw();
    w2.draw();
    w3.draw();
    w4.draw();
    w5.draw();
    w6.draw();

    //Draw the text.
    t1.draw();
    jadenText.draw();
    laraText.draw();
    kevinText.draw();
    ethanText.draw();
    michelleText.draw();
    metteText.draw();

}


//////////////////////////////////////////////////////////////////////////////////////////////////////////

//Function fro the background noise..
float detail = 0.4;
float increment = 0.02;

void noiseBackground(){
  bg.beginDraw();

  bg.loadPixels();

  float xoff = 0.0; // Start xoff at 0
  float manip = map(map(myMouseX,0,width,width/2,width),width/2,width,-.1,1);
  
  detail = detail + random(-.1,.1);
  noiseDetail(5, detail);
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float bright = (noise(xoff, yoff) * 255) / 2;

      bright = map(bright,0,255,60,150);
      
     
        // Set each pixel onscreen to a grayscale value
        bg.pixels[x+y*width] = color(bright);
      
    }
  }
  
  bg.updatePixels();
  bg.endDraw();
}

// This function is called when the sketch is stopped
void stop() {
  c.stop();  // Close the connection to the server
  super.stop();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

class TextTitle{
  
  int x,y;
  String title;
  int textSize;
  String displayedText;
  int currentIndex;

  TextTitle(int x, int y, String title, int textSize){
    this.x = x;
    this.y = y;
    this.title = title;
    this.textSize = textSize;
    currentIndex = 0;
    displayedText = "";
  }

  void draw(){

   // Reveal characters one by one
  if (currentIndex < title.length() && frameCount % 4 == 0) {
   
    // Append the next character to the displayed text
    displayedText += title.charAt(currentIndex);
    currentIndex++;
  }

  if(currentIndex  == title.length() && frameCount % 128 == 0){
    displayedText = "";
    currentIndex = 0;
  }
  
  // Display the text on the screen
  textSize(textSize);
  text(displayedText, x, y+textAscent());
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////

class Window{

  int x,y,w,h;
  String title;
  String path;
  PImage img;
  int frame;
  int fontSize;
  WindowCounter counter;
  
  Window(int x, int y, int w, int h, PImage img, String title, String path){

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    frame = 0;
    fontSize = 11;;
    this.img = img;
    this.title = title;
    this.path = path;
    this.counter = new WindowCounter(x,y,w,h);
  }
  
  void draw(){

    image(img,x,y,w,h);
    textSize(fontSize);
    float textW = textWidth(title);
  

    if(counter.isCursorInsideWindow()){
      
      if(frame < 15){
        noFill();
        stroke(70 - frame);
        strokeWeight(frame*2);
        rect(x-frame,y-frame,w+frame*2,h+frame*2);
        if(frameCount%3 == 0){
          frame++;
        }
      }else if(frame == 15){
        frame = 0;
      }
      
       
    }

    if(!counter.isCursorInsideWindow()){
      frame = 0;
    }
      
    
    fill(240);
    text(title,x+w-textW,y+h+fontSize);
    
  }
  
  void launch(){

    if(counter.checkCursorOnWindow()){
        //Increment the counter
        count++;
        Process pr;
        pr = exec(path);
        delay(30000);
        if(pr != null){
          pr.destroy();
        }
        
        myMouseX = width/2;
        myMouseY = height/2;
        nextStateStartTime = millis();
       
    }
  }

}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

class WindowCounter {

  int x,y,w,h;
  boolean isCursorOnWindow;
  int cursorEnterTime;
  int actionDelay = 4000; // 3 seconds

  WindowCounter(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    isCursorOnWindow = false;
    cursorEnterTime = -1;
  }

  boolean checkCursorOnWindow() {

    if (isCursorInsideWindow()) {
      if (!isCursorOnWindow) {
        cursorEnterTime = millis(); // Store the current time when the cursor enters the window
        isCursorOnWindow = true;
      }
    } else {
      isCursorOnWindow = false;
      cursorEnterTime = -1; // Reset the enter time when the cursor exits the window
    }

    if (isCursorOnWindow && millis() - cursorEnterTime >= actionDelay) {
      isCursorOnWindow = false;
      cursorEnterTime = -1; // Reset the enter time when the cursor exits the window
      return true;
    }
    else {
      return false;
    }
  }

  boolean isCursorInsideWindow() {
    return myMouseX > x && myMouseX < x+w && myMouseY > y && myMouseY < y+h;
  }

}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

// Text Box class
class TextBox {
  String text;
  float x, y, width, height;
  int fontSize;
  
  TextBox(String text, float x, float y, float width, float height, int fontSize) {
    this.text = text;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.fontSize = fontSize;
  }
  
  void draw() {
    pushStyle();
    textAlign(LEFT, TOP);
    textSize(fontSize);
    fill(200);
    
    // Split the text into individual words
    String[] words = text.split(" ");
    String currentLine = "";
    float lineHeight = textAscent() + textDescent();
    float currentY = y;
    
    for (String word : words) {
      // Check if the current line + the current word exceeds the width
      if (textWidth(currentLine + word) > width) {
        // Draw the current line and move to the next line
        text(currentLine, x, currentY);
        currentY += lineHeight;
        currentLine = word + " ";
      } else {
        // Add the word to the current line
        currentLine += word + " ";
      }
    }
    
    // Draw the last line of text
    text(currentLine, x, currentY);
    popStyle();
  }
}
