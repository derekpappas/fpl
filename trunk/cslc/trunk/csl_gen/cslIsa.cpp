// Copyright (c) 2005, 2006, 2007 Fastpathlogic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of Fastpathlogic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------

#include "cslIsa.h"

using namespace std;
namespace NSCSLinterconnect {

void CSLdesign::addIsaField() {
  int flag;
  string name( string("") );
  name.append( randString() );
  if (newNameIsValid( name ) == true ) {
    CSLisaField* isaField = new CSLisaField( this, name );
    flag = rand()%2;
    if ( flag ) 
      for ( int i = 0; i < ISA_FIELD_INSTANCE_NO; ++i) {
        isaField -> addFieldInstance(isaField -> getParent());
      }
    if( isaField -> buildDecl() ) {
      addChild( isaField );
    }
    else
      delete isaField;
  }
}

void CSLisaField::addFieldInstance(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ISA_FIELD ) {
      //      flag = rand()%2;
      // (*m_out) << "isaField name = " << (*it) -> getName() << endl;
      flag = 1;
      if( flag ) {
        string name(string(""));
        name.append(randString());
        if (newNameIsValid(name) == true ) {
          CSLinstance* isaFieldInstance = new CSLinstance(this, (*it), name);
          addChild(isaFieldInstance);
          this -> m_hierarchicalF = true;
        }
      }

    }
  }     
}

void CSLisaField::genSetWidth( CSLbase* design) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ISA_FIELD ) {
      flag = rand()%2;
      if( flag && !ok &&
          ( static_cast<CSLisaField*>(*it) -> m_used[CSLisaField::SET_WIDTH] ||
            static_cast<CSLisaField*>(*it) -> m_used[CSLisaField::SET_RANGE] ||
            static_cast<CSLisaField*>(*it) -> m_used[CSLisaField::SET_BITRANGE] ) ) {
        m_width.append( (*it) -> getName() );
        m_width.append(".");
        m_width.append( ISA_FIELD_FUNCTION[CSLisaField::GET_WIDTH]); 
        m_width.append( "()" );
        ok = true;
      }      
    }
  }
  if ( !ok ) {
    string width;
    do {
      width = randNumExpr();
    }
    while (width == "0");
    m_width.append( width );
  }
}

void CSLisaField::genSetBitrange( CSLbase* design) {
  bool ok = false;
  int flag;
  //    CSLbaseVec ch = design -> getChildren();
  //    vector<CSLbase*>::const_iterator it = ch.begin();
  //    for (; it < ch.end(); it++) {
  //      if( (*it) -> getType() == CSL_ISA_FIELD ) {
  //        flag = rand()%2;
  //        if( flag && !ok &&
  //            static_cast<CSLisaField*>(*it) -> m_used[CSLisaField::GET_BITRANGE]) {
  //          m_bitrange.append( (*it) -> getName() );
  //          m_bitrange.append(".");
  //          m_bitrange.append( ISA_FIELD_FUNCTION[CSLisaField::GET_BITRANGE]); 
  //          m_bitrange.append( "()" );
  //          ok = true;
  //          m_bitrangeF = true;
  //        }      
  //      }
  //    }
  //    if ( !ok ) {
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_BITRANGE ) {
      flag = rand()%2;
      if( flag && !ok ) {
        m_bitrange.append( (*it) -> getName() );
        ok = true;
        m_bitrangeF = true;
      }
    }      
  }
}

void CSLisaField::genSetRange( CSLbase* design) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ISA_FIELD ) {
      flag = rand()%2;
      if( flag && !ok &&
          ( static_cast<CSLisaField*>(*it) -> m_used[CSLisaField::SET_WIDTH] ||
            static_cast<CSLisaField*>(*it) -> m_used[CSLisaField::SET_RANGE] ||
            static_cast<CSLisaField*>(*it) -> m_used[CSLisaField::SET_BITRANGE] ) ) {
        m_range.append( (*it) -> getName() );
        m_range.append(".");
        m_range.append( ISA_FIELD_FUNCTION[CSLisaField::GET_LOWER]); 
        m_range.append( "()" );
        m_range.append(", ");
        m_range.append( (*it) -> getName() );
        m_range.append(".");
        m_range.append( ISA_FIELD_FUNCTION[CSLisaField::GET_UPPER]); 
        m_range.append( "()" );
        ok = true;
      }      
    }
  }
  if ( !ok ) {
    m_range.append( randNumExpr() );
    m_range.append(", ") ;
    m_range.append( randNumExpr() );
  }
}

