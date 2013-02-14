//hand drawn lines feel 
//line is made out of vertices 

Line line1, line2;

void setup() {
   size(500, 500);
   smooth();
   Vert v1 = new Vert(new PVector(200, 200));
    Vert v2 = new Vert(new PVector(200, 300));
    Vert v3 = new Vert(new PVector(300, 500));
    line1 = new Line (v1, v2);
    line2 = new Line(v1, v3);

    background(255);
    
    line1.drawline();
    line2.drawline();

    for ( int i = 0; i < 9; i++) {
  println(line1.vertices[i].position);   
    } 
}
