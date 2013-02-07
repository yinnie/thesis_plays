
class Symbol {
  
int w;
int h;
float startX;
float startY;
float angle1; //angle on the right side of the first stroke
float angle2; //angle on the right side of the 2ndstroke
float angle3; //angle on the right side of the 3rd stroke
float angle4; //angle on the left side of the first stroke
float angle5; //angle on the left side of the 2ndstroke
float angle6; //angle on the left side of the 3rd strokefloat 

Symbol(int x, int y) {
  
 w = 24;
 h = 9;
 startX = x;
 startY = y;
 angle1 = 0;
 angle2 = 0;
 angle3 = 0;
 angle4 = 0;
 angle5 = 0;
 angle6 = 0;
}

void draw() {
  
  line (startX, startY+sin(angle4)*10, startX+w, startY+sin(angle1)*10);
  line (startX, startY+h+sin(angle5)*10, startX+w, startY+h+sin(angle2)*10);
  line (startX, startY+h*2+sin(angle6)*10, startX+w, startY+h*2+sin(angle3)*10);
  
}

void setStartX ( float _startX) {
  startX = _startX;
}

void setStartY (float _startY) {
  startY = _startY;
}

void setAngle1 ( float iAngle) {
  angle1 = iAngle; 
}

void setAngle2 ( float iAngle) {
  angle2 = iAngle; 
}

void setAngle3 ( float iAngle) {
  angle3 = iAngle; 
}
void setAngle4 ( float iAngle) {
  angle4 = iAngle; 
}
void setAngle5 ( float iAngle) {
  angle5 = iAngle; 
}
void setAngle6 ( float iAngle) {
  angle6 = iAngle; 
}

}