void CSLisaField::genSetOffset( CSLbase* design) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ISA_FIELD ) {
      flag = rand()%2;
      if( flag && !ok &&
          static_cast<CSLisaField*>(*it) -> m_used[CSLisaField::GET_OFFSET]) {
        m_offset.append( (*it) -> getName() );
        m_offset.append(".");
        m_offset.append( ISA_FIELD_FUNCTION[CSLisaField::GET_OFFSET]); 
        m_offset.append( "()" );
        ok = true;
      }      
    }
  }
  if ( !ok ) {
    string offset;
    do {
      offset = randNumExpr();
    }
    while(offset == "0");
    m_offset.append( offset );
  }
}

void CSLisaField::genSetEnum( CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ENUM ) {
      flag = rand()%2;
      if( flag && !m_enumF) {
        m_enum.append( (*it) -> getName() );
        m_enumF = true;
      }      
    }
  }
}

void CSLisaField::genSetEnumItem( CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ENUM ) {
      CSLbaseVec ch1 = (*it) -> getChildren();
      vector<CSLbase*>::const_iterator it1 = ch1.begin();
      for (; it1 < ch1.end(); it1++) {
        flag = rand()%5;
        if( flag && !m_enumItemF) {
          m_enumItem.append( (*it1) -> getName() );
          m_enumItemF = true;
        }
      }      
    }
  }
}

void CSLisaField::genSetValue( CSLbase* design) {
  m_value.append( randNumExpr() );
}

void CSLisaField::genSetPosition( ) {
  int flag;
  CSLbaseVec ch = getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_INSTANCE ) {
      CSLbaseVec ch1 = (*it) -> getChildren();
      vector<CSLbase*>::const_iterator it1 = ch1.begin();
      for (; it1 < ch1.end(); it1++) {
        flag = rand()%2;
        if( flag ) {
          m_posField.push_back( (*it1) -> getName() );
          m_posNumExpr.push_back( randNumExpr() );
          static_cast<CSLisaField*>(*it1) -> m_posF = true;
          m_posF = true;
        }
      }
    }
    else {
      if ( (*it) -> getType() == CSL_ISA_FIELD ) {
        flag = rand()%2;
        if( flag ) {
          m_posField.push_back( (*it) -> getName() );
          m_posNumExpr.push_back( randNumExpr() );
          static_cast<CSLisaField*>(*it) -> m_posF = true;
          m_posF = true;
        }
      }
    }      
  }
}

void CSLisaField::genSetNext( ) {
  int flag;
  CSLbaseVec ch = getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_INSTANCE ) {
      CSLbaseVec ch1 = (*it) -> getChildren();
      vector<CSLbase*>::const_iterator it1 = ch1.begin();
      for (; it1 < ch1.end(); it1++) {
        //         flag = rand()%2;
        flag = 1;
        if( flag && 
            static_cast<CSLisaField*>(*it1) -> m_posF ) {

          vector<CSLbase*>::const_iterator it2 = (it1);
          for (++it2; it2 < ch1.end(); it2++) {
            flag = rand()%2;
            if( flag && 
                !static_cast<CSLisaField*>(*it2) -> m_posF &&
                !static_cast<CSLisaField*>(*it2) -> m_prevF ) {
              m_nextLeft.push_back( (*it1) -> getName() );
              m_nextRight.push_back( (*it2) ->getName() );
              static_cast<CSLisaField*>(*it2) -> m_nextF = true;
              m_nextF = true;
            }
          }
        }
      }
    }
    else {
      //         flag = rand()%2;
      flag = 1;
      if( flag && 
          static_cast<CSLisaField*>(*it) -> m_posF ) {

        vector<CSLbase*>::const_iterator it2 = (it);
        for (++it2; it2 < ch.end(); it2++) {
          flag = rand()%2;
          if( flag && 
              !static_cast<CSLisaField*>(*it2) -> m_posF && 
              !static_cast<CSLisaField*>(*it2) -> m_prevF  ) {
            m_nextLeft.push_back( (*it) -> getName() );
            m_nextRight.push_back( (*it2) ->getName() );
            static_cast<CSLisaField*>(*it2) -> m_nextF = true;
            m_nextF = true;
          }
        }
      }
    }      
  }
}

void CSLisaField::genSetPrevious( ) {
  int flag;
  CSLbaseVec ch = getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_INSTANCE ) {
      CSLbaseVec ch1 = (*it) -> getChildren();
      vector<CSLbase*>::const_iterator it1 = ch1.begin();
      for (; it1 < ch1.end(); it1++) {
        //         flag = rand()%2;
        flag = 1;
        if( flag && 
            static_cast<CSLisaField*>(*it1) -> m_posF ) {

          vector<CSLbase*>::const_iterator it2 = (it1);
          for (++it2; it2 < ch1.end(); it2++) {
            flag = rand()%2;
            if( flag && 
                !static_cast<CSLisaField*>(*it2) -> m_posF &&
                !static_cast<CSLisaField*>(*it2) -> m_nextF ) {
              m_prevLeft.push_back( (*it1) -> getName() );
              m_prevRight.push_back( (*it2) ->getName() );
              static_cast<CSLisaField*>(*it2) -> m_prevF = true;
              m_prevF = true;
            }
          }
        }
      }
    }
    else {
      //         flag = rand()%2;
      flag = 1;
      if( flag && 
          static_cast<CSLisaField*>(*it) -> m_posF ) {

        vector<CSLbase*>::const_iterator it2 = (it);
        for (++it2; it2 < ch.end(); it2++) {
          flag = rand()%2;
          if( flag && 
              !static_cast<CSLisaField*>(*it2) -> m_posF &&
              !static_cast<CSLisaField*>(*it2) -> m_nextF ) {
            m_prevLeft.push_back( (*it) -> getName() );
            m_prevRight.push_back( (*it2) ->getName() );
            static_cast<CSLisaField*>(*it2) -> m_prevF = true;
            m_prevF = true;
          }
        }
      }
    }      
  }
}

