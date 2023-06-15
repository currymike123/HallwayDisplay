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
String path = "/home/mike/Desktop/HallwayDisplay/Exports/Jaden/linux-amd64/jaden";
String path2 = "/home/mike/Desktop/HallwayDisplay/Exports/Lara/linux-amd64/rain";

//All the window names.

String windowName = "Jaden";
String windowName2 = "Lara";

//All text strings.
String title = "Select a Project to Launch . . . ";
String jaden = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s";

//All text objects.
TextTitle t1;
TextTitle t2;

//All the preview images;
PImage img1;
PImage img2;

//All the window objects.
Window w1;
Window w2;

//Background Image.
PGraphics bg;

//Screen Size
int screenX;
int screenY;

//Mouse position
int myMouseX;
int myMouseY;

//
//////////////////////////////////////////////////////////////////////////////////////////////////////////

public void settings() {

  screenX = displayWidth-100;
  screenY = displayHeight-100;
  size(screenX,screenY); // Set the desired width and height
}

void setup(){
  //Set the cursor to a hand.
  cursor(HAND);

  //Load all the images.
  img1 = loadImage("images/Jaden.png");
  img2 = loadImage("images/Lara.png");

  //Create all the objects.
  w1 = new Window(width/4,height/4,300,300,img1,windowName,path);
  t2 = new TextTitle(width/3,height/4,jaden,30);
  w2 = new Window(width/4,height/2,300,300,img2,windowName2,path2);
  t1 = new TextTitle(width/4,height/6,title,60);

  //Create the background image to be drawn to the screen.  Calculate it once and save it as an image. 
  bg = createGraphics(width,height);
  noiseBackground();

  //Draw the background image to the screen.
  image(bg,0,0);

  //Connect to the server for the mouse position.
  c = new Client(this, "localhost", 9999);
  
  //Default mouse
  myMouseX = 0;
  myMouseY = 0;
}


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
    
    //Scaline factor
    
    //Set the mouse position to the data from the server.
    myMouseX = int(map(int(x),0,640,0,screenX));
    println(myMouseX);
    myMouseY = int(map(int(y),0,640,0,screenY));
  }

  //UI
  w1.draw();
  w2.draw();
  w1.launch();
  w2.launch();
  t1.draw();
  t2.draw();

  fill(255,0,0);
  ellipse(myMouseX,myMouseY,200,200);

  
}

float detail = 0.4;
float increment = 0.02;

void noiseBackground(){
  bg.beginDraw();

  bg.loadPixels();

  float xoff = 0.0; // Start xoff at 0
  detail = detail + random(-0.01,0.01);
  noiseDetail(5, detail);
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float bright = (noise(xoff, yoff) * 255) / 2;

      bright = map(bright,0,255,40,100);
      
      // Set each pixel onscreen to a grayscale value
      bg.pixels[x+y*width] = color(bright);
    }
  }
  
  bg.updatePixels();
  bg.endDraw();
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
    displayedText = " ";
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
        println("Opening");
        exec(path);
        delay(30000);
        mouseX = width/2;
        mouseY = height/2;
    }
  }

}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

class WindowCounter {

  int x,y,w,h;
  boolean isCursorOnWindow;
  int cursorEnterTime;
  int actionDelay = 3000; // 3 seconds

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
