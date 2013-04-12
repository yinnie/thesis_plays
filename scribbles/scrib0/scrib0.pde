import processing.pdf.*;
import geomerative.*;


Button button;
int buttonx, buttony;

void setup() {
  
  size(640, 360);
  background(102);
  buttonx = 100;
  buttony = 300;
  button = new Button(buttonx, buttony);
  
}

void draw() {
  
  stroke(255);
  if (mousePressed == true) {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
  
  button.render();
}

