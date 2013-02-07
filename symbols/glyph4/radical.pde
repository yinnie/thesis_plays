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

    pushMatrix();
    translate(mPosition.x, mPosition.y);
    scale(mScale.x, mScale.y);
    //rotateX(mRotation.x);
    //rotateY(mRotation.y); 

    noFill();
    stroke(0);
    strokeWeight(3);
    //it a radical has children, do not draw the shape but carry out transformations
    if ( mShape!= null && hasChildren == false) {
      mShape.render();
    }

    int numChildren = getChildCount();
    for ( int i = 0; i < numChildren; i++) {
      if ( getChild(i) != null) {
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
    right.setScale(new PVector (0.6, 0.6 ));
    left.setScale(new PVector (0.6, 0.6));
    left.setPosition(new PVector (0, 40));
    right.setPosition(new PVector(50, 40));
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

  void lefttop(TShape t, TShape b) {
    Radical left = new Radical();
    Radical right = new Radical();
    left.setShape(t);
    right.setShape(b);
    addChild(left);
    addChild(right);
    left.setPosition(new PVector (20, 15));
    left.setScale(new PVector (0.8, 0.8));
    right.setScale(new PVector (0.6, 0.6));
    right.setPosition(new PVector (40, 40));
  }

  void allaround(TShape t, TShape b) {
    Radical out = new Radical();
    Radical in = new Radical();
    out.setShape(t);
    in.setShape(b);
    addChild(out);
    addChild(in);
    out.setScale(new PVector (0.8, 0.8));
    out.setPosition(new PVector (20,15));
    in.setScale(new PVector (0.5, 0.5));
    in.setPosition(new PVector (40, 50));
  } 

  void bottomup(TShape t, TShape b) {  //can also be used for top down
    Radical out = new Radical();
    Radical in = new Radical();
    out.setShape(t);
    in.setShape(b);
    addChild(out);
    addChild(in);
    out.setScale(new PVector(0.8, 0.8));
    out.setPosition(new PVector(20, 30));
    in.setScale(new PVector (0.65, 0.65));
    in.setPosition(new PVector (40, 65));
  }


  Radical getChild(int index) {
    if ( index >= 0 && index < children.size() ) {
      return (Radical)children.get(index);
    }
    else return null;
  }
}

