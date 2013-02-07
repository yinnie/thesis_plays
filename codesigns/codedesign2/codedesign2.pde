//take a paragraph of an actual java program. replace all the letters with one symbol '>'
//retian operands. 


void setup() {
  size(1200,800);
  background(255);
  fill(0);

  String[] data = loadStrings("text.txt");
  
  for ( int j = 0; j < data.length; j++) {
    
    String s = data[j];
    int num = s.length();
    char newString[] = new char[num];

    for ( int i = 0; i < num; i++) {

      if ( Character.isWhitespace(s.charAt(i)) ) {    
        newString[i] = '-';
      }
      else if ( Character.isUpperCase(s.charAt(i)) ) {
        newString[i] = '+';
      }
      else if ( Character.isLowerCase(s.charAt(i)) ) {
        newString[i] = '+';
      }
      else if ( Character.isDigit(s.charAt(i)) ) {
        newString[i] = '+';
      } 
      else if ( s.charAt(i) == '{' ) {
        newString[i] = '[';
      } 

      else if ( s.charAt(i) == '}') {
        newString[i] = ']';
      } 
      else if ( s.charAt(i) == '&' ||  s.charAt(i) == '/') {
        newString[i] = ',';
      } 
       else if ( s.charAt(i) == '(' ||  s.charAt(i) == ')') {
        newString[i] = '<';
      } 
         else if ( s.charAt(i) == ';') {
        newString[i] = '<';
      }
      else if ( s.charAt(i) == '\\') {
        newString[i] = '-';
      }
         else if ( s.charAt(i) == '=') {
        newString[i] = '>';
      }
        else if ( s.charAt(i) == ' ') {
        newString[i] = '-';
      }

      else {
        newString[i] = s.charAt(i);
      }
           
    }
      String s1 = new String(newString);
      text(s1, 50, 50+10*j); 
      print(s1);
  }
 
 }

