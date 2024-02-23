#ifndef CSIM_SUPPORT_H
#define CSIM_SUPPORT_H

#include <string>
#include <sstream>
#include <iostream>

int stringToUInt     (std::string str, unsigned int       &value);
int stringToUChar    (std::string str, unsigned int       &value);
int stringToULongLong(std::string str, unsigned long long &value);

std::string uIntToString     (unsigned int       value);
std::string uCharToString    (unsigned char      value);
std::string uLongLongToString(unsigned long long value);


/*************************
 *   convert to binary   *
 *************************/
template < class T > std::ostream& binary(T& value,unsigned int width, std::ostream &o){
  for(T mask = ((T)(1))<<(width-1); mask; mask = mask >> 1){
    o<< ((value & mask )?  '1' : '0');
  }

  return o;
}

/*************************
 *   calculates width    *
 *************************/
template <class T > unsigned int getWidth(T value){
  unsigned int width = 8 * sizeof(T);
  for(T mask = ((T)(1))<<(width - 1); mask && !(value & mask); mask = mask >> 1){
    --width;
  }
  return width;
}

#endif
