//strokes class
//in a square of 200x200, all strokes start at (0, 0) unless there is an offset

class TShape {

  int drawType;  //the chosen shape type to draw
  int l = 200;  // this is grid size
  int totalStrokes = 9;
  Line mline; //create the Line object
   
  TShape(int _drawType) {
    drawType = _drawType;
    mline = new Line();
  }
  
  TShape () {
    drawType = 100;
    //initiate mline object
    mline = new Line();
  }
  
  void setDrawType( int n) {
    drawType = n;
  }
  
  void render(PGraphics g) {

    switch ( drawType) {
      case (0):
      //vertical line on left edge of the block
      //new code when the line class is finished...psedo code
      mline.drawline(g, 0, 0, 0, l);
      //g.line(0, 0, 0, l);
      break; 
      case (1):
      //diagnol half size of (diagnol bottom left corner to right up corner)
      mline.drawline(g, 0, l, l*0.5, l*0.5);
      //g.line(0, l, l*0.5, l*0.5);
      case (2): 
      //diagnol top left corner to bottom right corner
      mline.drawline(g, 0, 0, l, l);
      //g.line(0, 0, l, l);
      break;    
      case (3):
      //diagnol half size of (diagnol top left corner to bottom right corner) but starting at second half of the block
      mline.drawline(g, l/2, 0, l, l/2);
      //g.line(l/2, 0, l, l/2);
      break;   
      case (4):
      g.arc(l/2, l/2, l/2, l/2, PI, PI*1.5);
      break;  
      case(5):
      g.arc(l/2, l/2, l/2, l/2, 0, PI*0.5);
      break; 
      case(6):
      //horizontal line
      mline.drawline(g, 0, 0, l, 0);
      //g.line(0, 0, l, 0);
     break; 
      case(7):
      // two lines half size of case 0 and on the right edge of the block
      mline.drawline(g, l, l*0.5, l, l);
      mline.drawline(g, l/2, l, l, l);
      //g.line(l, l*0.5, l, l);
      //g.line(l/2, l, l, l);
     break;
     case(8):
      g.fill(0);
      g.ellipse(l*0.75, l*0.75, l/4, l/4);
     break; 
      case (9):
      //a quarter of an arc at top left quadrant
      g.arc(l/2, l/2, l, l, PI*1.5, TWO_PI);
      break;
     case (10):
      // a line half size of case 0 and in the middle of the square
      g.line(l*0.5, l*0.5, l*0.5, l);
      break;
     case (11):
      //diagnol bottom left corner to right up corner
      g.line(0, l, l, 0);
      break;
       case (12):
      //diagnol half size of diagnol top left corner to bottom right corner
      g.line(0, 0, l*0.5, l*0.5);
      break;
       case (13):
      // looks like this / but only at top left quadrant of the block
      g.line(0, l*0.5, l*0.5, 0);
      break;
      case (14):
      g.arc(0, l/2, l/2, l/2, 0, HALF_PI);
      break;
 
       case(15):
     // a line half size of case 13
     g.line(0, 0, l*0.5, 0);
     break;
     case(16):
      g.fill(0);
      g.ellipse(l*0.75, l*0.25, l/4, l/4);
     break; 
     default:
     println(" no shape to draw");
     break;
     
    }
    
  }
}

