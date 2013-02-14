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
  Line line1;
  
  TShape(int _drawType) {
    //drawType = (int)random(numShapes);
    drawType = _drawType;
    arcAngle = random(PI/3, PI);
    line1 = new Line();
  }

  void setShapes() {
        Vert v1 = new Vert(new PVector(startX, startY));
    Vert v2 = new Vert(new PVector(startX+unitLength, startY));
      line1.setPoints(v1,v2);
  }
  void render() {
    strokeWeight(12);
    switch ( drawType) {
      case (0):
      //horizontal line 
   
      line1.drawline();
      break;
      
      /*
      case (1):
      //vertical line 
       Line line1 = new Line(gridSize/2, startY, gridSize/2, startY+unitLength);
         line1.drawline();
      break;
      case (2):
      //diagnol 1
       Line line1 = new Line(startX, startY, startX+unitLength, startY+unitLength);
      line1.drawline();
      break;
      case (3):
      //diagnol 2
       Line line1 = new Line(startX+unitLength, startY, startX, startY+unitLength);
      line1.drawline();
      case (4): 
       Line line1 = new Line(gridSize/2, gridSize/2, unitLength, unitLength);
       line1.drawline();
      //arc(gridSize/2, gridSize/2, unitLength, unitLength, PI/4*3, -PI/6);
      break;
      case (5):
       Line line1 = new Line(startX, startY, startX+unitLength, startY);
       Line line2 = new Line(startX, startY, startX, startY+unitLength);
       line1.drawline();
       line2.drawline();
      //line(startX+unitLength, startY, startX+unitLength, startY+unitLength);
      //rectMode(CENTER);
      //rect(gridSize/2, gridSize/2, unitLength, unitLength);
      break;
      case (6):
       Line line1 = new Line(startX, startY, startX, startY+unitLength);
       Line line2 = new Line(startX, startY+unitLength, startX+unitLength, startY+unitLength);
       Line line3 = new Line(startX+unitLength, startY+unitLength, startX+unitLength, startY);
         line1.drawline();
       line2.drawline();
       line3.drawline();
      break;
      case (7):
       Line line1 = new Line(startX, startY, startX, startY+unitLength);
       Line line2 = new Line(startX, startY+unitLength, startX+unitLength, startY+unitLength);
         line1.drawline();
       line2.drawline();
      //arc(gridSize/2, gridSize/2, unitLength, unitLength, -PI/8*3, PI/9*5);
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
      case(11):
     ellipse(gridSize/2, gridSize/2, unitLength/2, unitLength/2);
      break;
      case(12):
      arc(gridSize/2, gridSize/2, unitLength, unitLength, 0, PI/2);
      case(13):
     arc(gridSize/2, gridSize/2, unitLength, unitLength, PI/2, PI/2-arcAngle);
     break;
    
       */
    }
  }
}

