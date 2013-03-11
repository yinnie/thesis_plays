//this class contains all the two-dimensional shapes that we want to draw
//we use processing's innate geometry primitives but generalize the parameters so we can use them with more flexibility
//assuming all shapes drawn in a square of 300 by 300

class TShape {

  int drawType;  //the chosen shape type to draw
  int unitLength = 150;
  int startX = 50;
  int startY = 50;
  int gridSize = 300;
  float arcAngle;
  
  TShape(int _drawType) {
    //drawType = (int)random(numShapes);
    drawType = _drawType;
    arcAngle = random(PI/3, PI);
  }

 

  void render() {
    strokeWeight(12);
    switch ( drawType) {
      case (0):
      //horizontal line 
      line(startX, startY, startX+unitLength, startY);
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
      line(startX+unitLength, startY, startX, startY+unitLength);
      
      //case (4): 
      //ellipse(gridSize/2, gridSize/2, unitLength, unitLength);
      //arc(gridSize/2, gridSize/2, unitLength, unitLength, PI/4*3, -PI/6);
      //break;
      
      case (4):
      line(startX, startY, startX+unitLength, startY);
      line(startX, startY, startX, startY+unitLength);
      //line(startX+unitLength, startY, startX+unitLength, startY+unitLength);
      //rectMode(CENTER);
      //rect(gridSize/2, gridSize/2, unitLength, unitLength);
      break;
      //case (6):
      //arc(gridSize/2, gridSize/2, unitLength, unitLength, 0, PI/2);
    
      //break;
      /*
      case (7):
      ellipse(gridSize/2, gridSize/2, unitLength/2, unitLength/2);
      arc(gridSize/2, gridSize/2, unitLength, unitLength, -PI/8*3, PI/9*5);
      break; 
      case (8):
      //arc(gridSize/2, gridSize/2, unitLength, unitLength, PI/3, PI/3+arcAngle);
      arc(gridSize/2, gridSize/2, unitLength, unitLength, PI, PI/2+PI);
      break;
      case (9):
      arc(gridSize/2, gridSize/2, unitLength/2, unitLength/2, -PI/2, PI/2+PI);
      break;
      case (10):
      arc(gridSize/2, gridSize/2, unitLength, unitLength, PI/2, PI);
      break; 
     */ 
      case(5):
      line(startX, startY, startX, startY+unitLength);
      line(startX, startY+unitLength, startX+unitLength, startY+unitLength);
      break;
      case(6):
      line(startX, startY, startX, startY+unitLength);
      line(startX, startY+unitLength, startX+unitLength, startY+unitLength);
      line(startX+unitLength, startY+unitLength, startX+unitLength, startY);
      /*
      case(13):
     arc(gridSize/2, gridSize/2, unitLength, unitLength, PI/2, PI/2-arcAngle);
     break;
     case(14):
      triangle (startX-unitLength*0.35, startY+unitLength/4, startX, startY, startX+unitLength*0.3, startY+unitLength*0.5);
     break;
        case(15):
      rect(gridSize/2, gridSize/2, unitLength/3, unitLength/3);
     break;
           case(16):
           fill(0);
      ellipse(gridSize/2, gridSize/2, unitLength/4, unitLength/4);
     break;
    */
      
       
    }
  }
}

