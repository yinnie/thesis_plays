//ways to compose symbols according to set structures/frameworks
//structures to choose from:  a. top/down  b. top/middle/bottom c. left/right d. left/middle/right


ArrayList<TShape> shapes;
int n = 17; //total number of radicals 

Radical root;

TShape s; 
TShape m;
TShape q;
TShape p;

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
  /*
  pushStyle();
  noFill();
  stroke(255, 0, 0);
  strokeWeight(0.5);
  rectMode(CENTER);
  rect(width/2-20, height/2-20, 300, 300);
  popStyle();  */

  pushMatrix();
  translate(-15, -30);
  scale(2.5);
  root.draw();
  popMatrix();
  

  println(root.getChildCount());
  if(root.hasChildren) {
    println(root.getChild(0).mShape.drawType);
    println(root.getChild(1).mShape.drawType);
  }
}

void generateStructure() {

  root.clear();

  TShape s = shapes.get((int)random(n));
  TShape m = shapes.get((int)random(n));
  TShape q = shapes.get((int)random(n));
  TShape p = shapes.get((int)random(n));
  //how many branches / layers? 
  int numLayers = (int) random(1, 3);
  //int numLayers = 2;

  if (numLayers == 1) {

    //choose a structure
     int struct = (int) random(0, 5);
    //int struct = 4;

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
      /*
      case (5):  
      root.bottomup(p, q); //used for top down 
      break;
      case (6):  
      root.allaround(p, s);
      //root.getChild(1).setPosition(new PVector(50, 50));
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
      root.leftright(s, m);
      root.getChild(1).topbottom(p, q);
       root.getChild(0).setPosition(new PVector(-10, 40));
      root.getChild(1).setPosition(new PVector(75, 40));
      root.getChild(1).getChild(1).leftright(s,q);
      break;
      case (1): 
      root.leftright(s, m);
      root.getChild(1).leftright(p, q);
         root.getChild(0).setPosition(new PVector(-10, 40));
      root.getChild(1).setPosition(new PVector(75, 40));
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
      root.leftright(s, m);
      root.getChild(0).leftright(p, q);
         root.getChild(0).setPosition(new PVector(5, 40));
      root.getChild(1).setPosition(new PVector(65, 40));
      break;
      case (9):  
      root.allaround(p, s);
      root.getChild(1).setPosition(new PVector(20, 20));
      root.getChild(1).topbottom(m, q);
      break;
      /*
      case (10): //  not too keen on this design
      root.allaround(p, s);
      root.getChild(1).setScale(new PVector(0.65, 0.65));
      root.getChild(1).setPosition(new PVector(30, 20));
      root.getChild(1).leftright(m, q);
      break;
      */
    }
  }
}

void keyPressed() {
  if ( key == ' ') {
  generateStructure(); }
}

void mousePressed() {

   saveFrame("sym##.png");
}