void CSLisaField::genAllowedRange() {
  m_allowedRange.append( randNumExpr() );
  m_allowedRange.append(",");
  m_allowedRange.append( randNumExpr() );
}

void CSLisaField::genEnum() {
  int flag;
  flag = rand()%3;
  switch( flag ) {
    case 0 : genSetEnum(getParent());     break;
    case 1 : genSetEnumItem(getParent()); break;
  }
}

void CSLisaField::genUpperLower() {
  m_upper.append( randNumExpr() );
  m_lower.append( randNumExpr() );
}

void CSLisaField::genCopyConstr(CSLbase* design ) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ISA_FIELD ) {
      flag = rand()%2;
      if( flag && !m_copyF ) {
        m_copy.append( (*it) -> getName() );
        m_copyF = true;
      }      
    }
  }
}

void CSLisaField::genSetType(CSLbase* design) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ISA_FIELD && 
        static_cast<CSLisaField*>(*it) -> m_used[CSLisaField::GET_TYPE] ) {
      flag = rand()%2;
      if( flag && !ok ) {
        m_setType.append( static_cast<CSLisaField*>(*it) -> m_name);
        m_setType.append(".");
        m_setType.append(ISA_FIELD_FUNCTION[CSLisaField::GET_TYPE]);
        m_setType.append("()");
        ok = true;
      }
    }      
  }
  if( !ok ) {
    m_setType.append( ISA_FIELD_TYPE[ rand()% ISA_FIELD_TYPE_NO] );
  }
}

void CSLisaField::genSetName(CSLbase* design) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ISA_FIELD && 
        static_cast<CSLisaField*>(*it) -> m_used[CSLisaField::GET_NAME] ) {
      flag = rand()%2;
      if( flag && !ok ) {
        m_setName.append( static_cast<CSLisaField*>(*it) -> m_name );
        m_setName.append(".");
        m_setName.append(ISA_FIELD_FUNCTION[CSLisaField::GET_NAME]);
        m_setName.append("()");
        ok = true;
      }
    }      
  }
  if( !ok ) {
    m_setName.append( "\"" );
    m_setName.append( randString() );
    m_setName.append( "\"" );
  }
}

void CSLisaField::genSetMnemonic(CSLbase* design) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ISA_FIELD && 
        static_cast<CSLisaField*>(*it) -> m_used[CSLisaField::GET_MNEMONIC] ) {
      flag = rand()%2;
      if( flag && !ok ) {
        m_setMnemonic.append( static_cast<CSLisaField*>(*it) -> m_name );
        m_setMnemonic.append(".");
        m_setMnemonic.append(ISA_FIELD_FUNCTION[CSLisaField::GET_MNEMONIC]);
        m_setMnemonic.append("()");
        ok = true;
      }
    }      
  }
  if( !ok ) {
    m_setMnemonic.append( "\"" );
    m_setMnemonic.append( randString() );
    m_setMnemonic.append( "\"" );
  }
}

