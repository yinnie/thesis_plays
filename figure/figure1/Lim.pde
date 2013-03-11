//this is a unit of body part 
//each lim is made out of two joints.  A lim can have children

class Lim extends Nodebase {
  //upper is the main pivot...for now name this the same as vert
  Vert upper;
  //lower is the other flexible joint
  Vert lower;    
  boolean visible;
  Line mline;

  Lim(PVector _p) {
    super();
    //convert pvector to vert
    upper = new Vert(_p);
    lower = new Vert();
    //establish factors
    float mlength = 100;
    float mangle = 0.6;
    visible = true;   
    float strokeweight = 1;
    //initiate line
    mline = new Line(upper, mlength, mangle);
  }
  void render() {  
    if (visible) {  
      mline.drawline();
    }
  }    
  void generate() {
    mline.createline();
    //establish other joint
    lower = mline.getOtherEnd();
  }    
  void setAngle(float a) {
    mline.setAngle(a);
  }
  void setLength(float l) {
    mline.setLength(l);
  }
  void setUpper(Vert v) {
    mline.setOneEnd(v);
  }
  
}

