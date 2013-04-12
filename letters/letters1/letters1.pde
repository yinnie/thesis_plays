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
  size( appWidth, appHeight );
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





