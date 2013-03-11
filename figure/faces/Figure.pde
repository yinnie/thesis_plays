
class Figure {

  Lim leftarm, rightarm, spine, leftleg, rightleg;

  PVector mscale;
  PVector mlocation;
  //only consider 2d rotation for now
  float mrotation;
  
  Figure() {
    PVector p = new PVector(0, 0);
    //head = new Lim(p);
    leftarm = new Lim(p);
    rightarm = new Lim(p);
    spine = new Lim(p);
    leftleg = new Lim(p);
    rightleg = new Lim(p);
    mscale = new PVector(1.0, 1.0);
    mlocation = new PVector(0.0, 0.0);
    mrotation = 0.0;
  }
  
  Figure(PVector p) {
    //head = new Lim(p);
    leftarm = new Lim(p);
    rightarm = new Lim(p);
    spine = new Lim(p);
    leftleg = new Lim(p);
    rightleg = new Lim(p);
    mscale = new PVector(1.0, 1.0);
    mlocation = new PVector(0.0, 0.0);
    mrotation = 0.0;
  }

  void render() {
    pushMatrix();
    translate(mlocation.x, mlocation.y);
    scale(mscale.x, mscale.y);
    rotate(radians(mrotation));
   // head.render();
    leftarm.render();
    rightarm.render();
    spine.render();
    leftleg.render();
    rightleg.render();
    if (spine.hasChildren) {
      int numChildren = spine.children.size();
      for ( int i=0; i < numChildren; i++) {
        spine.children.get(i).render();
      }
    }
    popMatrix();
  }

  void generate() {
    clear();  
    //head.setLength(random(30, 40));
    //head.setAngle(random(-2, -0.5));
    //head.generate();
    leftarm.setLength(random(20, 35));
    leftarm.setAngle(random(2.6, 3.2));
    leftarm.generate();
    rightarm.setLength(random(20, 35));
    rightarm.setAngle(random(-0.3, 0.5));
    rightarm.generate();
    spine.setLength(random(30, 35));
    spine.setAngle(random(1.8, 2.2));
    spine.generate();
    
    Vert v = spine.lower;
    leftleg.setUpper(v);
    rightleg.setUpper(v);

    leftleg.setLength(random(30, 35));
    leftleg.setAngle(random(0, 1));
    rightleg.setAngle(random(0, 0.5));
    rightleg.setLength(random(30, 35));
    leftleg.generate();
    rightleg.generate();
    //setRotation(random(3));   NEED TO CHECK THIS
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
    spine.clear();
  }
}

