//separating the radical class as a sub-class of Nodebase so that we can allow some Nodebases
//to have a radical (String) and some Nodebases to have no actual radicals but children that have radicals.
//basically all nodes are part of the tree structure but if some branches have children it means they themselves have no rdicals to draw.
//all the drawing of the radicals are done in this class

class Radical extends Nodebase {

  PVector mScale, mRotation, mPosition;
  String mShape;

  Radical() {
    super();
    mScale = new PVector (1.0, 1.0);
    mPosition = new PVector (0.0, 0.0);
    mRotation = new PVector (0.0, 0.0);
    mShape = null;
  }

  void setShape(String _shape) {
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
    
    //it a radical has children, do not draw the shape but carry out transformations
    if (mShape!=null && hasChildren == false) {
      text(mShape, 0, 0);
    }

    int numChildren = getChildCount();
    for ( int i = 0; i < numChildren; i++) {
      if ( getChild(i) != null) {
        getChild(i).draw();
      }
    }
    popMatrix();
  }

  void leftright(String l, String r) { 
    //structure of this node is left right
    Radical left = new Radical();
    Radical right = new Radical();
    left.setShape(l);
    right.setShape(r);
    addChild(left);
    addChild(right);
    right.setScale(new PVector (1.1, 1.7));
    left.setScale(new PVector (1.1, 1.7));
    left.setPosition(new PVector (-5, 0));
    right.setPosition(new PVector (5, 0));
  }

  void topbottom(String t, String b) {
    Radical top = new Radical();
    Radical bottom = new Radical();
    top.setShape(t);
    bottom.setShape(b);
    addChild(top);
    addChild(bottom);
    top.setScale(new PVector (1.8, 1.05));
    bottom.setScale(new PVector (1.8, 1.05));
    top.setPosition(new PVector(-4,-7));
    bottom.setPosition(new PVector (-4, 4));
  }

  void lefttop(String t, String b) {
    Radical left = new Radical();
    Radical right = new Radical();
    left.setShape(t);
    right.setShape(b);
    addChild(left);
    addChild(right);
    left.setPosition(new PVector (-20, 0));
    right.setScale(new PVector (0.8, 0.8));
    right.setPosition(new PVector (50, 50));
  }

  void allaround(String t, String b) {
    Radical out = new Radical();
    Radical in = new Radical();
    out.setShape(t);
    in.setShape(b);
    addChild(out);
    addChild(in);
    in.setScale(new PVector (0.7, 0.7));
    in.setPosition(new PVector (40, 50));
  } 

  void bottomup(String t, String b) {  //can also be used for top down
    Radical out = new Radical();
    Radical in = new Radical();
    out.setShape(t);
    in.setShape(b);
    addChild(out);
    addChild(in);
    out.setScale(new PVector(1.0, 0.9));
    out.setPosition(new PVector(0, 20));
    in.setScale(new PVector (0.57, 0.57));
    in.setPosition(new PVector (60, 65));
  }


  Radical getChild(int index) {
    if ( index >= 0 && index < children.size() ) {
      return (Radical)children.get(index);
    }
    else return null;
  }
}

