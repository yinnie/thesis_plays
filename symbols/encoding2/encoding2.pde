//encoding test
//if you type in a string such as A14 or AA019 or B0A82, you will get a graphic representation of that encoding
import processing.pdf.*;

Radical glyph;
String encoding;
String inputString;
char letter;
boolean toupdateglyph = false;
Button button, resetbutton;
int buttonx, buttony;

void setup() {

  size( 500, 500);
  background(255);
  smooth(); 
 
  encoding = "BB986";
  glyph = new Radical(encoding);
  inputString="";
  buttonx = 100;
  buttony = 400;
  button = new Button(buttonx, buttony);
  resetbutton = new Button(buttonx, buttony+50);
  textFont(createFont("Helvetica", 36));
}

void draw() {

  background(255);
  if ( toupdateglyph) {
     glyph.update(encoding);
  } 
  println(inputString);
  //draw the glyph 
  pushMatrix();
  translate(100, 100);
  scale(0.4);
  strokeWeight(10);
  glyph.render();
  popMatrix();
  
  button.render();
  resetbutton.render();
  fill(0);
  textSize(16);
  text("save encoding", buttonx+15, buttony+20);
  text("reset", buttonx+15, buttony+70);
}

void mousePressed() {
    //for button 
   if ( button.overRect()) {
     //the string is finished being typed..create the string.and save it
     encoding = inputString;
     toupdateglyph = true;
   }
   if ( resetbutton.overRect()) {
     glyph.clear();
     inputString = "";
     toupdateglyph = false;
   }
}
void keyPressed() {
  if (key =='A' || key =='B' || (key >= '0' && key <= '9')) 
  { 
    letter = key;
    inputString = inputString + key;
  }   
}





