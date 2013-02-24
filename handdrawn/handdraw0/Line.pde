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
}

