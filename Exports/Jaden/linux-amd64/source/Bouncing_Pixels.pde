
//Array of pixel objects
square[] arrsquare;
 
//Number variable.
int num = 15;

void setup(){
  size(800,700);
  background(40);
  smooth();
  rectMode(CENTER);
  
//Set the size of the array.
  arrsquare = new square[num];
  
//Use a loop to create instances of square object
  for(int i = 0; i < arrsquare.length; i++){
    arrsquare[i] = new square();
  }
}

void draw(){
//Array of pixels -- Update, Collide, Display
  for(int i = 0; i < arrsquare.length; i++){
    
    arrsquare[i].moveAwayFromCursor(mouseX, mouseY);
    
//Update pixel location
    arrsquare[i].update();
    
//Check if they have collided with the walls
    arrsquare[i].collide();
    
    if(mousePressed){
       float distance = dist(arrsquare[i].location.x, arrsquare[i].location.y, mouseX, mouseY); 
        if(distance < arrsquare[i].size){
          arrsquare[i].rgb = color(255,255,255,30);
        }
    }
    
//Check if the current pixel is touching all the other pixels
    for(int n = 0; n < arrsquare.length; n++){
//Calculate the distance between pixels
        float distance = dist(arrsquare[i].location.x, arrsquare[i].location.y, arrsquare[n].location.x,arrsquare[n].location.y); 
        
//If distance from one pixel to every other pixel is < the the pixel's radius, they are touching
        if(i != n && (distance < arrsquare[i].size/2 + arrsquare[n].size/2)){
          
//Change the alpha of the pixels
           arrsquare[i].highlight();
           arrsquare[n].highlight();
        }
     }
     arrsquare[i].display();
   }
   checktime();
}


void checktime(){
   println(frameCount/frameRate);
  if(int(frameCount/frameRate) == 30){
   
    exit();
  }
  
}
