//generative human figure 
//parts: head, two arms, body, two legs 


Figure[] figures;


int cols = 19;
int rows = 16;
int marginH = 300;
int marginV = 200;
int n = cols*rows;

void setup() {
  size(720, 830);
  smooth();
  
  figures = new Figure[n];
   for ( int j = 0; j < rows; j++) { 
   for ( int i = 0 ; i < cols; i++) {
    PVector p = new PVector (marginH +i*200, marginV +j*300);
     figures[i+i*j] = new Figure (p);
    }
   }
  
}

void draw() {
  background(255);
  for (int i = 0; i < n; i++) {
    figures[i].render();
  }
 
}

void keyPressed() {

  for (int i = 0; i < n; i++) {
    //PVector p = new PVector (random(10), random(10));
    //figures[i].setlocation(p); 
    float f = random(0.8, 1.2);
    PVector s = new PVector (f, f);
    figures[i].setscale(s);
    figures[i].generate();
  }
  
}

