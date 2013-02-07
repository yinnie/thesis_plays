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
  noLoop();
  //frameRate(1);
  smooth();
   
  f = createFont("Arial", 12, true);
  
  ss = new Symbol[n*m];
  
  for ( int i = 0; i< ss.length; i++) {
    ss[i] = new Symbol(0, 50);
  }
  
  beginRecord(PDF, "toptwo.pdf");
}

void draw() {
  
  stroke(0);

   
  for ( int i = 0; i < m; i++) {
 
    for ( int j = 0; j< n; j++) {
      
      ss[i+j*i].setStartX ( marginh+i*50 );
      ss[i+j*i].setStartY ( marginv+j*50 ); 
/*
  float p = random(0, 7);
  if( p <= 1)    { 
  ss[i+j*i].setAngle1(random(-80, 90)); }  
  else if(p > 1 && p <= 2) { 
  ss[i+j*i].setAngle2(random(-80, 90)); }
  else if (p >2 && p <=3 ) { 
  ss[i+j*i].setAngle1(random(-80, 90)); 
  ss[i+j*i].setAngle6(random(-10, 20));
  }
  else if (p >3 && p <=4 ) { 
  ss[i+j*i].setAngle5(random(-80, 90)); 
   ss[i+j*i].setAngle2(random(-20, 20));
  }
    else if (p >4 && p <=5 ) { 
  ss[i+j*i].setAngle4(random(-80, 90)); 
   ss[i+j*i].setAngle3(random(-20, 20));
  }
      else if (p >5 && p <=6 ) { 
  ss[i+j*i].setAngle4(random(-80, 90)); 
   ss[i+j*i].setAngle6(random(-50, 20));
  }
        else if (p >6 && p <=7 ) { 
  ss[i+j*i].setAngle5(random(-80, 80)); 
   ss[i+j*i].setAngle3(random(-30, 20));
  }
   */ 
   ss[i+j*i].draw();
   }
  }
  
  textFont (f, 12);
  fill(0, 89);
  text("variations of strokes", marginh, height-50);
  
  endRecord();
  
}
