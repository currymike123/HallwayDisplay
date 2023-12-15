class Strand {
  SquareRot[] column; //array to hold all the squares
  PVector location; //location to place the array
  PVector addPos;

  //Constructor
  Strand(PVector posL) {
    location= posL;
    column=new SquareRot[35];
    addPos = new PVector(6, 10);
    PVector tempLocation = location.copy();
    color c1 = color(0, 0, 0);
    color c2 = color(250, 250, 250);
    for (int i=0; i<column.length; i++) {
      float count = i;
      float count2 = i;
      float step = count/column.length;
      float step2 = count2/column.length;
      color c = lerpColor(c1, c2, step);
      float x= lerp(100, 50, step2);
      column[i] = new SquareRot(tempLocation.copy(), c, x);
      tempLocation.add(addPos);
    }
  }
  //display stuff function
  void display() {
    for (int i=0; i<column.length; i++) {
      column[i].display();
    }
  }
}
