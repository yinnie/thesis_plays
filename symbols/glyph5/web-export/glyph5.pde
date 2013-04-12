//ways to compose symbols according to set structures/frameworks
//structures to choose from:  a. top/down  b. top/middle/bottom c. left/right d. left/middle/right

ArrayList<Radical> roots;
ArrayList<TShape> shapes;

int cols = 20;
int rows = 10;
int marginH = 0;
int marginV = 0;

 TShape s;
 TShape m;
 TShape q;
 TShape p;
 
 int cellSize = 250;
 float baseScale = 0.1;
      
int n = 14; //total number of radicals draw types

void setup() {
  int appWidth = int(cols * cellSize * baseScale);
  int appHeight = int(rows * cellSize * baseScale);
  println( "appWidth: " + appWidth + "\tappHeight: " + appHeight ); 
  
 // size( appWidth, appHeight );
 
  size( 500, 500);
  background(255);
  smooth(); 
  
  roots = new ArrayList();
  shapes = new ArrayList();

  for ( int i = 0; i < n; i++) {
    TShape s = new TShape(i);
    shapes.add(s);
  } 
  int total = cols*rows;
  for ( int i = 0; i < total; i++) {
     Radical root = new Radical();
       roots.add(root);
  }        
}

void draw() {

  background(255);
  
  scale(baseScale);

  pushMatrix();
  //translate(100, 100);
  strokeWeight(20);
  //scale(baseScale);
  for ( int j = 0; j < rows; j++) { 
   for ( int i = 0 ; i < cols; i++) {
       roots.get(i+i*j).setPosition(new PVector (marginH +i*cellSize, marginV +j*cellSize)); 
       roots.get(i+i*j).draw();
   }
  }
  popMatrix();
  
}

void keyPressed() {
  if ( key == 's' )
    saveFrame();
}

void mousePressed() {
  
      
   for ( int j = 0; j < rows; j++) { 
         
     for ( int i = 0 ; i < cols; i++) {
     
       s = shapes.get((int)random(n));
       m = shapes.get((int)random(n));
       q = shapes.get((int)random(n));
       p = shapes.get((int)random(n)); 
       
       roots.get(i+i*j).generateStructure(s,p,m, q);
   }
  }
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
  int unitLength = 150;
  int startX = 50;
  int startY = 50;
  int gridSize = 300;
  float arcAngle;
  
  TShape(int _drawType) {
    //drawType = (int)random(numShapes);
    drawType = _drawType;
    arcAngle = random(PI/3, PI);
  }

 

  void render() {
    strokeWeight(12);
    switch ( drawType) {
      case (0):
      //horizontal line 
      line(startX, startY, startX+unitLength, startY);
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
      line(startX+unitLength, startY, startX, startY+unitLength);
      case (4): 
      ellipse(gridSize/2, gridSize/2, unitLength, unitLength);
      //arc(gridSize/2, gridSize/2, unitLength, unitLength, PI/4*3, -PI/6);
      break;
      case (5):
      line(startX, startY, startX+unitLength, startY);
      line(startX, startY, startX, startY+unitLength);
      //line(startX+unitLength, startY, startX+unitLength, startY+unitLength);
      //rectMode(CENTER);
      //rect(gridSize/2, gridSize/2, unitLength, unitLength);
      break;
      case (6):
      arc(gridSize/2, gridSize/2, unitLength, unitLength, 0, PI/2);
    
      break;
      case (7):
      ellipse(gridSize/2, gridSize/2, unitLength/2, unitLength/2);
      //arc(gridSize/2, gridSize/2, unitLength, unitLength, -PI/8*3, PI/9*5);
      break; 
      case (8):
      //arc(gridSize/2, gridSize/2, unitLength, unitLength, PI/3, PI/3+arcAngle);
      arc(gridSize/2, gridSize/2, unitLength, unitLength, PI, PI/2+PI);
      break;
      case (9):
      arc(gridSize/2, gridSize/2, unitLength/2, unitLength/2, -PI/2, PI/2+PI);
      break;
      case (10):
      arc(gridSize/2, gridSize/2, unitLength, unitLength, PI/2, PI);
      break;  
      case(11):
      line(startX, startY, startX, startY+unitLength);
      line(startX, startY+unitLength, startX+unitLength, startY+unitLength);
      break;
      case(12):
      line(startX, startY, startX, startY+unitLength);
      line(startX, startY+unitLength, startX+unitLength, startY+unitLength);
      line(startX+unitLength, startY+unitLength, startX+unitLength, startY);
      case(13):
     arc(gridSize/2, gridSize/2, unitLength, unitLength, PI/2, PI/2-arcAngle);
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
    stroke(0);

    
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
  
  

  void generateStructure(TShape _s, TShape _m, TShape _q, TShape _p) {
   clear(); 
   pushMatrix();
   //how many branches / layers? 
   int numLayers = (int) random(1, 3);
  //int numLayers = 1;

  if (numLayers == 1) {

    //choose a structure
     int struct = (int) random(0, 5);
    //int struct = 4;

    switch (struct) {
      case (0):  
      leftright(s, m);
      break;
      case (1): 
      topbottom(s, m);
      break;
      case (2):  
      lefttop(p, s);
      break;
      case (3):  
      allaround(q, s);
      break;
      case (4):  
      bottomup(m, s);
      break;
      /*
      case (5):  
      bottomup(p, q); //used for top down 
      break;
      case (6):  
      allaround(p, s);
      //getChild(1).setPosition(new PVector(50, 50));
      break;
      */
    }
  } 
  else if ( numLayers == 2 ) {  

    //choose a structure 
    int r = (int) random(0, 10);
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
      case (4): //left top enclosure 
      lefttop(m, s);
      getChild(1).topbottom(p, q);
      break;
      case (5): //left top enclosure 
      lefttop(p, s);
      getChild(1).setPosition(new PVector(30, 30));
      getChild(1).setScale(new PVector(0.65, 0.65));
      getChild(1).leftright(m, q);
      break;
      case (6):  
      allaround(p, s);
      getChild(1).topbottom(m, q);
      break;
      case (7):  
      bottomup(p, s);
      getChild(1).topbottom(m, q);
      break;
      case (8):  
      leftright(s, m);
      getChild(0).leftright(p, q);
      getChild(0).setPosition(new PVector(5, 40));
      getChild(1).setPosition(new PVector(65, 40));
      break;
      case (9):  
      allaround(p, s);
      getChild(1).setPosition(new PVector(20, 20));
      getChild(1).topbottom(m, q);
      break;
      /*
      case (10): //  not too keen on this design
      allaround(p, s);
      getChild(1).setScale(new PVector(0.65, 0.65));
      getChild(1).setPosition(new PVector(30, 20));
      getChild(1).leftright(m, q);
      break;
      */
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


