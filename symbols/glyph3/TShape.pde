//this class contains all the two-dimensional shapes that we want to draw
//we use processing's innate geometry primitives but generalize the parameters so we can use them with more flexibility
//assuming all shapes drawn in a square of 300 by 300

class TShape {
  
  int drawType;  //the chosen shape type to draw
  int numShapes = 11; //number of types
  int unitLength = 120;
  float arcAngle;
  int startX = 25;
  int startY = 25;
  int gridSize = 400;
  
  TShape(int _drawType) {
     //drawType = (int)random(numShapes);
     drawType = _drawType;
     arcAngle = random(-PI*2, PI*2);
  }
  
  void clear() {
    noStroke();
    fill(255);
    rect(0, 0, gridSize, gridSize);
  }
  
  void render() {
   
    switch ( drawType) {
      case (0):
      //horizontal line 
      line(startX, gridSize/2, startX+unitLength, gridSize/2);
      break;
      case (1):
      //vertical line 
      line(gridSize/2, startY, gridSize/2, startY+unitLength);
      break;
      case (2):
      //diagnol 1
      line(startX, startY, startX+unitLength, startY+unitLength);
      break;
      case (3):
      //diagnol 2
      line(startX+unitLength, startY+unitLength, startX+unitLength, startY);
      case (4): 
      ellipse(gridSize/2, gridSize/2, unitLength, unitLength);
      break;
      case (5):
      rectMode(CENTER);
      rect(gridSize/2, gridSize/2, unitLength, unitLength);
      break;
      case (6):
      arc(gridSize/2, gridSize/2, unitLength, unitLength, arcAngle, arcAngle+PI/2);
      break;
      case (7):
      ellipse(gridSize/2, gridSize/2, unitLength/2, unitLength/2);
      break; 
      case (8):
      arc(gridSize/2, gridSize/2, unitLength, unitLength, arcAngle, arcAngle-PI/2);
      break;
      case (9):
      arc(gridSize/2, gridSize/2, unitLength, unitLength, 0, PI/2);
      break;
       case (10):
      arc(gridSize/2, gridSize/2, unitLength, unitLength, 0, -PI/2);
      break;
    
    }
  }
  
}
