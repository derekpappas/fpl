#ifndef FLIPFLOPTYPES_H
#define FLIPFLOPTYPES_H

#include <sstream>
#include <string>

//-----------------------------
//FFUInt class - unsigned int
//-----------------------------
class FFUInt{
  private: 
    unsigned int m_value;
  public:
    FFUInt();
    FFUInt(unsigned int value);
    
    void setValue(unsigned int);
    unsigned int getValue();

    std::string toString();
};

//------------------------------
//FFUChar class - unsigned char
//------------------------------
class FFUChar{
  private: 
    unsigned char m_value;
  public:
    FFUChar();
    FFUChar(unsigned char value);
    
    void setValue(unsigned char);
    unsigned char getValue();

    std::string toString();
};

//-----------------------------------------
//FFULongLong class - unsigned long long
//-----------------------------------------
class FFULongLong{
  private: 
    unsigned long long m_value;
  public:
    FFULongLong();
    FFULongLong(unsigned long long value);
    
    void setValue(unsigned long long);
    unsigned long long getValue();

    std::string toString();
};


#endif
