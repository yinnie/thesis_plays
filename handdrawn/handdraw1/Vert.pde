
class Vert {
    
     PVector position;
    
     Vert() {
      position = new PVector (0, 0);
     }
     
     Vert(PVector p) {
      position = p;
     }
    
     void setPosition(PVector mPos) {
       position = mPos;
     }
     
     PVector getPosition() {
      return position;
     } 
}
