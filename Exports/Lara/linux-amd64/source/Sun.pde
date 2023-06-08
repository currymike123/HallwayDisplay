class Sun{
  
  float r; 
  float theta; 
  PVector location; 
  PVector velocity; 
  float add; 
  
  
  Sun(PVector l, PVector v){
    location = l; 
    velocity = v; 
    theta = PI/2; 
    add = PI/800; 
  }
  
  void run(){
    update(); 
    display(); 
  }
  
  void update(){
    if(theta<=2*PI && theta>=PI/2){
      theta+=add; 
    } 
    if(theta>=2*PI || theta<=PI/2){
      add*=-1; 
      theta+=add; 
    }
    println(theta);
    float fadeR = map(theta, PI-(PI/6), 2*PI, 20, 197); 
    float fadeG = map(theta, PI-(PI/6), 2*PI, 40, 215);
    float fadeB = map(theta, PI-(PI/6), 2*PI, 74, 215);
    if(mousePressed==true){
      background(#EDFFFF);
    }else{
      background(fadeR, fadeG, fadeB);
    }
    
  }
  
  void display(){
    float alpha = 255; 
      noFill(); 
      strokeWeight(2); 
    for(int i = 0; i<350; i+=10){
      stroke(#ff9d00, alpha); 
      ellipse(location.x+(1000*cos(theta)), location.y+(1000*sin(theta)), i, i);
      alpha-=6; 
    }
    noStroke(); 
  }
  


}
