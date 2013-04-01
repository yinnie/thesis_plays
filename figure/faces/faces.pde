/////////////////HUMAN FACES

int cols = 40;
int rows = 30;
int total;
int marginH = 20;
int marginV = 20;
int seed = 100;
 int cellSize = 80;
 float baseScale = .75;
 
ArrayList<Figure> figures;

void setup() {
  int appWidth = int(cols * cellSize * baseScale);
  int appHeight = int(rows * cellSize * baseScale);
  println( "appWidth: " + appWidth + "\tappHeight: " + appHeight );  
  size( appWidth, 400 );
  smooth();

  total = cols * rows;
  figures = new ArrayList();
 
  for ( int i = 0; i < total; i++) {
    Figure f = new Figure();
    figures.add(f);
  }
  
  
}

void draw() {
  background(255);
  randomSeed(seed);
for ( int j = 0; j < rows; j++) { 
    for ( int i = 0 ; i < cols; i++) {    
      //PVector p = new PVector (marginH +i*cellSize, marginV +j*cellSize);
      PVector p = new PVector ( random(width), random(height/2, height));
      figures.get(i+i*j).setlocation(p);
      PVector s = new PVector ( random(0.5, 0.5), random(0.5, 0.5));
      float r = random(0, 720);
      figures.get(i+i*j).setRotation(r);
      figures.get(i+i*j).setscale(s);
      figures.get(i+i*j).render();
    }
  }  
  
}

void keyPressed() {
  seed = (int) random(1000);
  if ( key == 's' )
    saveFrame();


  if ( key == ' ') {
for ( int j = 0; j < rows; j++) { 
    for ( int i = 0 ; i < cols; i++) {    

      figures.get(i+i*j).generate();
    }
}
  }
}

