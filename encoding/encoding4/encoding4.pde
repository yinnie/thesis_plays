//encoding test. write hashmap to a txt file. read from a txt file to a hashmap
//if you type in a string such as A14 or AA019 or B0A82, you will get a graphic representation of that encoding
import processing.pdf.*;
import java.util.*; //just in case
import controlP5.*;

Radical glyph;
String inputString;  //input for encoding 
String keyword; //the English word we want to encode
String textString; //for translation
boolean encodefinish = false;
boolean inputfinish = false; //for translation
boolean decodeWord = false; 
boolean filewritten = false; //to solve the problem of not saving the current hashmap when closing program NOT through quit button

HashMap words;
PrintWriter output; 
ControlP5 cp5;
PFont font;

void setup() {

  size( 800, 700);
  background(255);
  smooth(); 
  textSize(16);
  words = new HashMap();
  //upload data from old file
  convertFiletoHashmap("wordEncoding.txt");
  //create a new file with the same name so to overwrite
  output = createWriter("wordEncoding.txt");

  inputString = "B06";
  glyph = new Radical(inputString);
  keyword ="";
  textString="";

  initCP5();
  reset();
}

void draw() {

  background(0);
  if ( encodefinish) {
    glyph.update();
  } 
  //draw the glyph
  if ( decodeWord == false) {  
  pushMatrix();
  translate(400, 200);
  scale(1.2);
  strokeWeight(10);
  glyph.render();
  popMatrix();
  }

  if ( decodeWord == true) {
    renderMatchingGlyph(textString);
  }
  drawTextfield();
  //debugText();
}

void renderMatchingGlyph(String s) { 
  String[] input = split(s, ' ');
  
  pushMatrix();
  translate(400, 200);
  scale(0.3);
  for ( int i = 0; i < input.length; i++) {
    String word = input[i];
   if (words.containsKey(word)) {
    Radical r = (Radical) words.get(word);
    translate(100,0);
    r.render();
   }
    else {
    println("cannot find word");
  }
  }
  popMatrix();
}

void reset() {
  glyph.clear();
  inputString = "";
  keyword = "";
  textString = "";
  encodefinish = false;
  inputfinish = false;
}

void convertFiletoHashmap(String s) {
  String[] fileString = loadStrings(s);

  for ( int i = 0; i < fileString.length; i++) {
    String[] pair = split(fileString[i], '\t');
    Radical radical = new Radical(pair[1]);
    words.put(pair[0], radical);
  }
}

void initCP5() {
  //init font first before initiating cp5
  font = createFont("arial", 16);

  cp5 = new ControlP5(this);
  int x = 100;
  int y = 50;
  int w = 200;
  int h = 30;
  int step = 70; //vertical gap
  cp5.addTextfield("input word")
    .setPosition(x, y)
      .setSize(w, h)
        .setFont(font)
          .setFocus(true)
            .setColor(color(255, 0, 0))
              .setAutoClear(false)
                ;
  cp5.addTextfield("enter encoding")
    .setPosition(x, y+step)
      .setSize(w, h)
        .setFont(font)
          .setColor(color(255, 0, 0))
            .setAutoClear(false)
              ;
  cp5.addTextfield("input word to decode")
    .setPosition(x, y+step*2)
      .setSize(w, h)
        .setFont(font)
          .setColor(color(255, 0, 0))
            .setAutoClear(false)
              ;
  cp5.addBang("clear")
    .setPosition(x, y+step*3)
      .setSize(80, h)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
          ; 
  cp5.addBang("quit")
    .setPosition(x, Y+step*5)
      .setSize(80, h)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
          ;
}

void drawTextfield() {
  //for enter keyword
  if(inputfinish) {
  text(cp5.get(Textfield.class, "input word").getText(), 460, 70);
  }
  if(encodefinish) {  //this helps give user indication that her input is recorded
  text(cp5.get(Textfield.class, "enter encoding").getText(), 460, 170);
  }
}

void controlEvent(ControlEvent theEvent) {

  if ( theEvent.isFrom(cp5.getController("input word"))) {
    keyword = theEvent.getStringValue();
    inputfinish = true;
    decodeWord = false;
    encodefinish = false;
  }
  //below have to make sure inputfinish = true..otherwise we encode empty inputs.
  else if (theEvent.isFrom(cp5.getController("enter encoding"))  && inputfinish == true) {
    inputString = theEvent.getStringValue();
    //render the glyph
    encodefinish = true;
    //clear glyph first to remove all the children attached
    glyph.clear();
    glyph.encoding = inputString;
    //allow for next word to be encoded
    inputfinish = false;
    //put this glyph into hashmap
    Radical r = new Radical(inputString);
    words.put(keyword, r);
  } 
  else if (theEvent.isFrom(cp5.getController("input word to decode"))) {
    //clear screen 
    textString = theEvent.getStringValue();
    decodeWord = true;
  }

  println("controlEvent: accessing a string from controller '"
    +theEvent.getName()+"': "
    +theEvent.getStringValue()
    );
}

void clear() {
  cp5.get(Textfield.class, "input word").clear();
  cp5.get(Textfield.class, "enter encoding").clear();
  cp5.get(Textfield.class, "input word to decode").clear();
  decodeWord = false;
  //call reset to clear everything 
  reset();
}

void quit() {
  //write all the data in the hashmap to file 
  Iterator i = words.entrySet().iterator();
  while (i.hasNext ()) {
    Map.Entry me = (Map.Entry)i.next();
    String word = (String)me.getKey();
    Radical r = (Radical)me.getValue();
    output.println(word + "\t" + r.encoding);
  }
  //save data and exit 
  output.flush();
  output.close(); 
  filewritten = true; 
  exit();
}

void debugText() {
  fill(255);
  text("word is " +keyword, 50, 20);
  text("encoding is " +inputString, 50, 50);
  text("entered text is " +textString, 50, 100);
}

void keyPressed() { 
  //debugging use. printing the hashmap
  if ( key == ' ') {
    Iterator i = words.entrySet().iterator();
    while (i.hasNext ()) {
      Map.Entry me = (Map.Entry)i.next();
      String word = (String)me.getKey();
      Radical r = (Radical)me.getValue();
      println(word + "\t" + r.encoding);
    }
  }
}

