//generative human figure 
//parts: head, two arms, body, two legs 
import processing.pdf.*;

Figure[] figures;
int n = 500;

void setup() {
  size(800, 600);
  smooth();
  
  figures = new Figure[n];
  for (int i = 0; i < n; i++) {
    PVector p = new PVector (random(width*0.5), random(height*2.5));
     figures[i] = new Figure (p);
  }
}

void draw() {
  beginRecord( PDF, "scribbles.pdf");
  background(255);
  for (int i = 0; i < n; i++) {
    figures[i].render();
  }
  endRecord();
}

void keyPressed() {

  for (int i = 0; i < n; i++) {
    //PVector p = new PVector (random(width/3, width/2), random(height*0.75, height));
    //figures[i].setlocation(p); 
    float f = random(0.1, 0.5);
    PVector s = new PVector (f, f);
    figures[i].setscale(s);
    figures[i].generate();
  }
 
}

