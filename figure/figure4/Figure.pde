
class Figure {

  Lim head, leftarm, rightarm, spine, leftleg, rightleg;

  PVector mscale;
  PVector mlocation;
  //only consider 2d rotation for now
  float mrotation;

  Figure(PVector p) {
    head = new Lim(p);
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
    head.render();
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
    head.setLength(random(20, 40));
    head.setAngle(random(-2, -0.5));
    head.generate();
    leftarm.setLength(random(20, 30));
    leftarm.setAngle(random(2.6, 3.2));
    leftarm.generate();
    rightarm.setLength(random(20, 30));
    rightarm.setAngle(random(-0.3, 0.5));
    rightarm.generate();
    spine.setLength(random(15, 30));
    spine.setAngle(random(1, 2.5));
    spine.generate();

    Vert v = spine.lower;
    Vert v1 = new Vert (new PVector(v.position.x, v.position.y-10));
    
    leftleg.setUpper(v1);
    rightleg.setUpper(v1);

    leftleg.setLength(random(20, 30));
    leftleg.setAngle(random(1, 3));
    rightleg.setAngle(random(0, 1));
    rightleg.setLength(random(20, 30));
    leftleg.generate();
    rightleg.generate();

    float p = random(0, 1);
    if (p > 0.9) { 
      leftarm.visible = false;
    }
    if (p <0.5) {
      rightarm.visible = false;
    }
    if (p <0.2) {
      rightleg.visible = false;
    }
        if (p >0.95) {
      leftleg.visible = false;
    }
    //setRotation(random(3));   
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
    leftarm.visible = true;
    rightarm.visible = true;
    leftleg.visible = true;
    rightleg.visible = true;
  }
}

