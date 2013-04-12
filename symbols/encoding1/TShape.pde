//this class contains all the two-dimensional shapes that we want to draw
//we use processing's innate geometry primitives but generalize the parameters so we can use them with more flexibility
//assuming all shapes drawn in a square of 300 by 300


//strokes class
//in a square of 200x200, all strokes start at (0, 0) unless there is an offset

class TShape {

  int drawType;  //the chosen shape type to draw
  int l = 200;  // this is grid size
  
  TShape(int _drawType) {
    drawType = _drawType;
  }

  void render() {
    strokeWeight(12);
    switch ( drawType) {
      case (0):
      //vertical line on left edge of the block
      line(0, 0, 0, l);
      break;
      case (1):
      // a line half size of case 0 and in the middle of the square
      line(l*0.5, l*0.5, 0*0.5, l);
      break;
      case (2):
      //diagnol bottom left corner to right up corner
      line(0, l, l, 0);
      break;
      case (3):
      //diagnol half size of case 2
      line(0, l, l*0.5, l*0.5);
      case (4): 
      //diagnol top left corner to bottom right corner
      line(0, 0, l, l);
      break;
      case (5):
      //diagnol half size of case 4
      line(0, 0, l*0.5, l*0.5);
      break;
      case (6):
      //diagnol half size of case 4 but starting at second half of the block
       line(0, l*0.5, l*0.5, l);
      break;
      case (7):
      // looks like this / but only at top left quadrant of the block
      line(0, l*0.5, l*0.5, 0);
      break; 
      case (8):
      //a quarter of an arc at top left quadrant
      arc(0, l/2, l/2, l/2, PI*1.5, TWO_PI);
      break;
      case (9):
      arc(0, l/2, l/2, l/2, 0, HALF_PI);
      break;
      case (10):
      arc(l/2, l/2, l/2, l/2, PI, PI*1.5);
      break;  
      case(11):
      arc(l/2, l/2, l/2, l/2, PI*0.5, PI);
      break;
      case(12):
      // a line half size of case 0 and on the right edge of the block
      line(l, l*0.5, l, l);
      case(13):
      //horizontal line
      line(0, 0, l, 0);
     break;
     case(14):
     // a line half size of case 13
     line(0, 0, l*0.5, 0);
     break;
     case(15):
      fill(0);
      ellipse(l*0.75, l*0.25, l/4, l/4);
     break; 
     case(16):
      fill(0);
      ellipse(l*0.75, l*0.75, l/4, l/4);
     break;        
    }
  }
}

