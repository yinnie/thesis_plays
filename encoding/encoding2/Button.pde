

class Button {
  
  float rectX, rectY;      // Position of square button
  int rectw,recth;     // Diameter of rect
  boolean rectOver;
  
  
  Button(float locx, float locy) {
    rectX = locx;
    rectY = locy;
    rectw = 160;
    recth = 40;
    rectOver = false;
    
  }
  
  boolean overRect()  {
  if (mouseX >= rectX && mouseX <= rectX+rectw && 
      mouseY >= rectY && mouseY <= rectY+recth) {
        rectOver = true;
    return true;
  } else {
    rectOver = false;
    return false;
  }
 }
 
 void render() {
   noStroke();
     fill(200); 
   rect(rectX, rectY, rectw, recth);
 }
  
  
  
 
  
}
