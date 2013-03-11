/////////////////HUMAN FACES

int cols = 10;
int rows = 15;
int total;
int marginH = 50;
int marginV = 40;
ArrayList<Figure> figures;

void setup() {
  size(720, 830);
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
  
for ( int j = 0; j < rows; j++) { 
    for ( int i = 0 ; i < cols; i++) {    
      PVector p = new PVector (marginH +i*70, marginV +j*70);

      figures.get(i+i*j).setlocation(p);
      figures.get(i+i*j).setscale(new PVector(0.65, 0.65));
      figures.get(i+i*j).render();
    }
  }  
  
}

void keyPressed() {

  if ( key == ' ') {
for ( int j = 0; j < rows; j++) { 
    for ( int i = 0 ; i < cols; i++) {    

      figures.get(i+i*j).generate();
    }
}
  }
}