bool CSLisaField::buildDecl() {
  int ranType;
  if( m_fieldTypeF || m_elementTypeF ) 
    ranType = rand()%(ISA_FIELD_TYPE_DECL_SIZE-1);
  else
    ranType = rand()%ISA_FIELD_TYPE_DECL_SIZE;
  int flag;
  bool ok = false;

  //  if( getParent()->getType() == CSL_DESIGN ) {
//   genSetType(getParent());
//   m_used[CSLisaField::SET_TYPE] = 1;
//   m_used[CSLisaField::GET_TYPE] = 1;
  //  }
  //  ranType = CSLisaField::CONSTR;
  switch( ranType ) {
    case CSLisaField::WIDTH        : genSetWidth(getParent());     genEnum(); break;
    case CSLisaField::UPPER_LOWER  : genUpperLower();              genEnum(); break;
    case CSLisaField::COPY_CONSTR  : genCopyConstr(getParent());   break;
    case CSLisaField::CONSTR       : 

      for ( int j = 0; j < ISA_FIELDS_NO; ++j ) {
        int flag;
        string name( string("") );
        name.append( randString() );
        if (newNameIsValid( name ) == true ) {
          CSLisaField* isaField = new CSLisaField( this, name );
          isaField -> m_fieldTypeF = true;
          isaField -> buildDecl();
          addChild( isaField );
        }
      }
      if( ISA_FIELDS_NO ) 
        m_hierarchicalF = true;
 
      int ranWidth = rand()%3;
      if( m_hierarchicalF ) {
        switch( ranWidth ) {
          case 0: genSetWidth(getParent()); m_used[CSLisaField::SET_WIDTH] = 1; break;
          case 1: genSetRange(getParent()); m_used[CSLisaField::SET_RANGE] = 1; break;
          case 2: genSetBitrange(getParent());  m_used[CSLisaField::SET_BITRANGE] = 1; break;
        }
      }

      int cmdNo = rand()%ISA_FIELD_CMD;
      for(int i = 0; i < cmdNo; ++i){
        int ran = rand()%(ISA_FIELD_USED_VECTOR_SIZE);
        if( !m_used[ran] ) {
          if( (ran == CSLisaField::SET_ENUM || 
               ran == CSLisaField::SET_ENUM_ITEM || 
               ran == CSLisaField::SET_VALUE) && 
              !ok && !m_hierarchicalF ) {
            switch( ran ) {
              case CSLisaField::SET_ENUM            : 
                genSetEnum(getParent());  
                m_used[CSLisaField::SET_ENUM] = 1;
                break;
              case CSLisaField::SET_ENUM_ITEM       : 
                genSetEnumItem(getParent()); 
                m_used[CSLisaField::SET_ENUM_ITEM] = 1;           
                break;
              case CSLisaField::SET_VALUE           : 
                genSetValue(getParent()); 
                m_used[CSLisaField::SET_VALUE] = 1;
                break;
            }
            ok = true;
          }
          else
            if( ran == CSLisaField::GET_ENUM || 
                ran == CSLisaField::GET_ENUM_ITEM || 
                ran == CSLisaField::GET_VALUE 
                && !m_hierarchicalF) {
              switch( ran ) {
                case CSLisaField::GET_ENUM            :
                  if( m_used[CSLisaField::SET_ENUM] )
                    m_used[CSLisaField::GET_ENUM] = 1;
                  break;
                case CSLisaField::GET_ENUM_ITEM       : 
                  if( m_used[CSLisaField::SET_ENUM_ITEM] )
                    m_used[CSLisaField::GET_ENUM_ITEM] = 1;
                  break;
                case CSLisaField::GET_VALUE           : 
                  if( m_used[CSLisaField::SET_VALUE] )
                    m_used[CSLisaField::GET_VALUE] = 1;
                  break;
              }
            }
            else
              if( ran >= CSLisaField::SET_FIELD_POS && 
                  ran <= CSLisaField::SET_PREVIOUS ) {
                switch( ran ) {
                  case CSLisaField::SET_FIELD_POS       : 
                    genSetPosition(); 
                    m_used[CSLisaField::SET_FIELD_POS] = 1;
                    break;
                  case CSLisaField::SET_NEXT            : 
                    genSetNext(); 
                    m_used[CSLisaField::SET_NEXT] = 1;
                    break;
                  case CSLisaField::SET_PREVIOUS        : 
                    genSetPrevious(); 
                    m_used[CSLisaField::SET_PREVIOUS] = 1;
                    break;
                }
              }
              else {
                switch( ran ) {
                  //                   case CSLisaField::SET_WIDTH           : 
                  //                     genSetWidth(getParent()); 
                  //                     m_used[CSLisaField::SET_WIDTH] = 1;
                  //                     m_used[CSLisaField::GET_WIDTH] = 1;
                  //                     break;
                  case CSLisaField::GET_WIDTH           : 
                    m_used[CSLisaField::GET_WIDTH] = 1;
                    break;
                    //                   case CSLisaField::SET_BITRANGE        : 
                    //                     genSetBitrange(getParent()); 
                    //                     m_used[CSLisaField::SET_BITRANGE] = 1;
                    //                     m_used[CSLisaField::GET_BITRANGE] = 1;
                    //                     break;
                    //                   case CSLisaField::GET_BITRANGE        : 
                    //                     if( m_used[CSLisaField::SET_BITRANGE] )
                    //                       m_used[CSLisaField::GET_BITRANGE] = 1;
                    //                     break;
                  case CSLisaField::GET_UPPER           :
                    m_used[CSLisaField::GET_UPPER] = 1;
                    break;
                  case CSLisaField::GET_LOWER           :
                    m_used[CSLisaField::GET_LOWER] = 1;
                    break;
                    //                   case CSLisaField::SET_RANGE           : 
                    //                     genSetRange(getParent()); 
                    //                     m_used[CSLisaField::SET_RANGE] = 1;
                    //                     m_used[CSLisaField::GET_RANGE] = 1;
                    //                     break;
                    //                   case CSLisaField::GET_RANGE           : 
                    //                     if( m_used[CSLisaField::SET_RANGE] )
                    //                       m_used[CSLisaField::GET_RANGE] = 1;
                    //                     break;
                  case CSLisaField::SET_OFFSET          : 
                    genSetOffset(getParent()); 
                    m_used[CSLisaField::SET_OFFSET] = 1;
                    break;
                  case CSLisaField::GET_OFFSET          : 
                    if( m_used[CSLisaField::SET_OFFSET] )
                      m_used[CSLisaField::GET_OFFSET] = 1;
                    break;
                  case CSLisaField::ADD_ALLOWED_RANGE   : 
                    genAllowedRange();
                    m_used[CSLisaField::ADD_ALLOWED_RANGE] = 1;
                    break;
                  case CSLisaField::SET_NAME            : 
                    genSetName(getParent());
                    m_used[CSLisaField::SET_NAME] = 1;
                  case CSLisaField::GET_NAME            : 
                    if( m_used[CSLisaField::SET_NAME])
                      m_used[CSLisaField::GET_NAME] = 1;
                  case CSLisaField::SET_MNEMONIC        :
                    genSetMnemonic(getParent());
                    m_used[CSLisaField::SET_MNEMONIC] = 1;
                  case CSLisaField::GET_MNEMONIC        : 
                    if( m_used[CSLisaField::SET_MNEMONIC])
                      m_used[CSLisaField::GET_MNEMONIC] = 1;
                }
              }
        }
      }
      break;
  }
  m_usedTypeDecl[ranType] = 1;

  if( m_usedTypeDecl[CSLisaField::COPY_CONSTR] && !m_copyF ) {
    return false;
  }
  else {
    return true;
  }
}

