//generative human figure 
//parts: head, two arms, body, two legs 
//plus landscape 
//plus arranging the figures on the page

import toxi.color.*;
import toxi.color.theory.*;
import toxi.util.datatypes.*;
import java.util.Iterator;
import processing.pdf.*;

Figure[] figures;
ArrayList<Radical> roots;
ArrayList<TShape> shapes;
TShape s,u,q,p;
int nRadicals = 14; //total number of radicals draw types used to make the symbols
int characters = 200; //number of symbols
int n = 30; //number of figures
ColorList backgroundlist;
int numColors = 500;
float squarew, squareh;

void setup() {

  size(1400, 1000);
  colorMode(HSB, 1, 1, 1);
  smooth();
  generateGrids();
  initiateFigures();
  initiateSymbols();
}

void draw() {

  beginRecord(PDF, "landscape.pdf");

  //draw background grids
  squareswatches(backgroundlist, 0, 0);
 //draw figures
 TColor tc = TColor.newHSV(0.2, 0.6, 0.01);
 stroke(tc.toARGB());
  for (int i = 0; i < n; i++) {
    figures[i].render();
  }
  //draw symbols
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
  if ( key ==' ') {
  generateGrids();
  generateFigures();
  generateSymbols(); }
}

void initiateFigures() {
  figures = new Figure[n];
  //figures far away...
  for (int i = 0; i < n; i++) {
    PVector p = new PVector (random(width), random(height/2, height));
    figures[i] = new Figure (p);
    float f = random(0.6, 1.2);
    PVector s = new PVector (f, f);
    figures[i].setscale(s);
}
  /*
  //figures closer
   for (int i = n/3 ; i < n; i++) {
    PVector p = new PVector (random(width), random(height*0.75, height));
    figures[i] = new Figure (p);
    float f = random(1.2, 3.0);
    PVector s = new PVector (f, f);
    figures[i].setscale(s);
  }
  */
}

void initiateSymbols() {
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

void generateGrids() {
  TColor col = ColorRange.BRIGHT.getColor();
  //ReadonlyTColor coll = NamedColor.getForName("cyan");
  //TColor col = coll.copy();
  ColorTheoryStrategy ss = new TriadTheoryStrategy();
  backgroundlist = ColorList.createUsingStrategy(ss, col);
  backgroundlist = new ColorRange(backgroundlist).addBrightnessRange(0.6, 0.7).getColors(null, numColors, 0.9);
  backgroundlist.sortByDistance(false);  
}

void generateFigures() {
  for (int i = 0; i < n; i++) {
    PVector p = new PVector (random(5), random(5));
    figures[i].setlocation(p); 
    figures[i].generate();
  }
}
void generateSymbols() {
  for ( int i = 0; i < characters; i++) { 
    s = shapes.get((int)random(nRadicals));
    u = shapes.get((int)random(nRadicals));
    q = shapes.get((int)random(nRadicals));
    p = shapes.get((int)random(nRadicals)); 
    roots.get(i).setPosition(new PVector (random(width*5), random(height*5)));
    float factor = random(0.3, 0.98); 
    roots.get(i).setScale(new PVector (factor, factor));
    roots.get(i).generateStructure(s, p, u, q);
  }
}
void squareswatches(ColorList sorted, int x, int y) {
  noStroke();
  for (int i = 0; i < numColors; i++) {
    TColor c = sorted.get(i);
    squarew = width;
    squareswatch(c, x, y);
    squareh = 10;
    y += squareh;
  }
}

void squareswatch(TColor c, int x, int y) {
  fill(c.toARGB());
  //TColor tc = TColor.newHSV(0.2, 0.6, 0.9);
  //stroke(tc.toARGB());
  noStroke();
  strokeWeight(0.6);
  rect(x, y, squarew, squareh);
}
