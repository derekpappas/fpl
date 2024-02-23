//This is the CDOM Adapter class definition file

//Created on 13.02.06 by Eugen

#include "Tools.hpp"
#include <iostream>
#include <cstdlib>
#include <iterator>
using namespace std;

using namespace NSCdom;
using namespace antlr;

// -----------------------------------------------
// |         class CCDOMAdapter                  |
// -----------------------------------------------
CCDOMAdapter* CCDOMAdapter::instance = NULL;

CCDOMAdapter::CCDOMAdapter(){
  this->m_hashBin  = new int [256];
  this->m_hashOct  = new int [256];  
  this->m_hashDec  = new int [256];  
  this->m_hashHex  = new int [256];  
  this->m_hashReal = new int [256];  
  for( int i = 0; i < 256; i++ ){
    this->m_hashBin [i] = 0; 
    this->m_hashOct [i] = 0;   
    this->m_hashDec [i] = 0;   
    this->m_hashHex [i] = 0;   
    this->m_hashReal[i] = 0;   
  }

  for( char c = '0'; c<='1'; c++ ) {
    this->m_hashBin [c] = 1;
    this->m_hashOct [c] = 1;   
    this->m_hashDec [c] = 1;   
    this->m_hashHex [c] = 1;   
    this->m_hashReal[c] = 1;
  }

  for( char c = '2'; c<='7'; c++ ) {
    this->m_hashOct [c] = 1;   
    this->m_hashDec [c] = 1;   
    this->m_hashHex [c] = 1;   
    this->m_hashReal[c] = 1;
  }

  for( char c = '8'; c<='9'; c++ ) {
    this->m_hashDec [c] = 1;   
    this->m_hashHex [c] = 1;   
    this->m_hashReal[c] = 1;
  }
//01000001 //A
//01100001 //a
//0010 0000 //mask 0x20

  for( char c = 'A'; c<='F'; c++ ) {
    this->m_hashHex [c] = 1;   
    this->m_hashHex [c|0x20] = 1;   
  }
  
  this->m_hashBin  ['X'] = 1;
  this->m_hashOct  ['X'] = 1;   
  this->m_hashDec  ['X'] = 1;   
  this->m_hashHex  ['X'] = 1;   
  
  this->m_hashBin  ['x'] = 1;
  this->m_hashOct  ['x'] = 1;   
  this->m_hashDec  ['x'] = 1;   
  this->m_hashHex  ['x'] = 1;   
  
  this->m_hashBin  ['z'] = 1;
  this->m_hashOct  ['z'] = 1;   
  this->m_hashDec  ['z'] = 1;   
  this->m_hashHex  ['z'] = 1;   
  
  this->m_hashBin  ['Z'] = 1;
  this->m_hashOct  ['Z'] = 1;   
  this->m_hashDec  ['Z'] = 1;   
  this->m_hashHex  ['Z'] = 1;   
  
  this->m_hashBin  ['?'] = 1;
  this->m_hashOct  ['?'] = 1;   
  this->m_hashDec  ['?'] = 1;   
  this->m_hashHex  ['?'] = 1;   

  this->m_hashReal ['e'] = 1;
  this->m_hashReal ['E'] = 1;
  this->m_hashReal ['+'] = 1;
  this->m_hashReal ['-'] = 1;
  this->m_hashReal ['.'] = 1;
}                       
    
RefString CCDOMAdapter::getStringValue( const RefString input ) const {
  RefString output = RefString( new string() );
  char c;
  for( unsigned int i = 0; i < input->size(); ++i ) {
    if( ( c=(*input)[i] ) != '\\' )
      output->push_back( c );
    else {
      if( ( c = (*input)[++i] ) == 'n' )
        output->push_back( '\n' );
      else if( c == '\\' )
        output->push_back( '\\' );
      else if( c == '"' )
        output->push_back( '"'  );
      else if( c == 't' )
        output->push_back( '\t' );
      else if( c >= '0' && c <= '7' ) {
        int count = 0;
        string octal;
        do {
          octal.push_back( c );
        }
        while( ++i < input->size() && ( c = (*input)[i] ) >= '0' && c <= '7' && ++count < 3 );
        --i;
        output->push_back( octStrToChar( octal ) );
      } else {
        cout << "Warning: unknown escaped character" << endl;
        output->push_back(c);
      }
    }
  }
  return output;
}

