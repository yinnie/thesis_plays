
class Figure {

  Lim head;

  PVector mscale;
  PVector mlocation;
  //only consider 2d rotation for now
  float mrotation;

  Figure(PVector p) {
    head = new Lim(p);
    mscale = new PVector(1.0, 1.0);
    mlocation = new PVector(0.0, 0.0);
    mrotation = 0.0;
  }

  void render() {
    pushMatrix();
    translate(mlocation.x, mlocation.y);
    scale(mscale.x, mscale.y);
    rotate(radians(mrotation));
    head.render();
    if (head.haschildren) {
      int numChildren = head.children.size();
      for ( int i=0; i < numChildren; i++) {
        head.children.get(i).draw();
      }
    }
    popMatrix();
  }

  void generate() {
    clear();  
    head.generate();
    //setRotation(random(3));   NEED TO CHECK THIS   
    //make some random children
    //add chilren to head..
  }
  
  void setlocation(PVector p) {
    mlocation.set(p);
  }
  void setRotation(float r) {
    mrotation = r;
  }
  void setscale(PVector s) {
    mscale.set(s);
  }

  void clear() {
    //head is a Lim. Lim is a nodebase which has clear() method. 
    head.clear();
  }
  
}

