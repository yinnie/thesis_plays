/////////////////HUMAN FACES
import processing.pdf.*;

int cols = 20;
int rows = 32;
int total;
int marginH = 20;
int marginV = 20;
int seed = 100;
 int cellSize = 80;
 float baseScale = .75;
 boolean recording = true;
 
ArrayList<Figure> figures;

void setup() {
  int appWidth = int(cols * cellSize * baseScale);
  int appHeight = int(rows * cellSize * baseScale);
  println( "appWidth: " + appWidth + "\tappHeight: " + appHeight );  
   background(255);
  size( appWidth, 400);
  smooth();

  total = cols * rows;
  figures = new ArrayList();
 
  for ( int i = 0; i < total; i++) {
    Figure f = new Figure();
    figures.add(f);
  }

  beginRecord(PDF, "faces.pdf"); 

 
  
}

void draw() {
  
  background(255);
 
  randomSeed(seed);
for ( int j = 0; j < rows; j++) { 
    for ( int i = 0 ; i < cols; i++) {  
    
     if ( j >= 18 && j <19 ) {
        PVector p = new PVector ( random(width/4, width/4+150), random(140, 200));
        figures.get(i+i*j).setlocation(p);
     }
     else if ( j >= 19 && j <=20 ) {
        PVector p = new PVector ( random(width*0.75, width*0.75+150), random(150, 200));
        figures.get(i+i*j).setlocation(p);
     }
     else {
      //PVector p = new PVector (marginH +i*cellSize, marginV +j*cellSize);
      PVector p = new PVector ( random(width), random(height/2, height)); 
      figures.get(i+i*j).setlocation(p);
     }
      
      PVector s = new PVector ( random(0.5, 0.5), random(0.5, 0.5));
      float r = random(0, 720);
      figures.get(i+i*j).setRotation(r);
      figures.get(i+i*j).setscale(s);
      figures.get(i+i*j).render();
      figures.get(i+i*j).generate();
    }
  }  

  
  
  
}

void keyPressed() {
  
  if ( key == 's' ) {
    saveFrame();
  }
    
  if ( key ==' ') {
    recording = false;
    seed = (int) random(1000);
    for ( int j = 0; j < rows; j++) { 
    for ( int i = 0 ; i < cols; i++) {    

      figures.get(i+i*j).generate();
    }
    }
  }
  
   if ( key == 'q') {
    recording = true;
    endRecord();
    exit();
  }
}

