//ways to compose symbols according to set structures/frameworks
//structures to choose from:  a. top/down  b. top/middle/bottom c. left/right d. left/middle/right

ArrayList<Radical> roots;
ArrayList<TShape> shapes;

int cols = 19;
int rows = 16;
int marginH = 300;
int marginV = 200;

 TShape s;
 TShape m;
 TShape q;
 TShape p;
      
int n = 17; //total number of radicals draw types

void setup() {

  size(720, 830);
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

  pushMatrix();
  //translate(100, 100);
  scale(0.16);
  strokeWeight(20);
  for ( int j = 0; j < rows; j++) { 
   for ( int i = 0 ; i < cols; i++) {
       roots.get(i+i*j).setPosition(new PVector (marginH +i*200, marginV +j*300)); 
       roots.get(i+i*j).draw();
   }
  }
  popMatrix();
  
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





