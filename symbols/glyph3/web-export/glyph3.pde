//ways to compose symbols according to set structures/frameworks
//structures to choose from:  a. top/down  b. top/middle/bottom c. left/right d. left/middle/right
//special radicals  
//No.13 all surround
//no.14 bottom surround
//no.15 leftsurround 
//no.16 left top
//no.17 top surround
ArrayList<TShape> shapes;
int n = 11; //total number of radicals in data folder

Radical root;

TShape s; 
TShape m;
TShape q;
TShape p;

boolean toClear;

void setup() {

  size(500, 500);
  background(255);
  smooth(); 

  shapes = new ArrayList();

  for ( int i = 0; i < n; i++) {
    TShape s = new TShape(i);
    shapes.add(s);
  }

  root = new Radical();

}

void draw() {

  background(255);
  pushStyle();
  noFill();
  stroke(255, 0, 0);
  strokeWeight(0.5);
  rectMode(CENTER);
  rect(width/2-20, height/2-20, 300, 300);
  popStyle();

  pushMatrix();
  translate(100, 100);
  //scale(0.8);
  root.draw();
  popMatrix();
  
  if(root.hasChildren) {
  println(root.getChildCount());
  }
}

void generateStructure() {

  root.clear();
 
 /*
  for ( int i = 0; i < root.children.size(); i++) {
    root.children.remove(i);
  } */ 

  TShape s = shapes.get((int)random(n));
  TShape m = shapes.get((int)random(n));
  TShape q = shapes.get((int)random(n));
  TShape p = shapes.get((int)random(n));
  //how many branches / layers? 
  //int numLayers = (int) random(1, 3);
  int numLayers = 1;

  if (numLayers == 1) {

    //choose a structure
    // int struct = (int) random(0, 7);
    int struct = 0;

    switch (struct) {
      case (0):  
      root.leftright(s, m);
      break;
      case (1): 
      root.topbottom(s, m);
      break;
      case (2):  
      root.lefttop(p, s);
      break;
      case (3):  
      root.allaround(q, s);
      break;
      case (4):  
      root.bottomup(m, s);
      break;
      case (5):  
      root.bottomup(m, s);
      break;
      case (6):  
      root.allaround(p, s);
      //root.getChild(1).setPosition(new PVector(50, 50));
      break;
    }
  } 
  else if ( numLayers == 2 ) {  

    //choose a structure 
    //int r = (int) random(0, 9);
    int r = 1;
    switch (r) {
      case (0):  //top / bottom / left / right combinations
      root.leftright(s, m);
      root.getChild(1).topbottom(p, q);
      root.getChild(1).getChild(1).leftright(s,q);
      break;
      case (1): 
      root.leftright(s, m);
      root.getChild((int)random(0, 2)).leftright(p, q);
      break;
      case (2):  
      root.topbottom(s, m);
      root.getChild((int)random(0, 2)).leftright(p, q);
      break;
      case (3):  
      root.topbottom(s, m);
      root.getChild((int)random(0, 2)).topbottom(p, q);
      break;
      case (4): //left top enclosure 
      root.lefttop(m, s);
      root.getChild(1).topbottom(p, q);
      break;
      case (5): //left top enclosure 
      root.lefttop(p, s);
      root.getChild(1).setPosition(new PVector(30, 30));
      root.getChild(1).setScale(new PVector(0.65, 0.65));
      root.getChild(1).leftright(m, q);
      break;
      case (6):  
      root.allaround(p, s);
      root.getChild(1).topbottom(m, q);
      break;
      case (7):  
      root.bottomup(p, s);
      root.getChild(1).topbottom(m, q);
      break;
      case (8):  
      root.bottomup(p, s);
      root.getChild(1).topbottom(m, q);
      break;
      case (9):  
      root.allaround(p, s);
      root.getChild(1).setPosition(new PVector(20, 20));
      root.getChild(1).topbottom(m, q);
      break;
      case (10): //  not too keen on this design
      root.allaround(p, s);
      root.getChild(1).setScale(new PVector(0.65, 0.65));
      root.getChild(1).setPosition(new PVector(30, 20));
      root.getChild(1).leftright(m, q);
      break;
    }
  }
}

void keyPressed() {
  //textTyped = key;
  generateStructure();
}

void mousePressed() {
  toClear = true;
}


class Nodebase {
  
  Nodebase parent;
  ArrayList<Nodebase> children;
  String name;
  boolean hasChildren;
  
  Nodebase() {
    parent = null;  //default is root node
    name = "unnamed";
    children = new ArrayList();
    hasChildren = false;
  }
  
