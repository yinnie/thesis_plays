//ways to compose symbols according to set structures/frameworks
//structures to choose from:  a. top/down  b. top/middle/bottom c. left/right d. left/middle/right
//special radicals  
//No.13 all surround
//no.14 bottom surround
//no.15 leftsurround 
//no.16 left top
//no.17 top surround

ArrayList<PShape> shapes;
int m = 18; //total number of radicals in data folder
int n = 14; //number of normal radical shapes in data folder. i.e No.0 to No.12 !!!debatable!!

ArrayList<PShape> specialShapes;
PShape lefttopShape;
PShape allsurroundShape;
PShape bottomupShape;
PShape topdownShape;
PShape leftsurroundShape;

Radical root;

void setup() {

  size(500, 500, P2D);
  background(255);
  smooth();
  shapes = new ArrayList();
  for ( int i = 0; i < m; i++) {
    PShape s;
    s = loadShape(str(i) + ".svg");
    s.enableStyle();
    shapes.add(s);
  }
  
  /*
  specialShapes = new ArrayList();
  for (int i = 13; i <=17; i++ ) {
    PShape s = shapes.get(i);
    specialShapes.add(s);
  }
  */
  //assign special radicals..ref at top of page
  lefttopShape = shapes.get(16);
  allsurroundShape = shapes.get(13);
  bottomupShape = shapes.get(14);
  topdownShape = shapes.get(15);
  leftsurroundShape = shapes.get(17);

  root = new Radical();
}

void draw() {

  background(255);
  pushStyle();
  noFill();
  stroke(255, 0, 0);
  strokeWeight(0.8);
  rect(100, 100, 290, 290);
  popStyle();

  pushMatrix();
  translate(100, 100);
  //scale(0.6);
  root.draw();
  popMatrix();
 
}

void generateStructure() {

  root.clear();

  //assign radicals from the subset 0-n
  PShape s = shapes.get((int)random(n));
  PShape m = shapes.get((int)random(n));
  PShape q = shapes.get((int)random(n));
  PShape p = shapes.get((int)random(n));

  //how many branches / layers? 
  int numLayers = (int) random(1, 3);
  //int numLayers = 2;

  if (numLayers == 1) {

    //choose a structure
    int struct = (int) random(0, 7);
    //int struct = 6;
    
    switch (struct) {
      case (0):  
      root.leftright(s, m);
      break;
      case (1): 
      root.topbottom(s, m);
      break;
      case (2):  
      root.lefttop(lefttopShape, s);
      break;
      case (3):  
      root.allaround(allsurroundShape, s);
      break;
      case (4):  
      root.bottomup(bottomupShape, s);
      break;
      case (5):  
      root.bottomup(topdownShape, s);
      break;
      case (6):  
      root.allaround(leftsurroundShape, s);
      root.getChild(1).setPosition(new PVector(50, 50));
      break;
    }
  } 
  else if ( numLayers == 2 ) {  

    //choose a structure 
    int r = (int) random(0, 9);
     //int r = 9;
    switch (r) {
      case (0):  //top / bottom / left / right combinations
      root.leftright(s, m);
      root.getChild((int)random(0, 2)).topbottom(p, q);
      //root.getChild((int)random(0, 1)).getChild(1).leftright(s,q);
      break;
      case (1):  //top / bottom / left / right combinations
      root.leftright(s, m);
      root.getChild((int)random(0, 2)).leftright(p, q);
      break;
      case (2):  //top / bottom / left / right combinations
      root.topbottom(s, m);
      root.getChild((int)random(0, 2)).leftright(p, q);
      break;
      case (3):  //top / bottom / left / right combinations
      root.topbottom(s, m);
      root.getChild((int)random(0, 2)).topbottom(p, q);
      break;
      case (4): //left top enclosure 
      root.lefttop(lefttopShape, s);
      root.getChild(1).topbottom(m, q);
      break;
      case (5): //left top enclosure 
      root.lefttop(lefttopShape, s);
      root.getChild(1).setPosition(new PVector(70, 70));
      root.getChild(1).setScale(new PVector(0.65, 0.65));
      root.getChild(1).leftright(m, q);
      break;
      case (6):  
      root.allaround(allsurroundShape, s);
      root.getChild(1).topbottom(m, q);
      break;
      case (7):  
      root.bottomup(bottomupShape, s);
      root.getChild(1).topbottom(m, q);
      break;
      case (8):  
      root.bottomup(topdownShape, s);
      root.getChild(1).topbottom(m, q);
      break;
      case (9):  
      root.allaround(leftsurroundShape, s);
      //root.getChild(1).setPosition(new PVector(50, 50));
      root.getChild(1).topbottom(m, q);
      break;
      case (10): //  not too keen on this design
      root.allaround(allsurroundShape, s);
      root.getChild(1).setScale(new PVector(0.6, 0.6));
      root.getChild(1).setPosition(new PVector(70, 60));
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
  root.clear();
}
