class npCharacter {
  PFont myFont;
  float x;
  float y;
  float width;
  float height;
  float speed;
  PImage image;
  boolean isTextActive = false;
  String[] dialogues = {
    "Wow, This rain just never ends!",
    "I wish my mom picked me up!",
    "I'm terrified of lightning!!",
    "Ugh this umbrella has holes in it!!"
    //"This rain taste like the rainbow?!!",
    //"I told my mom not to pick me up!",
    //"I'm terrified of lightning!!",
    //"Is this rain Skittles?!!",
  };
  int currentDialogueIndex = 0;
  String currentDialogue = dialogues[currentDialogueIndex];
  boolean hasCrossedMouseX = false;
  int dialogueChangeDelay = 120; // Adjust the delay in frames
  npCharacter(float width, float height, float speed, PImage image) {
    this.x = random(0, width); // 
    this.y = 980; // Fixed y-coordinate of character
    this.width = width;
    this.height = height;
    this.speed = 2;
    this.image = image;
    smooth();
  }
  void update() { 
    x = x + speed;// Update the x-coordinate based on the speed
    if (x > 1920 || x < 0) {
      speed *= -1; // Move the ball to the left edge to repeat
    }
  }
  void checkMousePosition() {
    float mouseDistance = abs(myMouseX - x);
    if (mouseDistance < 150) { // React when the character is close to the mouse
      showText(); // Show the popup
    } else {
    }
  }
  void showText() {
    fill(255); // Black text
    textSize(17);
    textAlign(CENTER);
    text(dialogues[currentDialogueIndex], x + 140, y - 10);
    isTextActive = true;
    if (frameCount % dialogueChangeDelay == 0) {
      // Increment the dialogue index for the next time
      currentDialogueIndex = (currentDialogueIndex + 1) % dialogues.length;
      // Update the current dialogue
      currentDialogue = dialogues[currentDialogueIndex];
    }
  }
  void display() {
    image(image, x, y, width, height);
    if (isTextActive) {
      int popupDuration = 240; // 2 seconds - 60 frames per second
      if (frameCount % popupDuration == 0) {
        isTextActive = false;
      }
    }
  }
}
