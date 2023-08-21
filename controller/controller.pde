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
String path = "/home/display/Desktop/HallwayDisplay/Exports/Jaden/linux-amd64/jaden";
String path2 = "/home/display/Desktop/HallwayDisplay//Exports/Lara/linux-amd64/rain";
String path3 = "/home/display/Desktop/HallwayDisplay/Exports/Kevin/linux-amd64/Santorelli_Project";
String path4 = "/home/display/Desktop/HallwayDisplay/Exports/Ethan/linux-amd64/Ethan";
String path5 = "/home/display/Desktop/HallwayDisplay/Exports/Michelle/linux-amd64/Michelle";

//All the window names.

String windowName = "Jaden Daniels";
String windowName2 = "Lara Palombi";
String windowName3 = "Kevin Santorelli";
String windowName4 = "Ethan McDermott";
String windowName5 = "Michelle Hasbun";

//All text strings.
String findHand = "Hold one hand up. .  . The other hand behind your back. . . Keep only one hand in the frame. . ."; 
String handSearch = "Searching for a hand (just one). . .";
String title = "Select a Project to Launch . . . ";
String jaden = "Jaden Daniels invites the user to create a sketch by moving rectangles around a screen and changing there color when your hand intersects a rectangle's path.";
String lara = "Lara Palombi creates a rain simulation for the user to explore.  Move the umbrella around the screen to stay dry and watch the light change from day to night.";
String kevin = "Kevin Santorelli built a project referencing early atari games such as Space Invaders.  Move the space ship and destory the alien invaders!";
String ethan = "Ethan McDermott creates a rotating world of gradient strands.  Move your hand left to right to increase and decrease the speed of the rotation.";
String michelle = "Michelle Hasbun designs a traditional Pong game infused with psychedelic elemnts.  Use your hand to move the paddle.";

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

//Preview images.
PImage img1;
PImage img2;
PImage img3;
PImage img4;
PImage img5;

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

//
//////////////////////////////////////////////////////////////////////////////////////////////////////////

public void settings() {

  screenX = displayWidth;
  screenY = displayHeight;
  size(screenX,screenY, P2D); // Set the desired width and height
}

void setup(){

  //Load all the images.
  img1 = loadImage("images/Jaden.png");
  img2 = loadImage("images/Lara.png");
  img3 = loadImage("images/Kevin.png");
  img4 = loadImage("images/Ethan.png");
  img5 = loadImage("images/Michelle.png");

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
  handSearching = new TextTitle(width/2-605,1480,handSearch,60);

  //Title
  t1 = new TextTitle(width/5,height/6,title,60);

  //Jaden's Project
  w1 = new Window(width/5,height/4,300,300,img1,windowName,path);
  jadenText = new TextBox(jaden,width/3.5,height/4,800,w1.h,30);
  //t2 = new TextTitle(width/3,height/4,jaden,30);

  //Lara's Project
  w2 = new Window(width/5,height/4 + 400 ,300,300,img2,windowName2,path2);
  laraText = new TextBox(lara,width/3.5,height/4 + 400,800,w2.h,30);
  
  //Kevin's Project
  w3 = new Window(width/5,height/4 + 800,300,300,img3,windowName3,path3);
  kevinText = new TextBox(kevin,width/3.5,height/4 + 800,800,w3.h,30);
  
  //Ethan's Project
  w4 = new Window(int(width/1.85),height/4,300,300,img4,windowName4,path4);
  ethanText = new TextBox(ethan,width/1.6,height/4,800,w4.h,30);
  
  //Michelle's Project
  w5 = new Window(int(width/1.85),height/4 + 400,300,300,img5,windowName5,path5);
  michelleText = new TextBox(michelle,width/1.6,height/4+400,800,w5.h,30);
 
 

  //Create the background image to be drawn to the screen.  Calculate it once and save it as an image. 
  bg = createGraphics(width,height);
  noiseBackground();

  //Draw the background image to the screen.
  image(bg,0,0);

  //Connect to the server for the mouse position.
  c = new Client(this, "localhost", 9999);
  
  //Default mouse
  myMouseX = width/2+300;
  myMouseY = height/2;
}

// Are there multiple hands on screen.
int multipleHands = 0;
int returnCount = 0;
int count = 0;

void draw(){
  
  //Draw the image to the screen.
  image(bg,0,0);
  

  //Get the data from the server.
  if (c.available() > 0) {
    // read the data from the client
    data = c.readString();
    
    String[] xy = split(data, ',');
    
    float x = float(xy[0]);
    float y = float(xy[1]);
    multipleHands = int(xy[2]);
    print(multipleHands);
    //Scaline factor
    
    //Set the mouse position to the data from the server.
    myMouseX = int(map(int(x),0,640,0,screenX));
    myMouseY = int(map(int(y),0,480,0,screenY));
  }


  
  if(frameCount>600  && multipleHands == 1){
    //UI
    
    //Check to see if the apps should launch
    w1.launch();
    w2.launch();
    w3.launch();
    w4.launch();
    w5.launch();

    //Draw the windows.
    w1.draw();
    w2.draw();
    w3.draw();
    w4.draw();
    w5.draw();

    //Draw the text.
    t1.draw();
    jadenText.draw();
    laraText.draw();
    kevinText.draw();
    ethanText.draw();
    michelleText.draw();
    //t2.draw();
  }else if(multipleHands == 0){
    returnCount++;
  }else if(multipleHands == 0 && returnCount == 600){
    fill(80,170,220,50);
    noStroke();
    rectMode(CENTER);
    rect(width/2,height/2,1300,1500);
    rectMode(CORNER);
    textSize(170);
    fill(160);
    text("Computational",width/2-605,495);
    text("Media",width/2+140,640);
    textSize(50);
    text("(1) Hold one hand up.",width/2-605,1620);
    text("(2) The other behind your back.",width/2-605,1700);
    text("(3) Keep only one hand in the frame.",width/2-605,1780);

    shape(hand,width/2+350,height/2,hand.width/2,hand.height/2);
    
    // text("Media",width/2-605,1710);
    
    //Check for hand control.  Hand detection is only seeing one hand.  It will take you through the sequence of putting your hand behind your back.
    shapeMode(CENTER);
    if(count<60){
      
      shape(hand1,width/2-200,height/2-60);
      count++;
    }else if(count>=60 && count<120){
      shape(hand2,width/2-200,height/2-60);
      count++;
    }else if(count>=120 && count<180){
      shape(hand3,width/2-200,height/2-60);
      count++;
    }else{
      count = 0;
    }

    //fill(180);
    //handText.draw();
    handSearching.draw();
    //print(handSearching.x);
  }

  shape(hand,myMouseX,myMouseY,hand.width/2,hand.height/2); 
  
  if(w1.counter.checkCursorOnWindow()){
    image(bg,0,0);
    
    delay(30000);
  }
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
    fontSize = 22;;
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
        exec(path);
        delay(30000);
       
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
