//take a paragraph of an actual java program. replace all the letters with one symbol '>'
//retian operands. 

import java.util.regex.*;

void setup() {
  size(500, 500);

  String[] data = loadStrings("text.txt");
  for ( int j = 0; j < data.length; j++) {
    String k = data[j];
    String p = k.replaceAll("\\r", "");
    String s = p.replaceAll("\\n", "");
    int num = s.length();
    char newString[] = new char[num];

    for ( int i = 0; i < num; i++) {

      if ( Character.isWhitespace(s.charAt(i)) ) {    
        newString[i] = '-';
      }
      else if ( Character.isUpperCase(s.charAt(i)) ) {
        newString[i] = '>';
      }
      else if ( Character.isLowerCase(s.charAt(i)) ) {
        newString[i] = '<';
      }
      else if ( Character.isDigit(s.charAt(i)) ) {
        newString[i] = '.';
      } 
      else if ( s.charAt(i) == '{' || s.charAt(i) == '(') {
        newString[i] = '[';
      } 

      else if ( s.charAt(i) == ')' || s.charAt(i) == '}') {
        newString[i] = ']';
      } 
      else {
        newString[i] = s.charAt(i);
      }
          
    }
      String s1 = new String(newString);
      print(s1);
  }
 }

