import processing.pdf.*;

ArrayList<Radical> roots;
ArrayList<TShape> shapes;

int cols = 190;
int rows = 20;
int marginH = 100;
int marginV = 300;

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

void setup() {
  
  float w0 = w*scalefactor;
  float h0 = h*scalefactor;

//  size( (int)w0, (int)h0);
size(3000, 460);
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


   if( recording ) {
  beginRecord(PDF, "print" + counter + ".pdf");
  }
    background(0);
  pushMatrix();
  //translate(100, 100);
  scale(0.06);
  strokeWeight(100);
  for ( int j = 0; j < rows; j++) { 
   for ( int i = 0 ; i < cols; i++) {
       roots.get(i+i*j).setPosition(new PVector (marginH +i*260, marginV +j*350)); 
       roots.get(i+i*j).draw();
   }
  }
  popMatrix();
  endRecord();
}

void generateSymbols() {
  
      
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

void keyPressed() {
  if ( key ==' ') {
    recording = false;
  generateSymbols(); }
  
  if ( key == 'q') {
    counter ++;
    recording = true;
  }
    
}





