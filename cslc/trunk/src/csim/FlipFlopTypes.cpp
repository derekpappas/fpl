#include "FlipFlopTypes.h"


//-----------------------------
//FFUInt class - unsigned int
//-----------------------------
FFUInt::FFUInt(){
  m_value = 0;
}

FFUInt::FFUInt(unsigned int value){
  m_value = value;
}

void FFUInt::setValue(unsigned int value){
  m_value = value;
}

unsigned int FFUInt::getValue(){
  return m_value;
}

std::string FFUInt::toString(){
  std::stringstream ss;
  std::string str;
  ss << m_value;
  ss >> str;
  
  return str;
}

//--------------------------------
//FFUChar class - unsigned char
//--------------------------------
FFUChar::FFUChar(){
  m_value = 0;
}

FFUChar::FFUChar(unsigned char value){
  m_value = value;
}

void FFUChar::setValue(unsigned char value){
  m_value = value;
}

unsigned char FFUChar::getValue(){
  return m_value;
}

std::string FFUChar::toString(){
  std::stringstream ss;
  std::string str;
  ss << m_value;
  ss >> str;
  
  return str;
}


//------------------------------------------
//FFULongLong class - unsigned long long
//------------------------------------------
FFULongLong::FFULongLong(){
  m_value = 0;
}

FFULongLong::FFULongLong(unsigned long long value){
  m_value = value;
}

void FFULongLong::setValue(unsigned long long value){
  m_value = value;
}

unsigned long long FFULongLong::getValue(){
  return m_value;
}

std::string FFULongLong::toString(){
  std::stringstream ss;
  std::string str;
  ss << m_value;
  ss >> str;
  
  return str;
}
