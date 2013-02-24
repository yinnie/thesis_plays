//this is a unit of body part 
//each lim is made out of two joints.  A lim can have children

class Lim extends Nodebase {
    //upper is the main pivot...for now name this the same as vert
    Vert upper;
    //lower is the other flexible joint
    Vert lower;
    float mangle;
    float mlength;
    float strokeweight;    
    boolean haschildren;
    Line mline;
  
    Lim(PVector _p) {
      super();
      //convert pvector to vert
      upper = new Vert(_p);
      lower = new Vert();
      //establish factors
      mlength = 100;
      mangle = 0.6;
      haschildren = false;   
      strokeweight = 1;
      //initiate line
      mline = new Line(upper, mlength, mangle);
    }
      
    void render() {    
      mline.drawline();
    }
    
    void generate() {
      mline.angle = random(-2, 1);
      mline.createline();
      //establish other joint
      lower = mline.getOtherEnd();
    }
  
}
