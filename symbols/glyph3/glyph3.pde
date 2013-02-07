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

