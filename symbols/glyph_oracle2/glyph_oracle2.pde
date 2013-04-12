//ways to compose symbols according to set structures/frameworks
//structures to choose from:  a. top/down  b. top/middle/bottom c. left/right d. left/middle/right
import processing.pdf.*;

ArrayList<PShape> shapes;

int n = 23; //number of normal radical shapes in data folder.
int counter = 1;
boolean recording = false;
Radical root;

void setup() {
  
  size(500, 500, P2D);
  background(255);
  smooth();
  shapes = new ArrayList();
  for ( int i = 0; i < n; i++) {
    PShape s;
    s = loadShape(str(i) + ".svg");
    s.enableStyle();
    shapes.add(s);
  }
  
  root = new Radical();
}

void draw() {
    if( recording ) {
  beginRecord(PDF, "oracles" + counter + ".pdf");
  }
  background(255);
  pushMatrix();
  translate(80, 80);
  scale(1.3);
  root.draw();
  popMatrix();
  
   endRecord();
 
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
    int struct = (int) random(0, 3);
    //int struct = 6;
    
    switch (struct) {
      case (0):  
      root.leftright(s, m);
      break;
      case (1): 
      root.topbottom(s, m);
      break;
     
    }
  } 
  else if ( numLayers == 2 ) {  

    //choose a structure 
    int r = (int) random(0, 4);
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
     
    }
  }
}

void keyPressed() {
  //textTyped = key;
  if ( key == ' ') {
    recording = false;
  generateStructure();
  }
    if ( key == 'q') {
    counter ++;
    recording = true;
  }
}

void mousePressed() {
  root.clear();
}
