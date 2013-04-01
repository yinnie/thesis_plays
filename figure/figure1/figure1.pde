//generative human figure 
//parts: head, two arms, body, two legs 

Figure[] figures;

void setup() {
  size(400, 300);
  smooth();
  
  figures = new Figure[10];
  for (int i = 0; i < 10; i++) {
    PVector p = new PVector (random(width), random(height));
     figures[i] = new Figure (p);
  }
}

void draw() {
  background(255);
  for (int i = 0; i < 10; i++) {
    figures[i].render();
  }
}

void keyPressed() {
  if ( key == ' '){
  for (int i = 0; i < 10; i++) {
    //PVector p = new PVector (random(width), random(height));
    //figures[i].setlocation(p); 
    figures[i].generate();
  }
  }
}