int CCDOMAdapter::octStrToInt(const string& str) const {
  int val = 0;
  unsigned int i;

  for (i = 0; i < str.length(); i++) {
    val = val * 8 + charToInt(str[i]);
  }

  return val;
}

char CCDOMAdapter::octStrToChar(const string& str) const
{
  int ch = octStrToInt(str);

  if( ch > 0xFF) {
    cout << "Error: Octal value in string esacpe sequence is higher than \\377" << endl;
    ch = 0x40;
  }
  /*
  if (ch > 0xFF)
    throw VerilogLexerException(
        lexerState(),
        "Octal value in string esacpe sequence is higher than \\377"
        );
  */
  return (char) ch;
}


CDOmNumber::ENumBaseType CCDOMAdapter::convertFromTNumberBaseToENumBaseType(const VerilogNumber::TNumberBase numberBase) const{
  switch(numberBase) {
    case VerilogNumber::BASE_BIN:
      return CDOmNumber::NUM_BASE_BIN;
    case VerilogNumber::BASE_OCT:
      return CDOmNumber::NUM_BASE_OCT;
    case VerilogNumber::BASE_DEC:
      return CDOmNumber::NUM_BASE_DEC;
    case VerilogNumber::BASE_HEX:
    default:
      return CDOmNumber::NUM_BASE_HEX;
  }
}

const CCDOMAdapter& CCDOMAdapter::getInstance() {
  if( instance == NULL ){
    instance = new CCDOMAdapter();
  }
  return *instance;
}

/**
 *
 */
RefCDOmNumber CCDOMAdapter::convertToCDOmNumberFrom_sized_number(TULong lineNumber, const RefVerilogNumber unsigned_number, const RefVerilogNumber based_number) const {
  string* temp = new string(*unsigned_number->getStringValue());
  temp->append(*based_number->getStringValue());
  RefCDOmNumber returned = CDOmNumber::build( 
      lineNumber,
      convertFromTNumberBaseToENumBaseType( based_number->getBase() ),
      //The memory was alocated before and is now managed by the smart ref template
      //RefString( temp ),
      stripX(based_number->getStringValue(), based_number->getBase() )//,
      //based_number->isSigned(),
      //strtoul( stripDec( unsigned_number->getStringValue() )->c_str(), NULL, /*base=*/ 10 )
  );
  return returned;
}

RefCDOmNumber CCDOMAdapter::convertToCDOmNumberFrom_UNSIGNED_NUMBER(TULong lineNumber, const RefVerilogNumber unsigned_number) const {
  RefCDOmNumber returned = CDOmNumber::build(
      lineNumber,
      convertFromTNumberBaseToENumBaseType( unsigned_number->getBase() ),
      //unsigned_number->getStringValue(),
      stripDec(unsigned_number->getStringValue())
      );

  return returned;
}

RefCDOmNumber CCDOMAdapter::convertToCDOmNumberFrom_BASED_NUMBER(TULong lineNumber, const RefVerilogNumber based_number) const {
  RefCDOmNumber returned = CDOmNumber::build(
      lineNumber,
      convertFromTNumberBaseToENumBaseType( based_number->getBase() ),
      based_number->getStringValue()//,
      //stripX(based_number->getStringValue(), based_number->getBase() ),
      //based_number->isSigned()
      );
  return returned;
}

RefCDOmReal CCDOMAdapter::convertToCDOmRealFrom_REAL_NUMBER(TULong lineNumber, const RefVerilogNumber real_number) const {
  RefCDOmReal returned = CDOmReal::build( lineNumber, real_number->getStringValue(), stripReal( real_number->getStringValue() ) );
  
  return returned;
}
//End of file

