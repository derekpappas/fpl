// This is a CDOM adapter class from antlr classes 

//Created on 13.02.06 by Eugen

#ifndef __CCDOMAdapterFromVerilog

#define __CCDOMAdapterFromVerilog

//#include "cdom/CDOM.h"
#include "../../cdom/CDOM.h"
//#include "cdom/VeriNum.h"
#include "../../cdom/VeriNum.h"
#include "VerilogNumber.hpp"
#include "VerilogToken.hpp"
#include "VerAST.hpp"
#include <iostream>
#include <algorithm>
#include <vector>

void destroy(antlr::RefAST &ast);
//This class implements the comportamental behavior of an Adapter class
// and the creational behavior of a singleton due to the lack of static contructor in c++ language
class CCDOMAdapter {
  private:
    //number validating tables
    CCDOMAdapter();    
    static CCDOMAdapter* instance;
    int *m_hashBin;
    int *m_hashOct;
    int *m_hashDec;
    int *m_hashHex;
    int *m_hashReal;
    static bool notBin (char x) { return !getInstance().m_hashBin  [x]; }
    static bool notOct (char x) { return !getInstance().m_hashOct  [x]; }
    static bool notDec (char x) { return !getInstance().m_hashDec  [x]; }
    static bool notHex (char x) { return !getInstance().m_hashHex  [x]; }
    static bool notReal(char x) { return !getInstance().m_hashReal [x]; }
  public:
    static const CCDOMAdapter& getInstance();
    int  octStrToInt (const string& ) const;
    char octStrToChar(const string& ) const;
    RefString getStringValue( const RefString ) const;
    NSCdom::RefCDOmNumber convertToCDOmNumberFrom_sized_number(TULong lineNumber, const RefVerilogNumber unsigned_number, 
        const RefVerilogNumber based_number) const;
    NSCdom::CDOmNumber::ENumBaseType convertFromTNumberBaseToENumBaseType(const VerilogNumber::TNumberBase) const;
    NSCdom::RefCDOmNumber convertToCDOmNumberFrom_UNSIGNED_NUMBER(TULong lineNumber, const RefVerilogNumber unsigned_number) const;
    NSCdom::RefCDOmNumber convertToCDOmNumberFrom_BASED_NUMBER(TULong lineNumber, const RefVerilogNumber based_number) const;
    NSCdom::RefCDOmReal convertToCDOmRealFrom_REAL_NUMBER(TULong lineNumber, const RefVerilogNumber real_number) const;
    RefString stripX( const RefString str, const VerilogNumber::TNumberBase base) const {
      switch( base ) {
        case VerilogNumber::BASE_BIN:
          return stripBin( str );
        case VerilogNumber::BASE_OCT:
          return stripOct( str );
        case VerilogNumber::BASE_DEC:
          return stripDec( str );
        case VerilogNumber::BASE_HEX:
          return stripHex( str );
        default:
          return RefString();
      }
    }
    RefString stripBin (const RefString input ) const { RefString output( new std::string()); std::remove_copy_if( input->begin(), input->end(), std::back_inserter( *output ), notBin  ); return output; }
    RefString stripOct (const RefString input ) const { RefString output( new std::string()); std::remove_copy_if( input->begin(), input->end(), std::back_inserter( *output ), notOct  ); return output; }
    RefString stripDec (const RefString input ) const { RefString output( new std::string()); std::remove_copy_if( input->begin(), input->end(), std::back_inserter( *output ), notDec  ); return output; }
    RefString stripHex (const RefString input ) const { RefString output( new std::string()); std::remove_copy_if( input->begin(), input->end(), std::back_inserter( *output ), notHex  ); return output; }
    RefString stripReal(const RefString input ) const { RefString output( new std::string()); std::remove_copy_if( input->begin(), input->end(), std::back_inserter( *output ), notReal ); return output; }
  private:
};


#endif

