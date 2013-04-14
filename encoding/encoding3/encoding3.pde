//encoding test. write hashmap to a txt file. read from a txt file to a hashmap
//if you type in a string such as A14 or AA019 or B0A82, you will get a graphic representation of that encoding
import processing.pdf.*;
import java.util.*; //just in case

Radical glyph;
String inputString;  //input for encoding 
char letter;
boolean encodefinish = false;
boolean keywordStart = false;
boolean encodeStart = false;
boolean keywordfinish = false;
boolean entertext = false; //for translation
Button savecodebutton, resetbutton, typewordbutton, wordfinbutton, encodebutton, enterbutton, exitbutton;
int buttonx, buttony;  
String keyword; //the English word we want to encode
String textString; //for translation
boolean decodeWord = false; 

HashMap words;
PrintWriter output; 

void setup() {

  size( 800, 700);
  background(255);
  smooth(); 
  words = new HashMap();
  output = createWriter("wordEncoding.txt");
  convertFiletoHashmap("wordEncoding0.txt");

  inputString = "B06";
  glyph = new Radical(inputString);
  keyword ="";
  textString="";
  buttonx = 20;
  buttony = 100;

  initButtons();
  textFont(createFont("Helvetica", 36));
  reset();
}

void draw() {

  background(255);
  if ( encodefinish) {
    glyph.update();
  } 
  //draw the glyph 
  pushMatrix();
  translate(300, 100);
  scale(0.8);
  strokeWeight(10);
  glyph.render();
  popMatrix();

  if ( decodeWord == true) {
    renderGlyph();
  }

  drawButtons();
}

void renderGlyph() { 
  pushMatrix();
  translate(100, 600);
  scale(0.5);
  if(words.containsKey(textString)) {
     Radical r = (Radical) words.get(textString);
     r.render();
  }
  else {
    println("cannot find word");
  }
  popMatrix();
}

void mousePressed() {

  if ( savecodebutton.overRect()) {
    //the string is finished being typed..create the string.and save it
    glyph.setEncoding(inputString);
    encodefinish = true;
    encodeStart = false;
    //put glyph into hashmap
    //make a new Radical object
    String currentcode = glyph.encoding;
    Radical newglyph = new Radical(currentcode);
    words.put(keyword, newglyph);
    
  }
  if ( resetbutton.overRect()) {
    reset();
  }
  if (typewordbutton.overRect()) {
    keywordStart = true;
    //have to also restrict user from entering the other string
  }
  if (wordfinbutton.overRect()) {
    keywordfinish = true;
    //keywordstart needs to be turned false otherwise when other text is entered it will add to keyword
    keywordStart = false;
  }
  if ( encodebutton.overRect() ) {
    encodeStart = true;
  }
  if ( enterbutton.overRect() ) {
    entertext = true;
  }
  if ( exitbutton.overRect()) {
    //write all the data in the hashmap to file all at same time. old and new
    Iterator i = words.entrySet().iterator();
    while(i.hasNext()) {
      Map.Entry me = (Map.Entry)i.next();
      String word = (String)me.getKey();
      Radical r = (Radical)me.getValue();
      output.println(word + "\t" + r.encoding);
    }
    //save data and exit 
    output.flush();
    output.close();
    exit();
  }
}

void keyPressed() {

  if ( keywordStart == true && keywordfinish == false) {
    letter = key;
    keyword = keyword + key;
  }
  if ( encodeStart == true) {
    if (key =='A' || key =='B' || (key >= '0' && key <= '9')) 
    { 
      letter = key;
      inputString = inputString + key;
    }
  }

  if ( entertext == true && keywordStart == false && encodeStart == false) {
    //do not add space key to textstring
    if (key!=' ') { 
      letter = key;
      textString = textString + key;
    }  
    if ( key == ' ') {
      //space means gap between words
      decodeWord = true;
    }
  }
}

void reset() {
  glyph.clear();
  inputString = "";
  keyword = "";
  textString = "";
  encodefinish = false;
  keywordfinish = false;
}

void convertFiletoHashmap(String s) {
   String[] fileString = loadStrings(s);
   
   for ( int i = 0; i < fileString.length; i++) {
     String[] pair = split(fileString[i], '\t');
     Radical radical = new Radical(pair[1]);
     words.put(pair[0], radical);
   }
}

void initButtons() {
  typewordbutton = new Button(buttonx, buttony); 
  wordfinbutton = new Button(buttonx, buttony+50);
  encodebutton = new Button(buttonx, buttony+100);
  savecodebutton = new Button(buttonx, buttony+150);
  resetbutton = new Button(buttonx, buttony+200);
  enterbutton = new Button(buttonx, buttony+250);
  exitbutton = new Button(buttonx, buttony+300);
}

void drawButtons() {
  savecodebutton.render();
  resetbutton.render();
  typewordbutton.render();
  wordfinbutton.render();
  encodebutton.render();
  enterbutton.render();
  fill(100);
  textSize(16);
  text("word is " +keyword, buttonx+15, buttony-70);
  text("encoding is " +inputString, buttonx+15, buttony-50);
  text("entered text is " +textString, buttonx+15, buttony-20);
  fill(0);
  text("enter word to encode", buttonx+15, buttony+20);
  text("save word", buttonx+15, buttony+70);
  text("start encoding", buttonx+15, buttony+120);
  text("save encoding", buttonx+15, buttony+170);
  text("clear", buttonx+15, buttony+220);
  text("enter text to decode", buttonx+15, buttony+270);
  text("exit/save data", buttonx+15, buttony+320);
}