void CSLisaField::print() {
  if( !m_printF ) {
    if( m_usedTypeDecl[CSLisaField::COPY_CONSTR] && !m_copyF ) {}
    else {
      cslIsaField( m_out );
      (*m_out) << getName();
    }
    int i = 0;
    while ( !m_usedTypeDecl[i] && i < CSLisaField::CONSTR-1 ) {
      ++i;
    }

    if( m_usedTypeDecl[i] ) {
      switch( i ) {
        case CSLisaField::WIDTH       :
          lParenthesis(m_out);
          (*m_out) << m_width;
          if( m_used[CSLisaField::SET_ENUM] || m_used[CSLisaField::SET_ENUM_ITEM] ) {
            comma(m_out);
          }
          break;
        case CSLisaField::UPPER_LOWER :
          lParenthesis(m_out);
          (*m_out) << m_upper;
          comma(m_out);
          (*m_out) << m_lower;
          if( m_used[CSLisaField::SET_ENUM] || m_used[CSLisaField::SET_ENUM_ITEM] ) {
            comma(m_out);
          }
          break;
        case CSLisaField::COPY_CONSTR    :
          if( m_copyF ) {
            lParenthesis(m_out);
            (*m_out) << m_copy;
          }
          break;
      }

      if( m_usedTypeDecl[i] != m_usedTypeDecl[CSLisaField::CONSTR] ) {

        if ( m_used[CSLisaField::SET_ENUM] ) {
          (*m_out) << m_enum;
          //          rParenthesis(m_out);
        }
        else
          if( m_used[CSLisaField::SET_ENUM_ITEM]) {
            (*m_out) << m_enumItem;
            //            rParenthesis(m_out);
          }   
        if( m_usedTypeDecl[CSLisaField::COPY_CONSTR] && !m_copyF) {} 
        else {
          rParenthesis(m_out);
          semicolon((m_out));
        }

      } 
    }
  }
  //           rParenthesis(m_out);
  if( ( m_printF || ( getParent() -> getType() == CSL_DESIGN ) )
      && !m_usedTypeDecl[CSLisaField::CONSTR] ) {
    if( m_usedTypeDecl[CSLisaField::COPY_CONSTR] && !m_copyF) {}
    else
    if( m_used[CSLisaField::SET_TYPE] ) {
      (*m_out) << m_name << "." 
               << ISA_FIELD_FUNCTION[CSLisaField::SET_TYPE];
      lParenthesis(m_out);
      (*m_out) << m_setType;
      rParenthesis(m_out);
      semicolon(m_out);
    }
  }
  
  if ( m_usedTypeDecl[CSLisaField::CONSTR] ) {
    lCbrace( (m_out) );
    CSLbaseVec ch = getChildren();
    vector<CSLbase*>::const_iterator it =  ch.begin();
    for (; it < ch.end(); it++) {
      (*m_out) << "  ";
      (*it) -> print();
    }
    (*m_out) << "    " << getName();
    lParenthesis((m_out));
    rParenthesis((m_out));
    lCbrace((m_out));   

    for( int i = 0; i < ISA_FIELD_USED_VECTOR_SIZE; ++i ) {
      if ( m_used[i] ) {
        switch( i ) {
          case CSLisaField::SET_WIDTH          : funct1param( m_out, ISA_FIELD_FUNCTION[i], m_width); break;
          case CSLisaField::SET_BITRANGE       :  
            if( m_bitrangeF )                 funct1param( m_out, ISA_FIELD_FUNCTION[i], m_bitrange); break;
          case CSLisaField::SET_RANGE          : funct1param( m_out, ISA_FIELD_FUNCTION[i], m_range); break;

          case CSLisaField::SET_ENUM           : 
            if( m_enumF )                     funct1param( m_out, ISA_FIELD_FUNCTION[i], m_enum); break;
          case CSLisaField::SET_ENUM_ITEM      : 
            if( m_enumItemF )                 funct1param( m_out, ISA_FIELD_FUNCTION[i], m_enumItem); break;
          case CSLisaField::SET_VALUE          : funct1param( m_out, ISA_FIELD_FUNCTION[i], m_value); break;
          case CSLisaField::SET_FIELD_POS      : 
            if( m_posF ) {
              int it = 0;
              for(; it < m_posField.size(); ++it) {
                funct2param( m_out, ISA_FIELD_FUNCTION[i], m_posField.at(it), m_posNumExpr.at(it)); 
              }
            }
            break;
          case CSLisaField::SET_NEXT           : 
            if( m_nextF ) {
              int it1 = 0;
              for(; it1 < m_nextLeft.size(); ++it1) {
                funct2param( m_out, ISA_FIELD_FUNCTION[i], m_nextLeft[it1], m_nextRight[it1] ); 
              }
            }
            break;
          case CSLisaField::SET_PREVIOUS       : 
            if( m_prevF ) {
              int it2 = 0;
              for(; it2 < m_prevLeft.size(); ++it2) {
                funct2param( m_out, ISA_FIELD_FUNCTION[i], m_prevLeft[it2], m_prevRight[it2] ); 
              }
            }
            break;
            //           case CSLisaField::GET_WIDTH          : funct0param( m_out, ISA_FIELD_FUNCTION[i] ) ; break;
            //           case CSLisaField::GET_LOWER          : funct0param( m_out, ISA_FIELD_FUNCTION[i] ) ; break;
            //           case CSLisaField::GET_UPPER          : funct0param( m_out, ISA_FIELD_FUNCTION[i] ) ; break;
          case CSLisaField::SET_OFFSET         : funct1param( m_out, ISA_FIELD_FUNCTION[i], m_offset); break;
          case CSLisaField::ADD_ALLOWED_RANGE  : funct1param( m_out, ISA_FIELD_FUNCTION[i], m_allowedRange); break;
          case CSLisaField::SET_TYPE           :
            (*m_out) << "     " << ISA_FIELD_FUNCTION[CSLisaField::SET_TYPE];
            lParenthesis(m_out);
            (*m_out) << m_setType;
            rParenthesis(m_out);
            semicolon(m_out);

        } 
      } 
    }  
    (*m_out)<<"  ";
    rCbrace((m_out));
    rCbrace((m_out));
    semicolon((m_out));
  }
}

