//hand drawn lines feel 
//line is made out of vertices 

Line line1;

void setup() {
  
   size(500, 500);
   smooth();
    Vert v1 = new Vert(new PVector(200, 200));
    float a = random(-1.57, 1.57);
    line1 = new Line (v1, 300, a);
       background(255);
    
    line1.drawline();
   
    int total = line1.getTotalVerts();
    for ( int i = 0; i < total; i++) {
     println(line1.vertices[i].position);   
    } 
}
