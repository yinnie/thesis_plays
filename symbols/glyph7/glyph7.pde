//ways to compose symbols according to set structures/frameworks
//structures to choose from:  a. top/down  b. top/middle/bottom c. left/right d. left/middle/right


String[] leftmeaning = {
  "speak", "foot", "water", "animal", "no", "hand", "mouth", "ice", "food", "eye"
};
String[] partsleft = {
  "⻈", "⻊", "⺡", "⺨", "不", "⺘", "口", "冫", "⻠", "⽬",
};
String[] partsright = {
  "亡", "己", "工", "心", "牛", "乙", "⻦", "内", "人", "⾈"
};
String[] rightmeaning = {
  "death", "oneself", "work", "heart", "cow", "second", "bird", "inside", "person", "boat"
};

String  left, right, lmeaning, rmeaning;
float locx, locy;
boolean over = false;
boolean locked = false;
boolean leftright = true;
boolean topbottom = false;

int n = 10;  //number of elements each side
Radical root;
Radical meaning;

void setup() {
  size(900, 800);
  smooth();
  root = new Radical();
  meaning = new Radical();
  locx = -20;
  locy = -20;
  left = "";
  right = "";
  lmeaning = "";
  rmeaning = "";
  meaning.leftright(lmeaning, rmeaning);
}

void draw() {
  background(255);
  fill(0);
  for ( int i = 0; i < n; i++) {
    text(leftmeaning[i], 120, 80+70*i);
    text(rightmeaning[i], 820, 80+70*i);
  }

  scale(5);
  for ( int i = 0; i < n; i++) {
    text(partsleft[i], 10, 20+15*i);
    text(partsright[i], 150, 20+15*i);
  }

  noFill();
  rectMode(CENTER);
  rect(mouseX/5, mouseY/5, 17, 17);
  stroke(255, 0, 0);
  strokeWeight(0.3);
  rect(87, 42, 35, 35);

  //test if the mouse if over any character in left side
  for ( int i = 0; i<n; i++) {
    if (mouseX > 10 && mouseX < 100 && 
      mouseY > (107+60*i) && mouseY < (107+60*(i+1)) )
    {
      left = partsleft[i];
      lmeaning = leftmeaning[i];
      over = true;
      print(mouseX);
      println(mouseY);
    }
    if (mouseX > 750 && mouseX < 900 && 
      mouseY > (107+60*i) && mouseY < (107+60*(i+1)) )
    {
      right = partsright[i];
      rmeaning = rightmeaning[i];
      over = true;
      print(mouseX);
      println(mouseY);
    }
  }

  text( left, locx, locy);
  text( right, locx, locy);
   //construct the character
  if (over) 
  {
    root.clear();  //update root
    meaning.clear(); //update meaning
    meaning.leftright(lmeaning, rmeaning);
    if (leftright) {
      root.leftright(left, right);
    } 
    else if (topbottom) {
      root.topbottom(left, right);
    }
  } 
  //draw the final product
  pushMatrix();
  translate(80, 50);
  root.draw();
  popMatrix();
  scale(0.8, 0.5);
  pushMatrix();
  translate(75, 150);
  meaning.getChild(0).setPosition(new PVector(-10, 0));
  meaning.getChild(1).setPosition(new PVector(42, 0));
  meaning.draw();
  popMatrix();
}

void mousePressed() {
  if (over) {
    locked = true;
  }
}
void mouseDragged() {
  if ( locked) {
    println("dragged!!");
    locx = mouseX;
    locy = mouseY;
  }
}
void keyPressed() {
  leftright = !leftright;
  topbottom = !topbottom;
}

