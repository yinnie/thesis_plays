//line made out of vertices 

class Line {

  Vert[] vertices;
  //length of the line
  float length; 
  //angle..this should be between -1 and 1. radians wise. -PI/2 and PI/2
  float angle; 
  //starting point of line 
  Vert oneEnd; 
  Vert otherEnd;
  //total number of verts that makes up the line
  int total;  
  //strokeweight
  float strokeweight;

  Line (Vert p0, float _length, float _angle) {    
    oneEnd = p0;
    otherEnd = p0;
    length = _length;
    angle = _angle;
    total = 4;
    vertices = new Vert[total]; 
    strokeweight = 1.0; 
    
    createline();
  }
  
  void createline() {

     strokeweight = random(0.5, 5);
     //construct the other vert position p1
    //vertical offset
    float yoffset = length*sin(angle); 
    //horizontal offset
    float xoffset = length*cos(angle); 
    float x1 = oneEnd.position.x+xoffset;
    float y1 = oneEnd.position.y+yoffset;
    Vert p1 = new Vert(new PVector(x1, y1));
    otherEnd = p1;
    //make randomised points between p0 and p1
    for ( int i = 0; i < total; i++) {
      PVector diff = PVector.sub(otherEnd.position, oneEnd.position); 
      float m = length/total;
      diff.normalize();
      PVector v = new PVector(random(-0.5, 0.5), random(-0.5, 0.7));
      diff.mult((i)*m);
      diff.add(v);
      vertices[i] = new Vert(diff);
    }    
  }
  
  void drawline() {
    
    beginShape();
    strokeWeight(strokeweight);
    curveVertex(vertices[0].position.x+oneEnd.position.x, vertices[0].position.y+oneEnd.position.y);
    for (int i  = 0; i < total; i++) {
      curveVertex(vertices[i].position.x+oneEnd.position.x, vertices[i].position.y+oneEnd.position.y);
    } 
     curveVertex(vertices[total-1].position.x+oneEnd.position.x, vertices[total-1].position.y+oneEnd.position.y);
    endShape();
  }
  void setAngle(float a) {
    angle = a;
  }
  void setLength(float m) {
    length = m;
  }
  void setOneEnd(Vert v) {
    oneEnd = v;
  }
  int getTotalVerts() {
   return total;
  } 
  
  Vert getOtherEnd() {
    return otherEnd;
  }
  void setOtherEnd(Vert o) {
    otherEnd = o;
  }
}

