import processing.pdf.*;

//using four strokes to generate symbols
PFont f;
Symbol[]  ss;
int n = 14;
int m = 12;
int marginh = 60; //horizontal margin
int marginv = 50;

void setup() {
  
  size(700, 800);
  background(255);
  smooth();
   
  f = createFont("Arial", 12, true);
  
  ss = new Symbol[n*m];
  
  for ( int i = 0; i< ss.length; i++) {
    ss[i] = new Symbol(0, 50);
  }
   
  beginRecord(PDF, "toptwo.pdf");

}

void draw() {
  
  background(255);
  stroke(0);
  
   for ( int i = 0; i < m; i++) {
    for ( int j = 0; j< n; j++) {
      
      ss[i+j*i].setStartX ( marginh+i*50 );
      ss[i+j*i].setStartY ( marginv+j*50 );
      ss[i+j*i].draw();
   }
  }

/*
  for ( int i = 0; i < ss.length; i++) {
        ss[i].draw();    
   }
   */
     
  textFont (f, 12);
  fill(0, 89);
  text("variations of strokes", marginh, height-50);
  
  endRecord();
  
}

void keyPressed() {
  for ( int i = 0; i< ss.length; i++) {
    ss[i].generate();
  }
}


  
