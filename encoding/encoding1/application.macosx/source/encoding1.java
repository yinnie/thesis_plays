import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.pdf.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class encoding1 extends PApplet {



ArrayList<Radical> roots;
ArrayList<TShape> shapes;

int cols = 50;
int rows = 10;
int marginH = 100;
int marginV = 100;

 TShape s;
 TShape m;
 TShape q;
 TShape p;
      
int n = 17; //total number of radicals draw types
boolean recording = false;
float w = 12; //inch A4
float h = 3; // inch 
float scalefactor = 100;
int counter = 1;

public void setup() {
  
  float w0 = w*scalefactor;
  float h0 = h*scalefactor;

  size( (int)w0, (int)h0);
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

public void draw() {


   if( recording ) {
  beginRecord(PDF, "print" + counter + ".pdf");
  }
    background(0);
  pushMatrix();
  //translate(100, 100);
  scale(0.1f);
  strokeWeight(100);
  for ( int j = 0; j < rows; j++) { 
   for ( int i = 0 ; i < cols; i++) {
       roots.get(i+i*j).setPosition(new PVector (marginH +i*300, marginV +j*320)); 
       roots.get(i+i*j).draw();
   }
  }
  popMatrix();
  endRecord();
}

public void generateSymbols() {
  
      
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

public void keyPressed() {
  if ( key ==' ') {
    recording = false;
  generateSymbols(); }
  
  if ( key == 'q') {
    counter ++;
    recording = true;
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
  
  public void addChild (Nodebase mChild) {
    mChild.setParent(this);
    children.add(mChild);
    hasChildren = true;
  }  
  
  public void clear() {
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
  public int getChildCount() {
    return children.size();
  }
    
  public void draw() {
    // stub method 
  }  
     
  public void setParent(Nodebase mParent) {
      parent = mParent;
  }
  
  public void setName(String _name) {
    name = _name;
  }
}

//this class contains all the two-dimensional shapes that we want to draw
//we use processing's innate geometry primitives but generalize the parameters so we can use them with more flexibility
//assuming all shapes drawn in a square of 300 by 300


//strokes class
//in a square of 200x200, all strokes start at (0, 0) unless there is an offset

class TShape {

  int drawType;  //the chosen shape type to draw
  int l = 200;  // this is grid size
  
  TShape(int _drawType) {
    drawType = _drawType;
  }

  public void render() {
    strokeWeight(12);
    switch ( drawType) {
      case (0):
      //vertical line on left edge of the block
      line(0, 0, 0, l);
      break;
      case (1):
      // a line half size of case 0 and in the middle of the square
      line(l*0.5f, l*0.5f, 0*0.5f, l);
      break;
      case (2):
      //diagnol bottom left corner to right up corner
      line(0, l, l, 0);
      break;
      case (3):
      //diagnol half size of case 2
      line(0, l, l*0.5f, l*0.5f);
      case (4): 
      //diagnol top left corner to bottom right corner
      line(0, 0, l, l);
      break;
      case (5):
      //diagnol half size of case 4
      line(0, 0, l*0.5f, l*0.5f);
      break;
      case (6):
      //diagnol half size of case 4 but starting at second half of the block
       line(0, l*0.5f, l*0.5f, l);
      break;
      case (7):
      // looks like this / but only at top left quadrant of the block
      line(0, l*0.5f, l*0.5f, 0);
      break; 
      case (8):
      //a quarter of an arc at top left quadrant
      arc(0, l/2, l/2, l/2, PI*1.5f, TWO_PI);
      break;
      case (9):
      arc(0, l/2, l/2, l/2, 0, HALF_PI);
      break;
      case (10):
      arc(l/2, l/2, l/2, l/2, PI, PI*1.5f);
      break;  
      case(11):
      arc(l/2, l/2, l/2, l/2, PI*0.5f, PI);
      break;
      case(12):
      // a line half size of case 0 and on the right edge of the block
      line(l, l*0.5f, l, l);
      case(13):
      //horizontal line
      line(0, 0, l, 0);
     break;
     case(14):
     // a line half size of case 13
     line(0, 0, l*0.5f, 0);
     break;
     case(15):
      fill(255);
      ellipse(l*0.75f, l*0.25f, l/6, l/6);
     break; 
     case(16):
      fill(0);
      ellipse(l*0.75f, l*0.75f, l/5.5f, l/5.5f);
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
    mScale = new PVector (1.0f, 1.0f);
    mPosition = new PVector (0.0f, 0.0f);
    mRotation = new PVector (0.0f, 0.0f);
    mShape = null;
  }
  public void setShape(TShape _shape) {
    mShape = _shape;
  }
  public void setScale(PVector _scale) {
    mScale.set( _scale);
  }

  public void setPosition(PVector _value) {
    mPosition.set(_value);
  }

  public void setRotation(PVector _value) {
    mRotation.set(_value);
  }

  public void draw() {  

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

  public void leftright(TShape l, TShape r) { 
    //structure of this node is left right
    Radical left = new Radical();
    Radical right = new Radical();
    left.setShape(l);
    right.setShape(r);
    addChild(left);
    addChild(right);
  }

  public void topbottom(TShape t, TShape b) {
    Radical top = new Radical();
    Radical bottom = new Radical();
    top.setShape(t);
    bottom.setShape(b);
    addChild(top);
    addChild(bottom);
    top.setScale(new PVector (0.6f, 0.6f));
    bottom.setScale(new PVector (0.6f, 0.6f));
    bottom.setPosition(new PVector (35, 60));
    top.setPosition(new PVector (35, 30));
  }

  public void generateStructure(TShape _s, TShape _m, TShape _q, TShape _p) {
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
  
  public Radical getChild(int index) {
    if ( index >= 0 && index < children.size() ) {
      return (Radical)children.get(index);
    }
    else return null;
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "encoding1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
