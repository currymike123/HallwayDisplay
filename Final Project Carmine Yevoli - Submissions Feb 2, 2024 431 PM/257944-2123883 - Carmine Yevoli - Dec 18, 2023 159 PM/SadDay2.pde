import processing.sound.*;
import processing.net.*;

//Global Variables

//Variables for the server.
Client c;
String data;
float myMouseY = -100;
float myMouseX = -100;
SoundFile thunderSound;
SoundFile rainSound;
PImage character;
PImage characterImage; // Add a new image for floating behind the circle
PImage characterImage2;
PImage backgroundImg;
PImage backgroundImg2;
boolean useBackgroundImg = true;
rainDrop[] drops;
color backgroundColor = color(12, 60); // Initial background color
float characterRadius = 36.5; // adjust the radius of umbrella getting hit with droplets
PImage cloudImage;
clouds[] clouds;
int numclouds = 20; // Adjust the number of clouds as needed
npCharacter[] character2; // second character moving back & forth
void setup() {
  size(1920, 1080,P3D);
  smooth();
  noStroke();
  frameRate(60);
  cloudImage = loadImage("image.png");
  character = loadImage("character1.png"); 
  characterImage = loadImage("character1.png");
  characterImage2 = loadImage("character3.png");
  backgroundImg = loadImage("Background2.png");
  backgroundImg2 = loadImage("Background1.png");
  thunderSound = new SoundFile(this, "Thunder.wav");
  rainSound = new SoundFile(this, "rain-03.wav"); 
  rainSound.loop();
  drops = new rainDrop[300];
  
  for (int i = 0; i < drops.length; i++) {
    drops[i] = new rainDrop();
  }
  clouds = new clouds[numclouds];
  for (int i = 0; i < numclouds; i++) {
    clouds[i] = new clouds(cloudImage.width, cloudImage.height, random(1, 8), cloudImage);
  }
  character2 = new npCharacter[1];
  for (int i = 0; i < 1; i++) {
    character2[i] = new npCharacter(characterImage2.width,characterImage2.height, 1 ,characterImage2);
  }
   //Connect to the server for the mouse position.
  c = new Client(this, "localhost", 9999);
}
void draw() {
  
  if (c.available() > 0) {
    // read the data from the client
    data = c.readString();
    //Split the msg.
    String[] xy = split(data, ',');
   
    float x = float(xy[0]);
    float y  = float(xy[1]);
   
    //Set the mouse position to the data from the server.
    myMouseX = int(map(int(x),0,640,0,width));
    myMouseY = int(map(int(y),0,480,0,height));
  }
  
  background(backgroundColor); 
  if (useBackgroundImg) {
    image(backgroundImg, 960, 540);
  } else {
    image(backgroundImg2, 960, 540);
  }
  noCursor();
  //Rainfall
  for (int i = 0; i < drops.length; i++) {
    drops[i].fall();
    drops[i].checkCharacter();
    drops[i].display();
  }
  //Cloud movement
  for (int i = 0; i < numclouds; i++) {
    clouds[i].update();
    clouds[i].display();
  }
  // Call the character function to draw the transparent circle and the floating image
  drawTransparentCircle();
  drawFloatingImage();
  // NPC movement
  for (int i = 0; i < 1; i++) {
    character2[i].update();
    character2[i].checkMousePosition();
    character2[i].display();
  }
}
//Used for Main character Movement and Reflection of raindrops from umbrella
void drawTransparentCircle() {
  float circleX = myMouseY;
  float circleY = height - character.height + characterRadius; // Adjusted for the radius
  fill(255,0); 
  ellipse(circleX, circleY, characterRadius * 2, characterRadius * 2);
}
void drawFloatingImage() {
  float imageX = myMouseX;
  float imageY = height - character.height;
  imageMode(CENTER);
  image(characterImage, imageX, imageY);
}
// Key Presses for Lightning and Thunder
void keyPressed() {
  if (key == 'L' || key == 'l') {
    backgroundColor = color(255); 
    useBackgroundImg = true; 
    thunderSound.play();
    character2[0].speed = 5;
  }
}
void keyReleased() {
  if (key == 'L' || key == 'l') {
    backgroundColor = color(12, 60); 
    useBackgroundImg = false; 
    character2[0].speed = 2;
  }
}