void CSLdesign::addIsaElement() {
  int flag;
  string name( string("") );
  name.append( randString() );
  if (newNameIsValid( name ) == true ) {
    CSLisaElement* isaElement = new CSLisaElement( this, name );
    flag = rand()%2;
    if ( flag ) { 
      for ( int i = 0; i < ISA_ELEMENT_INSTANCE_NO; ++i) {
        isaElement -> addIsaElementInstance(isaElement -> getParent());
      }
      isaElement -> buildDecl();
      addChild( isaElement );
    }
  }
}

void CSLisaElement::addIsaElementInstance(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ISA_FIELD ) {
      flag = rand()%2;
      //flag = 1;
      if( flag ) {
        string name(string(""));
        name.append(randString());
        if (newNameIsValid(name) == true ) {
          CSLinstance* isaElementInstance = new CSLinstance(this, (*it), name);
          addChild(isaElementInstance);
        }
      }

    }
  }
}


void CSLisaElement::genDeriv(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ISA_ELEMENT ) {
      flag = rand()%2;
      if( flag && !m_derivF ) {
        m_deriv.append( (*it) -> getName() );
        m_derivF = true;
      }
    }
  }
}

void CSLisaElement::genSetType( CSLbase* design ) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ISA_ELEMENT && 
        static_cast<CSLisaElement*>(*it) -> m_used[CSLisaElement::GET_TYPE] ) {
      flag = rand()%2;
      if( flag && !ok ) {
        m_setType.append( static_cast<CSLisaElement*>(*it) -> m_name);
        m_setType.append(".");
        m_setType.append(ISA_ELEMENT_FUNCTION[CSLisaElement::GET_TYPE]);
        m_setType.append("()");
        ok = true;
      }
    }      
  }
  if( !ok ) {
    m_setType.append( ISA_ELEMENT_TYPE[ rand()% ISA_ELEMENT_TYPE_NO] );
  }
}
void CSLisaElement::genSetWidth( CSLbase* design ) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ISA_ELEMENT ) {
      flag = rand()%2;
      if( flag && !ok &&
          ( static_cast<CSLisaElement*>(*it) -> m_used[CSLisaElement::SET_WIDTH] )) {
        m_width.append( (*it) -> getName() );
        m_width.append(".");
        m_width.append( ISA_ELEMENT_FUNCTION[CSLisaElement::GET_WIDTH]); 
        m_width.append( "()" );
        ok = true;
      }      
    }
  }
  if ( !ok ) {
    string width;
    do {
      width = randNumExpr();
    }
    while (width == "0");
    m_width.append( width );
  }
}

