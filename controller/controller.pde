// Hallway Display
// Michael Curry, 2023

//////////////////////////////////////////////////////////////////////////////////////////////////////////

//All the paths to the applications.
String path = "/home/mike/Desktop/HallwayDisplay/Exports/Jaden/linux-amd64/jaden";
String path2 = "/home/mike/Desktop/HallwayDisplay/Exports/Lara/linux-amd64/rain";

//All the window names.
String title = "Select a Project to Launch . . . ";
String displayedText = "";
String windowName = "Jaden";
String windowName2 = "Lara";

//All the preview images;
PImage img1;
PImage img2;

//All the window objects.
Window w1;
Window w2;

//Background Image.
PGraphics bg;

//////////////////////////////////////////////////////////////////////////////////////////////////////////

public void settings() {
  size(displayWidth-100,displayHeight-100); // Set the desired width and height
}

void setup(){
  frameRate(60);
  cursor(HAND);
  img1 = loadImage("images/Jaden.png");
  img2 = loadImage("images/Lara.png");
  w1 = new Window(width/4,height/4,300,300,img1,windowName,path);
  w2 = new Window(width/4,height/2,300,300,img2,windowName2,path2);
  bg = createGraphics(width,height);
  noiseBackground();
}

int currentIndex = 0;

void draw(){
  image(bg,0,0);
  w1.draw();
  w2.draw();
  w1.launch();
  w2.launch();

   // Reveal characters one by one
  if (currentIndex < title.length() && frameCount % 8 == 0) {
   
    // Append the next character to the displayed text
    displayedText += title.charAt(currentIndex);
    currentIndex++;
  }

  if(currentIndex  == title.length() && frameCount % 100 == 0){
    displayedText = " ";
    currentIndex = 0;
  }
  
  // Display the text on the screen
  textSize(50);
  text(displayedText, width/4, 100);

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
      return true;
    }
    else {
      return false;
    }
  }

  boolean isCursorInsideWindow() {
    return mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h;
  }

}

//////////////////////////////////////////////////////////////////////////////////////////////////////////


