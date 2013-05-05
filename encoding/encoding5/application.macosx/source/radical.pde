//class to hold the glyph structure

class Radical extends Nodebase {

  PVector mScale, mRotation, mPosition;
  TShape mShape;
  String encoding;
  
  Radical(String _encoding) {
    super();
    encoding = _encoding;
    mScale = new PVector (1.0, 1.0);
    mPosition = new PVector (0.0, 0.0);
    mRotation = new PVector (0.0, 0.0);
    mShape = new TShape();
    
    update();
  }
  
  Radical() {
    super();
    mScale = new PVector (1.0, 1.0);
    mPosition = new PVector (0.0, 0.0);
    mRotation = new PVector (0.0, 0.0);
    mShape = new TShape();
  }
 
  void setShape(int input) {
    mShape.setDrawType(input);
  }
  
  void setEncoding(String _c) {
    encoding = _c;
  }
  
  void randomize() {
    //randomly generate an encoding
    int p = (int)random(0,4);
     float prob1 = random(1);
    String letter1 ="A";
    if(prob1>0.5) letter1 = "A";
    if(prob1<=0.5) letter1 = "B";
    float prob2 = random(1);
    String letter2 ="A";
    if(prob2>0.5) letter2 = "A";
    if(prob2<=0.5) letter2 = "B";
    float prob3 = random(1);
    String letter3="A";
    if(prob3>0.5) letter3 = "A";
    if(prob3<=0.5) letter3 = "B";
    int number1 = (int)random(10);
    int number2 = (int)random(10);
    int number3 = (int)random(10);

    switch(p) {
      case 0: //one layer
      encoding = letter1+str(number1) + str(number2);
      break;
      case 1: //2 layers..only one has sublayer
      encoding = letter1 +letter2+str(number1) + str(number2)+str(number3);
      break;
      case 2: //2 layers..only one has sublayer
      encoding = letter1 +str(number1) +letter2+str(number2)+str(number3);
      break;
      case 3:
      encoding = letter1 +letter2 +str(number1) +str(number2)+letter3+str(number3)+str(number1);
      break;
    }
  }
  
  void render() {  

    noFill();
    stroke(255); 
    pushMatrix();
    translate(mPosition.x, mPosition.y);
    scale(mScale.x, mScale.y);  
    //it a radical has children, do not draw the shape but carry out transformations
    if ( mShape!= null && hasChildren == false) {
      mShape.render();
    }

    int numChildren = getChildCount();
    for ( int i = 0; i < numChildren; i++) {
      if ( getChild(i) != null) {
        strokeWeight(16);
        getChild(i).render();
      }
    }    
    popMatrix();
  }
  
  void update() {
    
    if(encoding.length() > 7) {
    println(" your text input is too long. Keep it under 7 characters");
  }
  
  if( encoding.length() == 1 ) {
    char c = encoding.charAt(0);
    int type = (int)c;
     setShape(type);
  }  
  
  if ( encoding.length() == 3) {
    //i.e. A02 or B85
     if(encoding.charAt(0) == 'A') {
       
       //char is already an integer..for numbers '0' is 48..'9'is 57
       int l= encoding.charAt(1) - 48;
       int r = encoding.charAt(2) - 48;
       leftright(l, r);
     }
     if(encoding.charAt(0) == 'B') {
       int m = encoding.charAt(1) - 48;
       int n = encoding.charAt(2) - 48;
        topbottom(m, n);
     }
  }

   if ( encoding.length() == 5 ) {
      if(encoding.charAt(0) == 'A') {
        leftright();
      }
      else if(encoding.charAt(0) == 'B') {
        topbottom();
      }
      
      if(encoding.charAt(1) == 'A' || encoding.charAt(1) == 'B') {
         int thetype = encoding.charAt(4) - 48;
         getChild(1).setShape(thetype);
         
         if (encoding.charAt(1) == 'A' ) {
             int l = encoding.charAt(2) - 48;
             int r = encoding.charAt(3) -48;
             getChild(0).leftright(l, r);
         }
         else if (encoding.charAt(1) == 'B' ) {
             int t = encoding.charAt(2) -  48;
             int b = encoding.charAt(3) - 48;
             getChild(0).topbottom(t, b);
         } 
            
      }
      else if ( encoding.charAt(1) >= '0' && encoding.charAt(1) <= '9') {
           int type = encoding.charAt(1) - 48;
           getChild(0).setShape(type);
           
            if (encoding.charAt(2) == 'A' ) {
             int l = encoding.charAt(3) - 48;
             int r = encoding.charAt(4) - 48;
             getChild(1).leftright(l, r);
         }
         else if (encoding.charAt(2) == 'B' ) {
             int t = encoding.charAt(3) - 48;
             int b = encoding.charAt(4) -48;
             getChild(1).topbottom(t, b);
         }     
      }
   }
   
   if (encoding.length() == 7 ) {
     if(encoding.charAt(0) == 'A') {
        leftright();
      }
      else if(encoding.charAt(0) == 'B') {
        topbottom();
      }
      if(encoding.charAt(1) =='A') {
        int l = encoding.charAt(2) - 48;
        int r = encoding.charAt(3) - 48;
        getChild(0).leftright(l, r);
      }
      if(encoding.charAt(1) =='B') {
        int t = encoding.charAt(2) - 48;
        int b = encoding.charAt(3) - 48;
        getChild(0).topbottom(t, b);
      }
      if(encoding.charAt(4) =='A') {
        int l = encoding.charAt(5) - 48;
        int r = encoding.charAt(6) - 48;
        getChild(1).topbottom(l, r);
      }
      if(encoding.charAt(4) =='B') {
        int t = encoding.charAt(5) - 48;
        int b = encoding.charAt(6) - 48;
        getChild(1).topbottom(t, b);
      }
   }  
  }
  
  void leftright() { 
    //structure of this node is left right
    Radical left = new Radical();
    Radical right = new Radical();
    addChild(left);
    addChild(right);
  }
  
  void leftright(int p, int q) { 
    //structure of this node is left right
    Radical left = new Radical();
    Radical right = new Radical();
    addChild(left);
    addChild(right);
    left.setShape(p);
    right.setShape(q);
  }

  void topbottom() {
    Radical top = new Radical();
    Radical bottom = new Radical();
    addChild(top);
    addChild(bottom);
    top.setScale(new PVector (0.6, 0.6));
    bottom.setScale(new PVector (0.6, 0.6));
    bottom.setPosition(new PVector (35, 60));
    top.setPosition(new PVector (35, 30));
  }
  
  void topbottom(int p, int q) {
    Radical top = new Radical();
    Radical bottom = new Radical();
    addChild(top);
    addChild(bottom);
    top.setShape(p);
    bottom.setShape(q);
    top.setScale(new PVector (0.6, 0.6));
    bottom.setScale(new PVector (0.6, 0.6));
    bottom.setPosition(new PVector (35, 60));
    top.setPosition(new PVector (35, 30));
  }
  
 
  Radical getChild(int index) {
    if ( index >= 0 && index < children.size() ) {
      return (Radical)children.get(index);
    }
    else return null;
  }
  
  void setScale(PVector _scale) {
    mScale.set( _scale);
  }

  void setPosition(PVector _value) {
    mPosition.set(_value);
  }

  void setRotation(PVector _value) {
    mRotation.set(_value);
  }

}

