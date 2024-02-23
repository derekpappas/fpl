#ifndef __HEADER_xxx123xxx

#define __HEADER_xxx123xxx

#include <iostream>
#include <fstream>
#include <vector>
#include <exception>

class my_exception : public std::exception {
  private:
    const char *m_mesg;
  public:
    my_exception(const char *mesg) throw() : m_mesg(mesg) {}
    const char* what() const throw() { return m_mesg; }
};

typedef enum {
  TYPE_T1 = 0,
  TYPE_T2 = 1,
  TYPE_T3 = 2,
  TYPE_T4 = 3
} Evalue;

std::istream& operator>>(std::istream& in, Evalue &value);
std::ostream& operator<<(std::ostream &out, const Evalue &value);
std::vector<std::string> readEnumStrings(const char *fileName);

#endif
