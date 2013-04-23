
PGraphics pg;
Line mline;

void setup() {
  
  size(500, 500,P2D);
  smooth();
  pg = createGraphics(400, 400, P2D);
  mline = new Line();
   
}

void draw() {
  pg.beginDraw();
  mline.drawline(pg, 50, 100, 200, 40);
  pg.endDraw();
  image ( pg, 0, 0);
  
}



