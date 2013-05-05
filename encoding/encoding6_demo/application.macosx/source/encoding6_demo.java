import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.pdf.*; 
import java.util.*; 
import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class encoding6_demo extends PApplet {

//encoding test. write hashmap to a txt file. read from a txt file to a hashmap
//if you type in a string such as A14 or AA019 or B0A82, you will get a graphic representation of that encoding
//how to export 

 //just in case


Radical glyph;
String inputString;  //input for encoding 
String[] stringarray; // for encoding with specific number of letters
int numLetters;
String string0; //represent the main structure (i.e.g4) when double layerdd
String group2string, group2string0, group2string1, group2string2;  //group2 i.e.child0.  0 is structure. 1 is first number 2 is second numbr
String group3string, group3string0, group3string1, group3string2; //group3 i.e.child1
String keyword; //the English word we want to encode
String textString; //for translation
String textString0;
String textString1;
String textString2;
boolean encodefinish = false;
boolean inputfinish = false; //for translation
boolean decodeWord = false; 
boolean showEnterCodeField = false; //show the Enter Code method text field for encoding
boolean showLayerChoise = false;
boolean showg1 = false;
boolean showg2g3 = false; //show g2g3g4 all three are together

HashMap words;
PrintWriter output; 
ControlP5 cp5;
DropdownList drop0, dropLayers; //drop0 is for encode methods
PFont font;
boolean encodingState = true;  //false will be decoding state
PGraphics pg; 
Textarea myTextarea;
String textareastring;
boolean showPoetry = false;

public void setup() {

  size( 900, 800, P2D);
  background(255);
  smooth(); 
  pg = createGraphics(250, 250, P2D);
  textSize(28);
  words = new HashMap();
  //upload data from old file
  convertFiletoHashmap("wordEncoding0.txt");
  //create a new file with the same name so to overwrite
  output = createWriter("data/wordEncoding1.txt");

  inputString = "B06";
  glyph = new Radical(inputString);
  numLetters = 3; //as a default
  stringarray = new String[numLetters];
  string0 = "A";  
  group2string = "";
  group3string = "";
  group2string0 = "";
  group2string1 = "";
  group2string2 = "";
  group3string0 = "";
  group3string1 = "";
  group3string2 = "";
  keyword ="";
  textString="";
  textString0="";
  textString1="";
  textString2="";
  initCP5();
  reset();
  textareastring ="";
}

public void draw() {

  background(0);
  //encode state
  if (encodingState) {
    cp5.getController("input word").show();
    myTextarea.hide();
    cp5.getController("input word to decode").hide();
    cp5.getController("poetry1").hide();
    cp5.getController("poetry2").hide();
    cp5.getController("poetry3").hide();
    drop0.show();
    if (showEnterCodeField == true) {
      cp5.getController("enter encoding").show();
    }
    else if (showEnterCodeField == false) {
      cp5.getController("enter encoding").hide();
    } 

    if ( showLayerChoise == true ) {
      dropLayers.show();
    }
    else if (showLayerChoise == false) {
      dropLayers.hide();
    }

    if (showg1)  cp5.getGroup("g1").show();
    else if (showg1 == false) cp5.getGroup("g1").hide();

    if (showg2g3) { 
      cp5.getGroup("g2").show();
      cp5.getGroup("g3").show();
      cp5.getGroup("g4").show();
    }
    else if (showg2g3 == false) { 
      cp5.getGroup("g2").hide();
      cp5.getGroup("g3").hide();
      cp5.getGroup("g4").hide();
    }

    if ( encodefinish) {
      glyph.update();
    } 
    //draw the glyphas

    if ( decodeWord == false) {  
      //initiate pg 
      pg.beginDraw();
      pg.background(0);
      pg.stroke(255);
      glyph.render(pg);
      pg.endDraw();
      image ( pg, 500, 50);
    }

    drawTextfield();
  }
  if (!encodingState) {
    cp5.getController("input word").hide();
    cp5.getController("enter encoding").hide();
    drop0.hide();

    if (showPoetry == true) {
      myTextarea.show();
      //render the text box
      renderMatchingGlyphPoem(myTextarea.getStringValue(), 100);

      cp5.getController("input word to decode").hide();
      cp5.getController("poetry1").hide();
      cp5.getController("poetry2").hide();
      cp5.getController("poetry3").hide();
    }
    else if ( showPoetry == false) {
      myTextarea.hide();
      cp5.getController("input word to decode").show();
      cp5.getController("poetry1").show();
      cp5.getController("poetry2").show();
      cp5.getController("poetry3").show();
    }

    if ( decodeWord == true) {
      renderMatchingGlyph(textString, 200);
      renderMatchingGlyph(textString0, 300);
      renderMatchingGlyph(textString1, 400);
      renderMatchingGlyph(textString2, 500);
    }
  }
}

public void renderMatchingGlyphPoem(String s, int h) { 
  String[] input = split(s, ' ');

  pushMatrix();
  translate(300, h);
  scale(0.25f);
  int cols = 6;
  int rows = (int)input.length/cols;
  for ( int j = 0; j < rows; j++) {
    translate(0, 300);
    pushMatrix();
    for ( int i = 0; i < cols; i++) {
      String word = input[i+j*rows];

      if (words.containsKey(word)) {
        Radical r = (Radical) words.get(word);

        translate(200, 0);
        r.render(this.g);
      }    
      else {
        println("cannot find word");
      }
    }
    popMatrix();
  }
  popMatrix();
}

public void renderMatchingGlyph(String s, int h) { 
  String[] input = split(s, ' ');

  pushMatrix();
  translate(300, h);
  scale(0.35f);
  for ( int i = 0; i < input.length; i++) {
    String word = input[i];
    if (words.containsKey(word)) {
      Radical r = (Radical) words.get(word);
      translate(200,0);
      r.render(this.g);
    }
    else {
      println("cannot find word");
    }
  }
  popMatrix();
}

public void reset() {
  glyph.clear();
  inputString = "";
  keyword = "";
  textString = "";
  textString0 = "";
  textString1 = "";
  textString2 = "";
  encodefinish = false;
  inputfinish = false;
}

public void convertFiletoHashmap(String s) {
  String[] fileString = loadStrings(s);

  for ( int i = 0; i < fileString.length; i++) {
    String[] pair = split(fileString[i], '\t');

    if (pair[1]!= null) {
      Radical radical = new Radical(pair[1]);
      words.put(pair[0], radical);
    }  
    else { 
      println(" error converting to hashmap");
    }
  }
}

public void initCP5() {
  //init font first before initiating cp5
  font = createFont("arial", 16);

  cp5 = new ControlP5(this);
  int x = 50;
  int y = 220;
  int w = 110;
  int h = 20;
  int step = 70; //vertical gap

  cp5.addButton("Encode")
    .setPosition(x, y-50)
      .setSize(80, h)
        .setColorBackground(color(60))
          .setColorForeground(color(95))
            ;
  cp5.addButton("Decode")
    .setPosition(x+80, y-50)
      .setSize(80, h)
        .setColorBackground(color(60))
          .setColorForeground(color(95))
            ;
  cp5.addTextfield("input word")
    .setPosition(x, y)
      .setSize(w, h)
        .setFont(font)
          .setFocus(true)
            .setColor(color(255, 0, 0))
              .setAutoClear(false)
                .setColorBackground(color(60))
                  .setColorForeground(color(95))
                    ;

  cp5.addTextfield("input word to decode")
    .setPosition(x, y)
      .setSize(w*2, h)
        .setFont(font)
          .setColor(color(255, 0, 0))
            .setColorBackground(color(60))
              .setColorForeground(color(95))
                .setAutoClear(false)
                  ;
  cp5.addTextfield("poetry1")
    .setPosition(x, y+step)
      .setSize(w*2, h)
        .setFont(font)
          .setColor(color(255, 0, 0))
            .setColorBackground(color(60))
              .setColorForeground(color(95))
                .setAutoClear(false)
                  ;
  cp5.addTextfield("poetry2")
    .setPosition(x, y+step*2)
      .setSize(w*2, h)
        .setFont(font)
          .setColor(color(255, 0, 0))
            .setColorBackground(color(60))
              .setColorForeground(color(95))
                .setAutoClear(false)
                  ;
  cp5.addTextfield("poetry3")
    .setPosition(x, y+step*3)
      .setSize(w*2, h)
        .setFont(font)
          .setColor(color(255, 0, 0))
            .setColorBackground(color(60))
              .setColorForeground(color(95))
                .setAutoClear(false)
                  ;

  myTextarea = cp5.addTextarea("txt")
    .setPosition(x, y)
      .setSize(200, 200)
        .setFont(createFont("arial", 12))
          .setLineHeight(14)
            .setColor(color(128))
              .setColorBackground(color(255, 100))
                .setColorForeground(color(255, 100));
  ;
  myTextarea.setText("call die happy die know not"
    +"have ear open say own wrong"
    +"tell all talk not draw dog"
    +"far is find a slow day"
    +"say red are you open ballon "
    +"work something I catch next ruin "
    + "you go time my female have come" 
    );

  cp5.addBang("clear")
    .setPosition(x, y+step*5)
      .setSize(80, h)
        .setColorBackground(color(60))
          .setColorForeground(color(95))
            .setLabel("save and clear")
              .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
                ; 
  cp5.addBang("quit")
    .setPosition(x, y+step*6)
      .setSize(80, h)
        .setColorBackground(color(60))
          .setColorForeground(color(95))
            .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
              ;
  drop0 = cp5.addDropdownList("methods")
    .setPosition(x, y+step)
      ;
  customize(drop0);
  dropLayers = cp5.addDropdownList("layers")
    .setPosition(x+130, y+step)
      ;
  customizeDropLayer(dropLayers);

  cp5.addTextfield("enter encoding")
    .setPosition(x+130, y+step-20)
      .setSize(110, h)
        .setFont(font)
          .setColor(color(255, 0, 0))
            .setColorBackground(color(60))
              .setColorForeground(color(95))
                .setAutoClear(false)
                  ;
  //g1 is single layer structred glyphs               
  Group g1 = cp5.addGroup("g1")
    .setPosition(x+280, y+step)
      .setWidth(500)
        .setHeight(15)
          .setLabel("Single Layer Glyphs")
            .setColorBackground(color(60))
              //.setColorForeground(color(95))
              .setBackgroundHeight(300)

                ;
  cp5.addSlider("slider10")
    .setPosition(120, 30)
      .setSize(300, 16)
        .setRange(0, 9) // values can range from big to small as well
          .setNumberOfTickMarks(10)
            .setSliderMode(Slider.FLEXIBLE)
              .setGroup(g1)
                ;
  cp5.addSlider("slider11")
    .setPosition(120, 70)
      .setSize(300, 16)
        .setRange(0, 9) // values can range from big to small as well
          .setNumberOfTickMarks(10)
            .setSliderMode(Slider.FLEXIBLE)
              .setGroup(g1)
                ;

  cp5.addRadioButton("radio1")
    .setPosition(10, 10)
      .setSize(20, 20)
        .addItem("LR", 0)
          .addItem("TB", 1)
            .setGroup(g1)
              ;             

  //g2 is first child of double structured glyphs             
  Group g2 = cp5.addGroup("g2")
    .setPosition(x+280, y+step+100)
      .setWidth(500)
        .setHeight(15)
          .setLabel("sub-layer 1")
            .setColorBackground(color(60))
              .setBackgroundHeight(300)

                ;
  cp5.addSlider("slider20")
    .setPosition(120, 30)
      .setSize(300, 16)
        .setRange(0, 9) // values can range from big to small as well
          .setNumberOfTickMarks(10)
            .setSliderMode(Slider.FLEXIBLE)
              .setGroup(g2)
                ;
  cp5.addSlider("slider21")
    .setPosition(120, 70)
      .setSize(300, 16)
        .setRange(0, 9) // values can range from big to small as well
          .setNumberOfTickMarks(10)
            .setSliderMode(Slider.FLEXIBLE)
              .setGroup(g2)
                ;

  cp5.addRadioButton("radio2")
    .setPosition(10, 30)
      .setSize(20, 20)
        .addItem("Left/Right", 0)
          .addItem("Top/Bottom", 1)
            .addItem("None", 2)
              .setGroup(g2)
                ;             
  //g3 is second child of double structred glyphs               
  Group g3 = cp5.addGroup("g3")
    .setPosition(x+280, y+step+250)
      .setWidth(500)
        .setHeight(15)
          .setLabel("sub-layer 2")
            .setColorBackground(color(60))
              .setBackgroundHeight(300)

                ;
  cp5.addSlider("slider30")
    .setPosition(120, 30)
      .setSize(300, 16)
        .setRange(0, 9) // values can range from big to small as well
          .setNumberOfTickMarks(10)
            .setSliderMode(Slider.FLEXIBLE)
              .setGroup(g3)
                ;
  cp5.addSlider("slider31")
    .setPosition(120, 70)
      .setSize(300, 16)
        .setRange(0, 9) // values can range from big to small as well
          .setNumberOfTickMarks(10)
            .setSliderMode(Slider.FLEXIBLE)
              .setGroup(g3)
                ;

  cp5.addRadioButton("radio3")
    .setPosition(10, 30)
      .setSize(20, 20)
        .addItem("Left.Right", 0)
          .addItem("Top.Bottom", 1)
            .addItem("none", 2)
              .setGroup(g3)
                ;  

  //g4 is the little group that chooses main structure of 2-layer glyphs              
  Group g4 = cp5.addGroup("g4")
    .setPosition(x+280, y+step)
      .setBackgroundHeight(100)
        .setWidth(100)
          .setHeight(15)
            .setLabel("main structure")
              .setColorBackground(color(60))

                ;   
  cp5.addRadioButton("radioMain")
    .setPosition(10, 10)
      .setSize(80, 20)
        .addItem("Left / Right", 0)
          .addItem("Top / Bottom", 1)
            .setGroup(g4)
              ;
}

public void savePNG() {
  pg.save(frameCount + ".png");
}

public void drawTextfield() {
  //for enter keyword
  if (inputfinish) {
    text(cp5.get(Textfield.class, "input word").getText(), 350, 120);
  }
  if (encodefinish) {  //this helps give user indication that her input is recorded
    text(inputString, 350, 220);
  }
}

public void Encode() {
  encodingState = true;
}
public void Decode() {
  encodingState = false;
}

public void customize(DropdownList ddl) {
  ddl.setBackgroundColor(color(255));
  ddl.setItemHeight(25);
  ddl.setBarHeight(15);
  ddl.captionLabel().set("select method");
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  ddl.addItem("randomize", 0);
  ddl.addItem("enter code", 2);
  ddl.addItem("design", 1);
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorForeground(color(95));
}

public void customizeDropLayer(DropdownList ddl) {
  ddl.setBackgroundColor(color(255));
  ddl.setItemHeight(25);
  ddl.setBarHeight(15);
  ddl.captionLabel().set("number of layers");
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  ddl.addItem("1 layer", 0);
  ddl.addItem("2 layers", 1);
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorForeground(color(95));
}

public void controlEvent(ControlEvent theEvent) {
  //check group first
  if ( theEvent.isGroup()) {

    if ( theEvent.getGroup().getName() == "methods") {
      //for the dropdown list of encode methods
      if (theEvent.getGroup().getValue() == 0) {
        showEnterCodeField = false;
        showLayerChoise = false;
        showg1 = false;
        glyph.clear();
        glyph.randomize();
        inputString = glyph.encoding;
        encodefinish = true;
      }
      else if (theEvent.getGroup().getValue() == 2 ) {
        showEnterCodeField = true;
        showLayerChoise = false;
        showg1 = false;
        glyph.clear();
        glyph.encoding = "";
        inputString ="";
      }
      else if (theEvent.getGroup().getValue() == 1) {
        showEnterCodeField = false;
        showLayerChoise = true;
        encodefinish = true;
        glyph.clear();
        glyph.encoding = "";
        inputString ="";
      }
    }

    else if (theEvent.getGroup().getName() == "layers") {
      if (theEvent.getGroup().getValue() == 0) {
        showg1 = true;
        showg2g3 = false;
      }
      else if (theEvent.getGroup().getValue() == 1) {
        showg1 = false;
        showg2g3 = true;
      }
    }
    else if (theEvent.getGroup().getName() == "g2") {
      //construct the string1
    }
    else if (theEvent.getGroup().getName() == "g2") {
      //construct the string2
      //append string2 and string1 to string0 
      //make a new string out of the resulting string array
      //set inputString to this string ..update the glyph
    }
  }
  else if ( theEvent.isController()) {

    if ( theEvent.isFrom(cp5.getController("input word"))) {
      keyword = theEvent.getStringValue();
      inputfinish = true;
      decodeWord = false;
      encodefinish = false;
    }
    //below have to make sure inputfinish = true..otherwise we encode empty inputs. but there are problems of
    //having one word already entered...and then entering multiple codings..so omit for now
    else if (theEvent.isFrom(cp5.getController("enter encoding"))) {
      inputString = theEvent.getStringValue();
      //render the glyph
      encodefinish = true;
      //clear glyph first to remove all the children attached
      glyph.clear();
      glyph.encoding = inputString;
      //allow for next word to be encoded
      //inputfinish = false;
    } 
    else if (theEvent.isFrom(cp5.getController("input word to decode"))) {
      //clear screen 
      textString = theEvent.getStringValue();
      decodeWord = true;
    }
    else if (theEvent.isFrom(cp5.getController("poetry1"))) {
      //clear screen 
      textString0 = theEvent.getStringValue();
      decodeWord = true;
    }
    else if (theEvent.isFrom(cp5.getController("poetry2"))) {
      //clear screen 
      textString1 = theEvent.getStringValue();
      decodeWord = true;
    }
    else if (theEvent.isFrom(cp5.getController("poetry3"))) {
      //clear screen 
      textString2 = theEvent.getStringValue();
      decodeWord = true;
    }
  }
  println("controlEvent: accessing a string from controller '"
    +theEvent.getName()+"': "
    +theEvent.getStringValue()
    );
}
//radio button for single layer structure
public void radio1(int a) {
  println("a radio Button event: "+a);
  //clear the glyph so the rendering above of is the current glyph
  glyph.clear();
  if (a == 0) {
    //we know stringarray has only 3 elements
    stringarray[0] = "A";
    inputString = stringarray[0]+stringarray[1]+stringarray[2];
    glyph.encoding = inputString;
  } 
  if ( a ==1) {
    stringarray[0] = "B";
    inputString = stringarray[0]+stringarray[1]+stringarray[2];
    glyph.encoding = inputString;
  }
}
//make a function that updates the string when there are two layers
public void updateString () {
  group2string = group2string0 + group2string1 + group2string2;
  group3string = group3string0 + group3string1 + group3string2;
  inputString = string0 + group2string + group3string;
  glyph.encoding = inputString;
}
//radio button for main structure of a double layers
public void radioMain(int a) {
  glyph.clear();
  //get downt eh first part of final string
  if (a == 0) {
    string0 = "A";
    updateString();
  } 
  else if ( a == 1) {
    string0 = "B";
    updateString();
  }
}

public void radio2(int a) {
  glyph.clear();
  //this first contributes to group2string
  if (a == 0) {
    group2string0 = "A";
    updateString();
    cp5.getController("slider21").show();
    group2string2 = "0"; //just so it is not empty
  } 
  if ( a ==1) {
    group2string0 = "B";
    cp5.getController("slider21").show();
    group2string2 = "0";
    updateString();
  }
  if ( a ==2) {
    //choosing to have no structure in the child..
    //deactivates one of the sliders so user can only choose one number
    cp5.getController("slider21").hide();
    group2string0 = "";
    group2string2 = ""; //set the second slider bar to nothing..otherwise it retains previous value
    updateString();
  }
} 

public void radio3(int a) {
  glyph.clear();
  //this first contributes to group2string
  if (a == 0) {
    group3string0 = "A";
    cp5.getController("slider31").show();
    group3string2 = "0";
    updateString();
  } 
  if ( a ==1) {
    group3string0 = "B";
    cp5.getController("slider31").show();
    group3string2 = "0";
    updateString();
  }
  if ( a ==2) {
    //choosing to have no structure in the child..
    //deactivates one of the sliders so user can only choose one number
    cp5.getController("slider31").hide();
    group3string2 = "";
    group3string0 = "";
    updateString();
  }
}

//sliders
public void slider10(int number) {
  glyph.clear();
  stringarray[1] = str(number);
  inputString = stringarray[0]+stringarray[1]+stringarray[2];
  glyph.encoding = inputString;
}
public void slider11(int number) {
  glyph.clear();
  stringarray[2] = str(number);
  inputString = stringarray[0]+stringarray[1]+stringarray[2];
  glyph.encoding = inputString;
}
// for group 2 
public void slider20(int number) {
  glyph.clear();
  group2string1 = str(number);
  updateString();
}

public void slider21(int number) {
  glyph.clear();
  group2string2 = str(number);
  updateString();
}
public void slider30(int number) {
  glyph.clear();
  group3string1 = str(number);
  updateString();
}

public void slider31(int number) {
  glyph.clear();
  group3string2 = str(number);
  updateString();
}

public void clear() {
  //first save to hashmap 
  //put this glyph into hashmap
  Radical r = new Radical(inputString);
  words.put(keyword, r);
  //then clear
  cp5.get(Textfield.class, "input word").clear();
  cp5.get(Textfield.class, "enter encoding").clear();
  cp5.get(Textfield.class, "input word to decode").clear();
  cp5.get(Textfield.class, "poetry1").clear();
  cp5.get(Textfield.class, "poetry2").clear();
  cp5.get(Textfield.class, "poetry3").clear();
  decodeWord = false;
  showEnterCodeField = false;
  showLayerChoise = false;
  showg1 = false;
  showg2g3 = false;
  //save png 
  savePNG();
  //call reset to clear everything 
  reset();
}

public void saveHashmap() {
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
  output.close(); //close is not necessary if you flush
}

public void quit() {
  saveHashmap();
  exit();
}

public void keyPressed() { 
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
  if ( key == 'z') {
    showPoetry = !showPoetry;
     clear();
  }
  //if ( key == '1' ) {
    //savePNG();
  //} 
}


class Nodebase {
  
  Nodebase parent;
  ArrayList<Nodebase> children;
  String name;
  boolean hasChildren;
  
  Nodebase() {
    parent = null;  //default is root node
    name = "unnamed";
    children = new ArrayList();
    hasChildren = false;
  }
  
  public void addChild (Nodebase mChild) {
    mChild.setParent(this);
    children.add(mChild);
    hasChildren = true;
  }  
  
  public void clear() {
    //remove all children
    for ( int i = 0; i < children.size(); i++){
      children.get(i).clear();
    }
     children.clear();
  }
  /*
  Nodebase getChild(int index) {
    if( index >= 0 && index < children.size() ) {
    return children.get(index);
    }
    else return null;
  }
  */
  public int getChildCount() {
    return children.size();
  }
    
  public void render() {
    // stub method 
  }  
     
  public void setParent(Nodebase mParent) {
      parent = mParent;
  }
  
  public void setName(String _name) {
    name = _name;
  }
}

//strokes class
//in a square of 200x200, all strokes start at (0, 0) unless there is an offset

class TShape {

  int drawType;  //the chosen shape type to draw
  int l = 200;  // this is grid size
  int totalStrokes = 9;
  
  TShape(int _drawType) {
    drawType = _drawType;
  }
  TShape () {
    drawType = 100;
  }
  
  public void setDrawType( int n) {
    drawType = n;
  }
  
  public void render(PGraphics g) {
    
    strokeWeight(12);
    switch ( drawType) {
      case (0):
      //vertical line on left edge of the block
      g.line(l/4, 0, l/4, l);
      break; 
      case (1):
      //diagnol half size of (diagnol bottom left corner to right up corner)
      g.line(0, l, l*0.5f, l*0.5f);
      case (2): 
      //diagnol top left corner to bottom right corner
      g.line(0, 0, l, l);
      break;    
      case (3):
      //diagnol half size of (diagnol top left corner to bottom right corner) but starting at second half of the block
      g.line(l/2, 0, l, l/2);
      break;   
      case (4):
      g.arc(l/2, l/2, l/2, l/2, PI, PI*1.5f);
      break;  
      case(5):
      g.arc(l/2, l/2, l/2, l/2, 0, PI*0.5f);
      break; 
      case(6):
      //horizontal line
      g.line(0, l/4, l, l/4);
     break; 
      case(7):
      // two lines half size of case 0 and on the right edge of the block
      g.line(l, l*0.5f, l/2, l);
     break;
     case(8):
      g.fill(255);
      g.ellipse(l*0.75f, l*0.25f, l/8, l/8);
     break; 
      case (9):
      //a quarter of an arc at top left quadrant
      g.arc(l/2, l/2, l, l, PI*1.5f, TWO_PI);
      break;
     case (10):
      // a line half size of case 0 and in the middle of the square
      g.line(l*0.5f, l*0.5f, l*0.5f, l);
      break;
     case (11):
      //diagnol bottom left corner to right up corner
      g.line(0, l, l, 0);
      break;
       case (12):
      //diagnol half size of diagnol top left corner to bottom right corner
      g.line(0, 0, l*0.5f, l*0.5f);
      break;
       case (13):
      // looks like this / but only at top left quadrant of the block
      g.line(0, l*0.5f, l*0.5f, 0);
      break;
      case (14):
      g.arc(0, l/2, l/2, l/2, 0, HALF_PI);
      break;
 
       case(15):
     // a line half size of case 13
     g.line(0, 0, l*0.5f, 0);
     break;
     case(16):
      g.fill(0);
      g.ellipse(l*0.75f, l*0.25f, l/4, l/4);
     break; 
     default:
     println(" no shape to draw");
     break;
     
    }
    
  }
}

//class to hold the glyph structure

class Radical extends Nodebase {

  PVector mScale, mRotation, mPosition;
  TShape mShape;
  String encoding;
  
  Radical(String _encoding) {
    super();
    encoding = _encoding;
    mScale = new PVector (1.0f, 1.0f);
    mPosition = new PVector (25.0f, 25.0f);
    mRotation = new PVector (0.0f, 0.0f);
    mShape = new TShape();
    
    update();
  }
  
  Radical() {
    super();
    mScale = new PVector (1.0f, 1.0f);
    mPosition = new PVector (0.0f, 0.0f);
    mRotation = new PVector (0.0f, 0.0f);
    mShape = new TShape();
  }
 
  public void setShape(int input) {
    mShape.setDrawType(input);
  }
  
  public void setEncoding(String _c) {
    encoding = _c;
  }
  
  public void randomize() {
    //randomly generate an encoding
    int p = (int)random(0,4);
     float prob1 = random(1);
    String letter1 ="A";
    if(prob1>0.5f) letter1 = "A";
    if(prob1<=0.5f) letter1 = "B";
    float prob2 = random(1);
    String letter2 ="A";
    if(prob2>0.5f) letter2 = "A";
    if(prob2<=0.5f) letter2 = "B";
    float prob3 = random(1);
    String letter3="A";
    if(prob3>0.5f) letter3 = "A";
    if(prob3<=0.5f) letter3 = "B";
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
  
  public void render(PGraphics g) {  

    g.noFill();
    g.stroke(255); 
    g.pushMatrix();
    g.translate(mPosition.x, mPosition.y);
    g.scale(mScale.x, mScale.y);  
    //it a radical has children, do not draw the shape but carry out transformations
    if ( mShape!= null && hasChildren == false) {
      mShape.render(g);
    }
    
    int numChildren = getChildCount();
    for ( int i = 0; i < numChildren; i++) {
      if ( getChild(i) != null) {
        g.strokeWeight(8);
        getChild(i).render(g);
      }
    }    
    g.popMatrix();
  }
  
  public void update() {
    
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
  
  public void leftright() { 
    //structure of this node is left right
    Radical left = new Radical();
    Radical right = new Radical();
    addChild(left);
    addChild(right);
  }
  
  public void leftright(int p, int q) { 
    //structure of this node is left right
    Radical left = new Radical();
    Radical right = new Radical();
    addChild(left);
    addChild(right);
    left.setScale(new PVector (0.7f, 0.7f));
    right.setScale(new PVector (0.7f, 0.7f));
    right.setPosition(new PVector (15, 0));
    left.setPosition(new PVector (0, 0));
    left.setShape(p);
    right.setShape(q);
  }

  public void topbottom() {
    Radical top = new Radical();
    Radical bottom = new Radical();
    addChild(top);
    addChild(bottom);
  }
  
  public void topbottom(int p, int q) {
    Radical top = new Radical();
    Radical bottom = new Radical();
    addChild(top);
    addChild(bottom);
    top.setShape(p);
    bottom.setShape(q);
    top.setScale(new PVector (0.7f, 0.7f));
    bottom.setScale(new PVector (0.7f, 0.7f));
    bottom.setPosition(new PVector (-25, 50));
    top.setPosition(new PVector (35, -15));
  }
  
 
  public Radical getChild(int index) {
    if ( index >= 0 && index < children.size() ) {
      return (Radical)children.get(index);
    }
    else return null;
  }
  
  public void setScale(PVector _scale) {
    mScale.set( _scale);
  }

  public void setPosition(PVector _value) {
    mPosition.set(_value);
  }

  public void setRotation(PVector _value) {
    mRotation.set(_value);
  }

}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "encoding6_demo" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
