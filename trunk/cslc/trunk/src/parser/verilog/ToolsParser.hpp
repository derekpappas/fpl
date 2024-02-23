#ifndef __TOOLS_PARSER_INC_GUARD

#define __TOOLS_PARSER_INC_GUARD

#include "VerilogNumber.hpp"
#include "VerilogToken.hpp"
#include "VerAST.hpp"
#include <iostream>
#include <algorithm>
#include <vector>
#include <string.h>

void destroy(antlr::RefAST &ast);

class CVerStringTokenizerDollar {
  private:
    vector<string> m_ids;
  public:
    CVerStringTokenizerDollar( string );
    TUInt getCount() const { return this->m_ids.size(); }
    string operator[]( TUInt x ) const { return m_ids[x]; } 
    char* getCharStr( TUInt x ) const { 
      if( x >= m_ids.size() ) {
        cerr << " ERROR ";
        return NULL;
      }
      char * returned = new char[m_ids.size()+1]; 
      strcpy(returned, m_ids[x].c_str()); 
      return returned;
    }
};

#endif

