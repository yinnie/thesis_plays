//generative human figure 
//parts: head, two arms, body, two legs 
import processing.pdf.*;

Figure[] figures;
ArrayList<Radical> roots;
ArrayList<TShape> shapes;
int n = 20;
 TShape s;
 TShape u;
 TShape q;
 TShape p;
      
int nRadicals = 14; //total number of radicals draw types
int characters = 50;

void setup() {
  size(800, 600);
  smooth();
  
  figures = new Figure[n];
  for (int i = 0; i < n; i++) {
    PVector p = new PVector (random(width), random(height));
     figures[i] = new Figure (p);
  }
   roots = new ArrayList();
  shapes = new ArrayList();

  for ( int i = 0; i < nRadicals; i++) {
    TShape s = new TShape(i);
    shapes.add(s);
  } 
  for ( int i = 0; i < characters; i++) {
     Radical root = new Radical();
    
       roots.add(root);
  }
}

void draw() {
  
    beginRecord(PDF, "figuresbw.pdf");
  background(255);
  for (int i = 0; i < n; i++) {
    figures[i].render();
  }
  pushMatrix();
  //translate(100, 100);
  scale(0.2);
  strokeWeight(20);
  for ( int i = 0; i < characters; i++) {       
       roots.get(i).draw();
  }
  popMatrix();
  
  endRecord();
}

void keyPressed() {

  for (int i = 0; i < n; i++) {
    PVector p = new PVector (random(10), random(10));
    figures[i].setlocation(p); 
    float f = random(0.8, 1.2);
    PVector s = new PVector (f, f);
    figures[i].setscale(s);
    figures[i].generate();
  }
  
  for ( int i = 0; i < characters; i++) { 
     s = shapes.get((int)random(nRadicals));
       u = shapes.get((int)random(nRadicals));
       q = shapes.get((int)random(nRadicals));
       p = shapes.get((int)random(nRadicals)); 
       roots.get(i).setPosition(new PVector (random(width*5), random(height*5)));
       float factor = random(0.4, 1.1); 
       roots.get(i).setScale(new PVector (factor, factor));
       roots.get(i).generateStructure(s,p,u, q);
  }
}