void CSLisaElement::genSetPosition( ) {
  int flag;
  CSLbaseVec ch = getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_INSTANCE ) {
      CSLbaseVec ch1 = (*it) -> getChildren();
      vector<CSLbase*>::const_iterator it1 = ch1.begin();
      for (; it1 < ch1.end(); it1++) {
        flag = rand()%2;
        if( flag ) {
          m_posField.push_back( (*it1) -> getName() );
          m_posNumExpr.push_back( randNumExpr() );
          static_cast<CSLisaField*>(*it1) -> m_posF = true;
          m_posF = true;
        }
      }
    }
    else {
      if ( (*it) -> getType() == CSL_ISA_FIELD ) {
        flag = rand()%2;
        if( flag ) {
          m_posField.push_back( (*it) -> getName() );
          m_posNumExpr.push_back( randNumExpr() );
          static_cast<CSLisaField*>(*it) -> m_posF = true;
          m_posF = true;
        }
      }
    }      
  }
}

void CSLisaElement::genSetNext( ) {
  int flag;
  CSLbaseVec ch = getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_INSTANCE ) {
      CSLbaseVec ch1 = (*it) -> getChildren();
      vector<CSLbase*>::const_iterator it1 = ch1.begin();
      for (; it1 < ch1.end(); it1++) {
        flag = rand()%2;
        if( flag && 
            static_cast<CSLisaField*>(*it1) -> m_posF ) {

          vector<CSLbase*>::const_iterator it2 = (it1);
          for (++it2; it2 < ch1.end(); it2++) {
            flag = rand()%2;
            if( flag && 
                !static_cast<CSLisaField*>(*it2) -> m_posF &&
                !static_cast<CSLisaField*>(*it2) -> m_prevF ) {
              m_nextLeft.push_back( (*it1) -> getName() );
              m_nextRight.push_back( (*it2) ->getName() );
              static_cast<CSLisaField*>(*it2) -> m_nextF = true;
              m_nextF = true;
            }
          }
        }
      }
    }
    else {
      flag = rand()%2;
      if( flag && 
          static_cast<CSLisaField*>(*it) -> m_posF ) {

        vector<CSLbase*>::const_iterator it2 = (it);
        for (++it2; it2 < ch.end(); it2++) {
          flag = rand()%2;
          if( flag && 
              !static_cast<CSLisaField*>(*it2) -> m_posF && 
              !static_cast<CSLisaField*>(*it2) -> m_prevF  ) {
            m_nextLeft.push_back( (*it) -> getName() );
            m_nextRight.push_back( (*it2) ->getName() );
            static_cast<CSLisaField*>(*it2) -> m_nextF = true;
            m_nextF = true;
          }
        }
      }
    }      
  }
}

void CSLisaElement::genSetPrevious( ) {
  int flag;
  CSLbaseVec ch = getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_INSTANCE ) {
      CSLbaseVec ch1 = (*it) -> getChildren();
      vector<CSLbase*>::const_iterator it1 = ch1.begin();
      for (; it1 < ch1.end(); it1++) {
        flag = rand()%2;
        //        flag = 1;
        if( flag && 
            static_cast<CSLisaField*>(*it1) -> m_posF ) {

          vector<CSLbase*>::const_iterator it2 = (it1);
          for (++it2; it2 < ch1.end(); it2++) {
            flag = rand()%2;
            if( flag && 
                !static_cast<CSLisaField*>(*it2) -> m_posF &&
                !static_cast<CSLisaField*>(*it2) -> m_nextF ) {
              m_prevLeft.push_back( (*it1) -> getName() );
              m_prevRight.push_back( (*it2) ->getName() );
              static_cast<CSLisaField*>(*it2) -> m_prevF = true;
              m_prevF = true;
            }
          }
        }
      }
    }
    else {
       flag = rand()%2;
       //      flag = 1;
      if( flag && 
          static_cast<CSLisaField*>(*it) -> m_posF ) {

        vector<CSLbase*>::const_iterator it2 = (it);
        for (++it2; it2 < ch.end(); it2++) {
          flag = rand()%2;
          if( flag && 
              !static_cast<CSLisaField*>(*it2) -> m_posF &&
              !static_cast<CSLisaField*>(*it2) -> m_nextF ) {
            m_prevLeft.push_back( (*it) -> getName() );
            m_prevRight.push_back( (*it2) ->getName() );
            static_cast<CSLisaField*>(*it2) -> m_prevF = true;
            m_prevF = true;
          }
        }
      }
    }      
  }
}

