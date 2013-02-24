//line made out of vertices 

class Line {

  Vert[] vertices;
  //length of the line
  float length; 
  //angle..this should be between -1 and 1. radians wise. -PI/2 and PI/2
  float angle; 
  //starting point of line 
  Vert oneEnd; 
  //total number of verts that makes up the line
  int total = 12;  

  Line (Vert p0, float _length, float _angle) {
    oneEnd = p0;
    length = _length;
    angle = _angle;
    vertices = new Vert[total];
    //construct the other vert position p1
    //vertical offset
    float yoffset = length*sin(angle); 
    //horizontal offset
    float xoffset = length*cos(angle); 
    float x1 = p0.position.x+xoffset;
    float y1 = p0.position.y+yoffset;
    Vert p1 = new Vert(new PVector(x1, y1));
    //make randomised points between p0 and p1
    for ( int i = 0; i < total; i++) {
      PVector diff = PVector.sub(p1.position, p0.position); 
      float m = _length/total;
      diff.normalize();
      PVector v = new PVector(random(-1, 2), random(-2, 1));
      diff.mult((i)*m);
      diff.add(v);
      vertices[i] = new Vert(diff);
    }
  }

  void drawline() {
    beginShape();
    strokeWeight(random(0.5, 2));
    for (int i  = 0; i < total; i++) {
      curveVertex(vertices[i].position.x+oneEnd.position.x, vertices[i].position.y+oneEnd.position.y);
    } 
    endShape();
  }
  
  int getTotalVerts() {
   return total;
  } 
}