  void addChild (Nodebase mChild) {
    mChild.setParent(this);
    children.add(mChild);
    hasChildren = true;
  }  
  
  void clear() {
    //remove all children
    for ( int i = 0; i < children.size(); i++){
      children.get(i).clear();
    }
     children.clear();
  }
  /*
  Nodebase getChild(int index) {
    if( index >= 0 && index < children.size() ) {
    return children.get(index);
    }
    else return null;
  }
  */
  int getChildCount() {
    return children.size();
  }
    
  void draw() {
    // stub method 
  }  
     
  void setParent(Nodebase mParent) {
      parent = mParent;
  }
  
  void setName(String _name) {
    name = _name;
  }
}

//this class contains all the two-dimensional shapes that we want to draw
//we use processing's innate geometry primitives but generalize the parameters so we can use them with more flexibility
//assuming all shapes drawn in a square of 300 by 300

class TShape {
  
  int drawType;  //the chosen shape type to draw
  int numShapes = 11; //number of types
  int unitLength = 120;
  float arcAngle;
  int startX = 25;
  int startY = 25;
  int gridSize = 400;
  
  TShape(int _drawType) {
     //drawType = (int)random(numShapes);
     drawType = _drawType;
     arcAngle = random(-PI*2, PI*2);
  }
  
  void clear() {
    noStroke();
    fill(255);
    rect(0, 0, gridSize, gridSize);
  }
  
  void render() {
   
    switch ( drawType) {
      case (0):
      //horizontal line 
      line(startX, gridSize/2, startX+unitLength, gridSize/2);
      break;
      case (1):
      //vertical line 
      line(gridSize/2, startY, gridSize/2, startY+unitLength);
      break;
      case (2):
      //diagnol 1
      line(startX, startY, startX+unitLength, startY+unitLength);
      break;
      case (3):
      //diagnol 2
      line(startX+unitLength, startY+unitLength, startX+unitLength, startY);
      case (4): 
      ellipse(gridSize/2, gridSize/2, unitLength, unitLength);
      break;
      case (5):
      rectMode(CENTER);
      rect(gridSize/2, gridSize/2, unitLength, unitLength);
      break;
      case (6):
      arc(gridSize/2, gridSize/2, unitLength, unitLength, arcAngle, arcAngle+PI/2);
      break;
      case (7):
      ellipse(gridSize/2, gridSize/2, unitLength/2, unitLength/2);
      break; 
      case (8):
      arc(gridSize/2, gridSize/2, unitLength, unitLength, arcAngle, arcAngle-PI/2);
      break;
      case (9):
      arc(gridSize/2, gridSize/2, unitLength, unitLength, 0, PI/2);
      break;
       case (10):
      arc(gridSize/2, gridSize/2, unitLength, unitLength, 0, -PI/2);
      break;
    
    }
  }
  
}
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
  /*
  void clear() {
    if(mShape!=null) 
    mShape.clear();
  }
  */

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
    right.setScale(new PVector (0.7, 0.7));
    left.setScale(new PVector (0.7, 0.7));
    left.setPosition(new PVector (20, 40));
    right.setPosition(new PVector(40, 40));
  }

  void topbottom(TShape t, TShape b) {
    Radical top = new Radical();
    Radical bottom = new Radical();
    top.setShape(t);
    bottom.setShape(b);
    addChild(top);
    addChild(bottom);
    top.setScale(new PVector (0.7, 0.7));
    bottom.setScale(new PVector (0.7, 0.7));
    bottom.setPosition(new PVector (40, 90));
    bottom.setPosition(new PVector (40, 70));
  }

  void lefttop(TShape t, TShape b) {
    Radical left = new Radical();
    Radical right = new Radical();
    left.setShape(t);
    right.setShape(b);
    addChild(left);
    addChild(right);
    left.setPosition(new PVector (20, 0));
    right.setScale(new PVector (0.7, 0.7));
    right.setPosition(new PVector (20, 20));
  }

  void allaround(TShape t, TShape b) {
    Radical out = new Radical();
    Radical in = new Radical();
    out.setShape(t);
    in.setShape(b);
    addChild(out);
    addChild(in);
    in.setScale(new PVector (0.7, 0.7));
    in.setPosition(new PVector (40, 50));
  } 

  void bottomup(TShape t, TShape b) {  //can also be used for top down
    Radical out = new Radical();
    Radical in = new Radical();
    out.setShape(t);
    in.setShape(b);
    addChild(out);
    addChild(in);
    out.setScale(new PVector(0.9, 0.9));
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


