//THIS STArted out as generative human figure...but it turned out as of this version..it looks a lot like human faces
//parts: head, two arms, body, two legs



/////////////////HUMAN FACES


Figure figure;

void setup() {
  size(600, 400);
  smooth();
  PVector p = new PVector (0, 0);
  figure = new Figure (p);
  figure.setlocation(new PVector(100, 100));
}

void draw() {
  background(255);

  figure.render();
}

void keyPressed() {
  figure.generate();
}

