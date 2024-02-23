//This is the CSLOm Adapter class definition file

//Created on 13.02.06 by Eugen
//modified for CSLOM by Gabriel

#include "Tools.hpp"
#include <iostream>
#include <cstdlib>
#include <iterator>
#include <sstream>
using namespace std;

using namespace NSCSLOm;
using namespace antlr;

// -----------------------------------------------
// |         class CCSLOmAdapter                  |
// -----------------------------------------------
CCSLOmAdapter* CCSLOmAdapter::instance = NULL;

CCSLOmAdapter::CCSLOmAdapter(){
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
    
CCSLOmAdapter::~CCSLOmAdapter() {
  delete []m_hashBin;
  delete []m_hashOct;
  delete []m_hashDec;
  delete []m_hashHex;
  delete []m_hashReal;
}

RefString CCSLOmAdapter::getStringValue( const RefString input ) const {
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

int CCSLOmAdapter::octStrToInt(const string& str) const {
  int val = 0;
  unsigned int i;

  for (i = 0; i < str.length(); i++) {
    val = val * 8 + charToInt(str[i]);
  }

  return val;
}

char CCSLOmAdapter::octStrToChar(const string& str) const
{
  int ch = octStrToInt(str);

  if( ch > 0xFF) {
    cout << "Error: Octal value in string esacpe sequence is higher than \\377" << endl;
    ch = 0x40;
  }
  /*
  if (ch > 0xFF)
    throw CslLexerException(
        lexerState(),
        "Octal value in string esacpe sequence is higher than \\377"
        );
  */
  return (char) ch;
}


CSLOmNumber::ENumBaseType CCSLOmAdapter::convertFromTNumberBaseToENumBaseType(const CslNumber::TNumberBase numberBase) const{
  switch(numberBase) {
    case CslNumber::BASE_BIN:
      return CSLOmNumber::NUM_BASE_BIN;
    case CslNumber::BASE_OCT:
      return CSLOmNumber::NUM_BASE_OCT;
    case CslNumber::BASE_DEC:
      return CSLOmNumber::NUM_BASE_DEC;
    case CslNumber::BASE_HEX:
    default:
      return CSLOmNumber::NUM_BASE_HEX;
  }
}

CCSLOmAdapter* CCSLOmAdapter::getInstance() {
  if( instance == NULL ){
    instance = new CCSLOmAdapter();
  }
  return instance;
}

/**
 *
 */
RefCSLOmNumber CCSLOmAdapter::convertToCSLOmNumberFrom_sized_number(TULong lineNumber, RefString fileName, const RefCslNumber unsigned_number, const RefCslNumber based_number) const {
  string* temp = new string(*unsigned_number->getStringValue());
  temp->append(*based_number->getStringValue());
  RefString value = based_number->getStringValue();
  string* properValue = new string(value->c_str()+2);

  stringstream ss;
  ss << *(unsigned_number->getStringValue());
  TUInt width;
  ss >> width;

  RefCSLOmNumber returned;

  if (!based_number->hasXZ()) {
    returned = CSLOmNumber::build( lineNumber, fileName, 
                                   convertFromTNumberBaseToENumBaseType( based_number->getBase() ),
                                   //The memory was alocated before and is now managed by the smart ref template
                                   RefString( temp ),
                                   RefString(properValue),
                                   width
  );

  }
  else {
    returned = CSLOmVeriNum::build(lineNumber, fileName, RefString(temp), width, 
                                   convertFromTNumberBaseToENumBaseType( based_number->getBase() ), 
                                   based_number->isSigned(), based_number->hasXZ() );
  }

  return returned;
}

RefCSLOmNumber CCSLOmAdapter::convertToCSLOmNumberFrom_UNSIGNED_NUMBER(TULong lineNumber, RefString fileName, const RefCslNumber unsigned_number) const {
  RefCSLOmNumber returned = CSLOmNumber::build(
                                               lineNumber, fileName,
      convertFromTNumberBaseToENumBaseType( unsigned_number->getBase() ),
      unsigned_number->getStringValue(),
      stripDec(unsigned_number->getStringValue())
      );

  return returned;
}

RefCSLOmNumber CCSLOmAdapter::convertToCSLOmNumberFrom_BASED_NUMBER(TULong lineNumber, RefString fileName, const RefCslNumber based_number) const {

  RefCSLOmNumber returned;

  if (!based_number->hasXZ()) {
    returned = CSLOmNumber::build(lineNumber, fileName,
                                  convertFromTNumberBaseToENumBaseType( based_number->getBase() ),
                                  based_number->getStringValue(),
                                  stripX(based_number->getStringValue(), based_number->getBase() ),
                                  based_number->isSigned()
      );

  }
  else {
    returned = CSLOmVeriNum::build(lineNumber, fileName, based_number->getStringValue());
  }

//                                                , width, 
//                                                convertFromTNumberBaseToENumBaseType( based_number->getBase() ), 
//                                                based_number->isSigned(), based_number->hasXZ() );
  return returned;
}

//RefCSLOmReal CCSLOmAdapter::convertToCSLOmRealFrom_REAL_NUMBER(TULong lineNumber, const RefCslNumber real_number) const {
//  RefCSLOmReal returned = CSLOmReal::build( lineNumber, real_number->getStringValue(), stripReal( real_number->getStringValue() ) );
//  
//  return returned;
//}
// -----------------------------------------------
// |         class CslStringTokenizerDollar      |
// -----------------------------------------------
CslStringTokenizerDollar::CslStringTokenizerDollar ( const RefString input ) {
  //If the RefString is null or string contains 0 elements, we do nothing
  if( !input.get() || input->length() == 0 )
    return;

  //initialize m_ids
  m_ids.push_back( RefString( new string() ) );
  for( TUInt i = 0; i < input->length(); ++i ) {
    char c;
    if( ( c = (*input)[i] ) == '$' )
      m_ids.push_back( RefString( new string() ) );
    else
      m_ids[ m_ids.size() - 1 ]->push_back( c );
  }
}

//End of file
