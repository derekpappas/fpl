// This is a CSLOm adapter class from antlr classes 

//Created on 13.02.06 by Eugen

#ifndef __CCSLOmAdapterFromCsl

#define __CCSLOmAdapterFromCsl

#include "../../cslom/CSLOM.h"
#include "../../cslom/VeriNum.h"
#include "CslNumber.hpp"
#include "CslToken.hpp"
#include "CslAST.hpp"
#include <iostream>
#include <algorithm>
#include <vector>
#include <string.h>

void destroy(antlr::RefAST &ast);
class CslStringTokenizerDollar {
  private:
    vector<RefString> m_ids;
  public:
    CslStringTokenizerDollar( const RefString );
    TUInt getCount() const { return this->m_ids.size(); }
    RefString operator[]( const TUInt x ) const { return m_ids[x]; } 
    char* getCharStr( const TUInt x ) const { 
      if( x >= m_ids.size() ) {
        cerr << " ERROR ";
        return NULL;
      }
      char * returned = new char[m_ids.size()+1]; 
      strcpy(returned, m_ids[x]->c_str()); 
      return returned;
    }
};

//This class implements the comportamental behavior of an Adapter class
// and the creational behavior of a singleton due to the lack of static contructor in c++ language
class CCSLOmAdapter {
  public:
    ~CCSLOmAdapter();
  private:
    //number validating tables
    CCSLOmAdapter();    
    static CCSLOmAdapter* instance;
    int *m_hashBin;
    int *m_hashOct;
    int *m_hashDec;
    int *m_hashHex;
    int *m_hashReal;
    static bool notBin (char x) { return !getInstance()->m_hashBin  [x]; }
    static bool notOct (char x) { return !getInstance()->m_hashOct  [x]; }
    static bool notDec (char x) { return !getInstance()->m_hashDec  [x]; }
    static bool notHex (char x) { return !getInstance()->m_hashHex  [x]; }
    static bool notReal(char x) { return !getInstance()->m_hashReal [x]; }
  public:
    static CCSLOmAdapter* getInstance();
    int  octStrToInt (const string& ) const;
    char octStrToChar(const string& ) const;
    RefString getStringValue( const RefString ) const;
    NSCSLOm::RefCSLOmNumber convertToCSLOmNumberFrom_sized_number(TULong lineNumber, RefString fileName, const RefCslNumber unsigned_number, 
        const RefCslNumber based_number) const;
    NSCSLOm::CSLOmNumber::ENumBaseType convertFromTNumberBaseToENumBaseType(const CslNumber::TNumberBase) const;
    NSCSLOm::RefCSLOmNumber convertToCSLOmNumberFrom_UNSIGNED_NUMBER(TULong lineNumber, RefString fileName, const RefCslNumber unsigned_number) const;
    NSCSLOm::RefCSLOmNumber convertToCSLOmNumberFrom_BASED_NUMBER(TULong lineNumber, RefString fileName, const RefCslNumber based_number) const;
//    NSCSLOm::RefCSLOmReal convertToCSLOmRealFrom_REAL_NUMBER(TULong lineNumber, const RefCslNumber real_number) const;
    RefString stripX( const RefString str, const CslNumber::TNumberBase base) const {
      switch( base ) {
        case CslNumber::BASE_BIN:
          return stripBin( str );
        case CslNumber::BASE_OCT:
          return stripOct( str );
        case CslNumber::BASE_DEC:
          return stripDec( str );
        case CslNumber::BASE_HEX:
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