bool CSLisaElement::buildDecl() {

  genDeriv(getParent());

  genSetType(getParent());
  //  m_used[CSLisaElement::SET_TYPE] = 1;


  for ( int j = 0; j < ISA_FIELDS_NO; ++j ) {
    int flag;
    string name( string("") );
    name.append( randString() );
    if (newNameIsValid( name ) == true ) {
      CSLisaField* isaField = new CSLisaField( this, name );
      isaField -> m_elementTypeF = true;
      isaField -> buildDecl();
      addChild( isaField );
    }
  }

  for( int i =0; i < rand()%ISA_ELEMENT_CMD; ++i ) {
    int ran = rand()%ISA_ELEMENT_USED_VECTOR_SIZE;
    if( !m_used[ran] ) {        
      switch( ran ) {
        case CSLisaElement::SET_WIDTH       : 
          if( m_setType == "root_format") {
            genSetWidth(getParent()); 
            m_used[CSLisaElement::SET_WIDTH] = 1;
          }
          break;
        case CSLisaElement::SET_FIELD_POS   : genSetPosition(); break;
        case CSLisaElement::SET_NEXT        : genSetNext();     break;
        case CSLisaElement::SET_PREVIOUS    : genSetPrevious(); break;
      }  
      if( ran == CSLisaElement::GET_TYPE && m_used[CSLisaElement::SET_TYPE] ) {
        m_used[CSLisaElement::GET_TYPE] = 1;
      } 
      else
        if( ran == CSLisaElement::GET_WIDTH && m_used[CSLisaElement::SET_WIDTH] ) {
          m_used[CSLisaElement::GET_WIDTH] = 1;
        } 
        else
          if( ran != CSLisaElement::SET_WIDTH )
            m_used[ran] = 1;
    }
  }
}

void CSLisaElement::print(){
  cslIsaElement(m_out);
  (*m_out) << getName();//  isa_name

  if( m_derivF )
    (*m_out) << " : " << m_deriv;
  lCbrace( (m_out) );

  CSLbaseVec ch = getChildren();
  vector<CSLbase*>::const_iterator it =  ch.begin();
  for (; it < ch.end(); it++) {
    (*m_out) << "  ";
    (*it) -> print();
  }

  (*m_out) << "    " << getName();
  lParenthesis((m_out));
  rParenthesis((m_out));
  lCbrace((m_out));   

  for( int i =0; i < rand()%ISA_ELEMENT_CMD; ++i ) {
    if( m_used[i] ) {        
      switch( i ) {
        case CSLisaElement::SET_TYPE        : 
          funct1param( m_out, ISA_ELEMENT_FUNCTION[i], m_setType); 
          break;
        case CSLisaElement::SET_WIDTH       : 
          funct1param( m_out, ISA_ELEMENT_FUNCTION[i], m_width); 
          break;
        case CSLisaElement::SET_FIELD_POS   :
          if( m_posF ) {
            int it = 0;
            for(; it < m_posField.size(); ++it) {
              funct2param( m_out, ISA_ELEMENT_FUNCTION[i], m_posField.at(it), m_posNumExpr.at(it)); 
            }
          }
          break;
        case CSLisaElement::SET_NEXT        : 
          if( m_nextF ) {
            int it1 = 0;
            for(; it1 < m_nextLeft.size(); ++it1) {
              funct2param( m_out, ISA_ELEMENT_FUNCTION[i], m_nextLeft[it1], m_nextRight[it1] ); 
            }
          }
          break;
        case CSLisaElement::SET_PREVIOUS    : 
          if( m_prevF ) {
            int it2 = 0;
            for(; it2 < m_prevLeft.size(); ++it2) {
              funct2param( m_out, ISA_ELEMENT_FUNCTION[i], m_prevLeft[it2], m_prevRight[it2] ); 
            }
          }
          break;
      }  
    }
  }

  for ( it =  ch.begin(); it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ISA_FIELD ) {
    static_cast<CSLisaField*>(*it) -> m_printF = true;
    (*m_out) << "     ";
    (*it) -> print();
    }
  }


  (*m_out)<<"  ";
  rCbrace((m_out));
  rCbrace((m_out));
  semicolon((m_out));    
}

}
