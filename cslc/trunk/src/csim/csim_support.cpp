#include "csim_support.h"

using namespace std;

int stringToUInt(string str,unsigned int &value){
  istringstream ssinp(str);
  
  if(!(ssinp>>value)){
    cerr<<"Error:  \""<<str<<"\""<<" is not type of unsigned int"<<endl;
    return 0;
  }

  return 1;
}

int stringToUChar(string str,unsigned int &value){
  istringstream ssinp(str);
  
  if(!(ssinp>>value)){
    cerr<<"Error:  \""<<str<<"\""<<" is not type of unsigned char"<<endl;
    return 0;
  }

  return 1;
}

int stringToULongLong(string str,unsigned long long &value){
  istringstream ssinp(str);
  
  if(!(ssinp>>value)){
    cerr<<"Error:  \""<<str<<"\""<<" is not type of unsigned long long"<<endl;
    return 0;
  }

  return 1;
}


string uIntToString(unsigned int value){
  std::stringstream ss;
  std::string str;
  ss << value;
  ss >> str;
  
  return str;
}

string uCharToString(unsigned char value){
  std::stringstream ss;
  std::string str;
  ss << (unsigned int)value;
  ss >> str;
  
  return str;
}

string uLongLongToString(unsigned long long value){
  std::stringstream ss;
  std::string str;
  ss << value;
  ss >> str;
  
  return str;
}
