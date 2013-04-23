//given two points, calculate the points between thse two points that are randomized
//recontruct line to have a constructor with a pgraphics object. 

class Line {

  PVector[] vertices; //the array of points that make up our line
  int numPoints;
  float x1, y1, x2, y2; // vertices for the two ends of a line
  int randomfactor;
  
  Line () {    
    //assume two random points for constructor
    numPoints = 20;
    vertices = new PVector[numPoints];
    x1 = 0;
    x2 = 0;
    y1 = 0;
    y2 = 0; 
    randomfactor = 100;
    for ( int i = 0; i < numPoints; i++) {
      vertices[i] = new PVector(0, 0);
    }
  }
  
  void updateLine() {
     //creating the line means filling up the array with points
     //calculate the difference between two points
     PVector p1 = new PVector(x1, y1);
     PVector p2 = new PVector (x2, y2);
     PVector diff = PVector.sub(p2, p1);
     diff.normalize();
     println( " diff normalized is " + diff);
     //calculate length of the line
     float d = dist ( x1, y1, x2, y2);
    // println("distance is " + d);
     //calcualte unit offset
     float m = d/numPoints;
     //println("m is " + m);
     
     //so that we dont constantly update in draw loop
     randomSeed(randomfactor);
     
    //make randomised points between p0 and p1
    for ( int i = 0; i < numPoints; i++) {
      PVector vec = new PVector(0, 0);
      vec.set(diff);
      PVector v = new PVector(random(-1, 1), random(-1, 1));
      vec.mult((i)*m);
      vec.add(v);
      vec.add(new PVector(x1, y1));
      vertices[i].set(vec);
     // println("vertices[i] is " + vertices[i]);
    }    
  }
  
  void drawline(PGraphics _g, float _x1, float _y1, float _x2, float _y2) {
    
    x1 = _x1;
    y1 = _y1; 
    x2 = _x2;
    y2 = _y2;
    
   updateLine();
   println("random factor is " + randomfactor);
   _g.background(0);
    _g.stroke(255);
    _g.strokeWeight(12);

    _g.beginShape();
    _g.curveVertex(vertices[0].x, vertices[0].y);
    for (int i  = 0; i < numPoints; i++) {
      _g.curveVertex(vertices[i].x, vertices[i].y);
    } 
    _g.curveVertex(vertices[numPoints-1].x, vertices[numPoints-1].y);
    _g.endShape();
 
  }

}

