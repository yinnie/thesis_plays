//encoding test. write hashmap to a txt file. read from a txt file to a hashmap
//if you type in a string such as A14 or AA019 or B0A82, you will get a graphic representation of that encoding
//how to export 
import processing.pdf.*;
import java.util.*; //just in case
import controlP5.*;

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

void setup() {

  size( 900, 800, P2D);
  background(255);
  smooth(); 
  pg = createGraphics(250, 250, P2D);
  textSize(28);
  words = new HashMap();
  //upload data from old file
  convertFiletoHashmap("wordEncoding0.txt");
  //create a new file with the same name so to overwrite
  output = createWriter("wordEncoding1.txt");

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

void draw() {

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

void renderMatchingGlyphPoem(String s, int h) { 
  String[] input = split(s, ' ');

  pushMatrix();
  translate(300, h);
  scale(0.25);
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

void renderMatchingGlyph(String s, int h) { 
  String[] input = split(s, ' ');

  pushMatrix();
  translate(300, h);
  scale(0.35);
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

void reset() {
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

void convertFiletoHashmap(String s) {
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

void initCP5() {
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

void savePNG() {
  pg.save(frameCount + ".png");
}

void drawTextfield() {
  //for enter keyword
  if (inputfinish) {
    text(cp5.get(Textfield.class, "input word").getText(), 350, 120);
  }
  if (encodefinish) {  //this helps give user indication that her input is recorded
    text(inputString, 350, 220);
  }
}

void Encode() {
  encodingState = true;
}
void Decode() {
  encodingState = false;
}

void customize(DropdownList ddl) {
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

void customizeDropLayer(DropdownList ddl) {
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

void controlEvent(ControlEvent theEvent) {
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
void radio1(int a) {
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
void updateString () {
  group2string = group2string0 + group2string1 + group2string2;
  group3string = group3string0 + group3string1 + group3string2;
  inputString = string0 + group2string + group3string;
  glyph.encoding = inputString;
}
//radio button for main structure of a double layers
void radioMain(int a) {
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

void radio2(int a) {
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

void radio3(int a) {
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
void slider10(int number) {
  glyph.clear();
  stringarray[1] = str(number);
  inputString = stringarray[0]+stringarray[1]+stringarray[2];
  glyph.encoding = inputString;
}
void slider11(int number) {
  glyph.clear();
  stringarray[2] = str(number);
  inputString = stringarray[0]+stringarray[1]+stringarray[2];
  glyph.encoding = inputString;
}
// for group 2 
void slider20(int number) {
  glyph.clear();
  group2string1 = str(number);
  updateString();
}

void slider21(int number) {
  glyph.clear();
  group2string2 = str(number);
  updateString();
}
void slider30(int number) {
  glyph.clear();
  group3string1 = str(number);
  updateString();
}

void slider31(int number) {
  glyph.clear();
  group3string2 = str(number);
  updateString();
}

void clear() {
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

void saveHashmap() {
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

void quit() {
  saveHashmap();
  exit();
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
  if ( key == 'z') {
    showPoetry = !showPoetry;
     clear();
  }
  //if ( key == '1' ) {
    //savePNG();
  //} 
}

