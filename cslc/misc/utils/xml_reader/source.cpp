#include <iostream>
#include <fstream>
#include <vector>
#include <exception>

#include "header.h"
using namespace std;

istream& operator>>(istream& in, Evalue &value) {
  string temp;
  in >> temp;
  if( temp == "TYPE_T1" ) {
    value = TYPE_T1;
  }
  else if(temp == "TYPE_T2" ) {
    value = TYPE_T2;
  }
  else if(temp == "TYPE_T3" ) {
    value = TYPE_T3;
  }
  else if(temp == "TYPE_T2" ) {
    value = TYPE_T4;
  }
  else
    throw my_exception("[operator>>(istream& in, Evalue &value)] Error reading input value from stream");

  return in;
}

ostream& operator<<(ostream &out, const Evalue &value) {
  switch(value) {
    case TYPE_T1:
      out << "TYPE_T1";
      break;
    case TYPE_T2:
      out << "TYPE_T2";
      break;
    case TYPE_T3:
      out << "TYPE_T3";
      break;
    case TYPE_T4:
      out << "TYPE_T4";
      break;
  }
  return out;
}

vector<string> readEnumStrings(const char *fileName) {
  ifstream fin(fileName);
  if(!fin) {
    cerr << "can't read imput file:" << fileName << endl;
    exit(1);
  }
  vector<string> values;
  string temp;
  while(!fin.eof()) {
    temp.clear();
    getline(fin, temp);
    if(fin.eof())
      break;
    values.push_back(temp);
  }
  fin.close();
  return values;
}

int main (int argc, char **argv) {
  // !!! Verify that the vector you read from the file has a size that agrees with the size of the enum
  try {
    if(argc != 2) {
      cerr << "Invalid number og arguments" << endl;
      return 1;
    }
    vector<string> values = readEnumStrings(argv[1]);
    cout << values.size() << endl;;
    for( vector<string>::iterator it = values.begin(); it != values.end(); ++it)
      cout << *it << endl;

    Evalue val;
    cout << "Enter the value:";
    cin >> val;
    cout << "Your value is: " << val << endl;

    cout << values[val] << endl;

  } 
  catch( exception &ex) {
    cerr << "An exception occured: " << ex.what() << endl;
    return 1;
  }
  catch( ... ) {
    cerr << "An unknown exception occured" << endl;
    return 1;
  }
  
  return 0;
}
