float increment = 0.02;

//All the paths to the applications.
String path = "/home/mike/Desktop/CompMedia/Exports/Jaden/linux-amd64/jaden";

//All the window names.
String windowName = "Jaden";

//All the preview images;
PImage img1;

//All the window objects.
Window w1;

void setup(){
  size(1000,1000);
  frameRate(60);
  img1 = loadImage("images/Jaden.png");
  w1 = new Window(100,100,200,200,img1,windowName,path);
  noiseBackground();
}

void draw(){
  noiseBackground();
  w1.draw();
  w1.launch();
}


void noiseBackground(){
   loadPixels();

  float xoff = 0.0; // Start xoff at 0
  float detail = random(.1,.7);
  noiseDetail(8, detail);
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float bright = (noise(xoff, yoff) * 255) / 2;

      bright = map(bright,0,255,40,50);
      
      // Set each pixel onscreen to a grayscale value
      pixels[x+y*width] = color(bright);
    }
  }
  
  updatePixels();
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
      
      if(frame < 18){
        noFill();
        stroke(80 - frame);
        strokeWeight(frame*2);
        rect(x-frame,y-frame,w+frame*2,h+frame*2);
        if(frameCount%4 == 0){
          frame++;
        }
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


