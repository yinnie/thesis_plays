//generative human figure 
//parts: head, two arms, body, two legs 

Figure figure;

void setup() {
  size(600, 400);
  smooth();
  PVector p = new PVector (width/2, height/2);
  figure = new Figure (p);
}

void draw() {
  background(255);
  
  figure.render();
 
}

void keyPressed() {
    figure.generate();
}
  
