//separating the radical class as a sub-class of Nodebase so that we can allow some Nodebases
//to have a radical (TShape) and some Nodebases to have no actual radicals but children that have radicals.
//basically all nodes are part of the tree structure but if some branches have children it means they themselves have no rdicals to draw.
//all the drawing of the radicals are done in this class

class Radical extends Nodebase {

  PVector mScale, mRotation, mPosition;
  TShape mShape;

  Radical() {
    super();
    mScale = new PVector (1.0, 1.0);
    mPosition = new PVector (0.0, 0.0);
    mRotation = new PVector (0.0, 0.0);
    mShape = null;
  }
  void setShape(TShape _shape) {
    mShape = _shape;
  }
  void setScale(PVector _scale) {
    mScale.set( _scale);
  }

  void setPosition(PVector _value) {
    mPosition.set(_value);
  }

  void setRotation(PVector _value) {
    mRotation.set(_value);
  }

  void draw() {  

    noFill();
    stroke(255); 
    pushMatrix();
    translate(mPosition.x, mPosition.y);
    scale(mScale.x, mScale.y);
    //rotateX(mRotation.x);
    //rotateY(mRotation.y); 
  
    //it a radical has children, do not draw the shape but carry out transformations
    if ( mShape!= null && hasChildren == false) {
      mShape.render();
    }

    int numChildren = getChildCount();
    for ( int i = 0; i < numChildren; i++) {
      if ( getChild(i) != null) {
        strokeWeight(16);
        getChild(i).draw();
      }
    }    
    popMatrix();
  }

  void leftright(TShape l, TShape r) { 
    //structure of this node is left right
    Radical left = new Radical();
    Radical right = new Radical();
    left.setShape(l);
    right.setShape(r);
    addChild(left);
    addChild(right);
  }

  void topbottom(TShape t, TShape b) {
    Radical top = new Radical();
    Radical bottom = new Radical();
    top.setShape(t);
    bottom.setShape(b);
    addChild(top);
    addChild(bottom);
    top.setScale(new PVector (0.6, 0.6));
    bottom.setScale(new PVector (0.6, 0.6));
    bottom.setPosition(new PVector (35, 60));
    top.setPosition(new PVector (35, 30));
  }

  void generateStructure(TShape _s, TShape _m, TShape _q, TShape _p) {
   clear(); 
   pushMatrix();
   //how many branches / layers? 
   int numLayers = (int) random(1, 3);
  if (numLayers == 1 ) {

    //choose a structure
     int struct = (int) random(0, 2);
    //int struct = 4;

    switch (struct) {
      case (0):  
      leftright(s, m);
      break;
      case (1): 
      topbottom(s, m);
      break;
    }
  } 
  
  else if ( numLayers == 2 ) {  

    //choose a structure 
    int r = (int) random(0, 4);
    //int r = 0;
    switch (r) {
      case (0):  //top / bottom / left / right combinations
      leftright(p, q);
      getChild(1).topbottom(p, q);
       getChild(0).setPosition(new PVector(-10, 40));
      getChild(1).setPosition(new PVector(75, 40));
      getChild(1).getChild(1).leftright(s,q);
      break;
      case (1): 
      leftright(s, p);
      getChild(1).leftright(p, q);
         getChild(0).setPosition(new PVector(-10, 40));
      getChild(1).setPosition(new PVector(75, 40));
      break;
      case (2):  
      topbottom(s, m);
      getChild((int)random(0, 2)).leftright(p, q);
      break;
      case (3):  
      topbottom(s, q);
      getChild((int)random(0, 2)).topbottom(p, q);
      break;
      
    } 
  }
  popMatrix();
  }
  
  Radical getChild(int index) {
    if ( index >= 0 && index < children.size() ) {
      return (Radical)children.get(index);
    }
    else return null;
  }
}

