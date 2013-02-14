//line made out of vertices 

class Line {

  Vert[] vertices;
  Vert oneEnd;
  Vert otherEnd;
  int total = 12;  //total number of verts

  Line (Vert p1, Vert p2) {
    oneEnd = p1;
    otherEnd = p2;
    vertices = new Vert[total];  

    for ( int i = 0; i < total; i++) {

      PVector diff = PVector.sub(p2.position, p1.position); 
      float m = diff.mag()/total;
      diff.normalize();
      PVector v = new PVector(random(-2, 2), random(-2, 2));
      diff.mult((i)*m);
      diff.add(v);
      vertices[i] = new Vert(diff);
    }
  }
  
  Line() {
    oneEnd = new Vert(new PVector (0, 0));
    otherEnd = new Vert(new PVector (0, 0));
    vertices = new Vert[total]; 
     for ( int i = 0; i < total; i++) {
       vertices[i] = new Vert();
     }
  }

  void drawline() {
    beginShape();
    for (int i  = 0; i < total; i++) {
      curveVertex(vertices[i].position.x+oneEnd.position.x, vertices[i].position.y+oneEnd.position.y);
    } 
    endShape();
  }
  
  void setPoints(Vert v1, Vert v2) {
    oneEnd = v1;
    otherEnd = v2;
  }
  
}

