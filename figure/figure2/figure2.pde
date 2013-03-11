//generative human figure 
//parts: head, two arms, body, two legs 


Figure[] figures;
int n = 30;

void setup() {
  size(800, 600);
  smooth();
  
  figures = new Figure[n];
  for (int i = 0; i < n; i++) {
    PVector p = new PVector (random(width), random(height));
     figures[i] = new Figure (p);
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
    //PVector p = new PVector (random(width), random(height));
    //figures[i].setlocation(p); 
    float f = random(0.8, 1.2);
    PVector s = new PVector (f, f);
    figures[i].setscale(s);
    figures[i].generate();
  }
 
}

