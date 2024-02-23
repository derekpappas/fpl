//The main func
#include "verilogCodeGen.h"
#include <iostream>
using std::cin;
using std::cout;
using std::time_t;
using std::endl;
using NSCdom::RefString;
using std::string;

int main(){
  CVerilogTestGen vtg;
  for( int i=0; i < 100; ++i)
    vtg.createRandomExpr();
  cout << vtg;
  cout << vtg.buffout.str();
  return 0;
}

//End of file
