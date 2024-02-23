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

#include "cslField.h"

using namespace std;
namespace NSCSLinterconnect {

void CSLdesign::addField() {
  int flag;
  string name( string("") );
  name.append( randString() );
  if (newNameIsValid( name ) == true ) {
    CSLfield* field = new CSLfield( this, name );
    flag = rand()%2;
    if ( flag ) 
      for ( int i = 0; i < FIELD_INSTANCE_NO; ++i) {
        field -> addFieldInstance(field -> getParent());
      }

    bool rez = field -> buildDecl();
     if( rez ) {
        addChild( field );
     }
     else {
       delete field;
     }
  }
}

void CSLfield::addFieldInstance(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      //      flag = rand()%2;
      // (*m_out) << "field name = " << (*it) -> getName() << endl;
      flag = 1;
      if( flag ) {
        string name(string(""));
        name.append(randString());
        if (newNameIsValid(name) == true ) {
          CSLinstance* fieldInstance = new CSLinstance(this, (*it), name);
          addChild(fieldInstance);
          this -> m_hierarchicalF = true;
        }
      }

    }
  }     
}

void CSLfield::genSetWidth( CSLbase* design) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      flag = rand()%2;
      if( flag && !ok &&
          ( static_cast<CSLfield*>(*it) -> m_used[CSLfield::SET_WIDTH] ||
            static_cast<CSLfield*>(*it) -> m_used[CSLfield::SET_RANGE] ||
            static_cast<CSLfield*>(*it) -> m_used[CSLfield::SET_BITRANGE] ) ) {
        m_width.append( (*it) -> getName() );
        m_width.append(".");
        m_width.append( FIELD_FUNCTION[CSLfield::GET_WIDTH]); 
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

void CSLfield::genSetBitrange( CSLbase* design) {
  bool ok = false;
  int flag;
  //    CSLbaseVec ch = design -> getChildren();
  //    vector<CSLbase*>::const_iterator it = ch.begin();
  //    for (; it < ch.end(); it++) {
  //      if( (*it) -> getType() == CSL_FIELD ) {
  //        flag = rand()%2;
  //        if( flag && !ok &&
  //            static_cast<CSLfield*>(*it) -> m_used[CSLfield::GET_BITRANGE]) {
  //          m_bitrange.append( (*it) -> getName() );
  //          m_bitrange.append(".");
  //          m_bitrange.append( FIELD_FUNCTION[CSLfield::GET_BITRANGE]); 
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

void CSLfield::genSetRange( CSLbase* design) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      flag = rand()%2;
      if( flag && !ok &&
          ( static_cast<CSLfield*>(*it) -> m_used[CSLfield::SET_WIDTH] ||
            static_cast<CSLfield*>(*it) -> m_used[CSLfield::SET_RANGE] ||
            static_cast<CSLfield*>(*it) -> m_used[CSLfield::SET_BITRANGE] ) ) {
        m_range.append( (*it) -> getName() );
        m_range.append(".");
        m_range.append( FIELD_FUNCTION[CSLfield::GET_LOWER]); 
        m_range.append( "()" );
        m_range.append(", ");
        m_range.append( (*it) -> getName() );
        m_range.append(".");
        m_range.append( FIELD_FUNCTION[CSLfield::GET_UPPER]); 
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

void CSLfield::genSetOffset( CSLbase* design) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      flag = rand()%2;
      if( flag && !ok &&
          static_cast<CSLfield*>(*it) -> m_used[CSLfield::GET_OFFSET]) {
        m_offset.append( (*it) -> getName() );
        m_offset.append(".");
        m_offset.append( FIELD_FUNCTION[CSLfield::GET_OFFSET]); 
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

void CSLfield::genSetEnum( CSLbase* design) {
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

void CSLfield::genSetEnumItem( CSLbase* design) {
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

void CSLfield::genSetValue( CSLbase* design) {
  m_value.append( randNumExpr() );
}

void CSLfield::genSetFieldPos( ) {
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
          static_cast<CSLfield*>(*it1) -> m_posF = true;
          m_posF = true;
        }
      }
    }
    else {
      if (  (*it) -> getType() == CSL_FIELD ) {
        flag = rand()%2;
        if( flag ) {
          m_posField.push_back( (*it) -> getName() );
          m_posNumExpr.push_back( randNumExpr() );
          static_cast<CSLfield*>(*it) -> m_posF = true;
          m_posF = true;
        }
      }
    }      
  }
}

void CSLfield::genNext( ) {
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
            static_cast<CSLfield*>(*it1) -> m_posF ) {

          vector<CSLbase*>::const_iterator it2 = (it1);
          for (++it2; it2 < ch1.end(); it2++) {
            flag = rand()%2;
            if( flag && 
                !static_cast<CSLfield*>(*it2) -> m_posF &&
                !static_cast<CSLfield*>(*it2) -> m_prevF ) {
              m_nextLeft.push_back( (*it1) -> getName() );
              m_nextRight.push_back( (*it2) ->getName() );
              static_cast<CSLfield*>(*it2) -> m_nextF = true;
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
          static_cast<CSLfield*>(*it) -> m_posF ) {

        vector<CSLbase*>::const_iterator it2 = (it);
        for (++it2; it2 < ch.end(); it2++) {
          flag = rand()%2;
          if( flag && 
              !static_cast<CSLfield*>(*it2) -> m_posF && 
              !static_cast<CSLfield*>(*it2) -> m_prevF  ) {
            m_nextLeft.push_back( (*it) -> getName() );
            m_nextRight.push_back( (*it2) ->getName() );
            static_cast<CSLfield*>(*it2) -> m_nextF = true;
            m_nextF = true;
          }
        }
      }
    }      
  }
}

void CSLfield::genPrevious( ) {
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
            static_cast<CSLfield*>(*it1) -> m_posF ) {

          vector<CSLbase*>::const_iterator it2 = (it1);
          for (++it2; it2 < ch1.end(); it2++) {
            flag = rand()%2;
            if( flag && 
                !static_cast<CSLfield*>(*it2) -> m_posF &&
                !static_cast<CSLfield*>(*it2) -> m_nextF ) {
              m_prevLeft.push_back( (*it1) -> getName() );
              m_prevRight.push_back( (*it2) ->getName() );
              static_cast<CSLfield*>(*it2) -> m_prevF = true;
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
          static_cast<CSLfield*>(*it) -> m_posF ) {

        vector<CSLbase*>::const_iterator it2 = (it);
        for (++it2; it2 < ch.end(); it2++) {
          flag = rand()%2;
          if( flag && 
              !static_cast<CSLfield*>(*it2) -> m_posF &&
              !static_cast<CSLfield*>(*it2) -> m_nextF ) {
            m_prevLeft.push_back( (*it) -> getName() );
            m_prevRight.push_back( (*it2) ->getName() );
            static_cast<CSLfield*>(*it2) -> m_prevF = true;
            m_prevF = true;
          }
        }
      }
    }      
  }
}

void CSLfield::genAllowedRange() {
  m_allowedRange.append( randNumExpr() );
  m_allowedRange.append(",");
  m_allowedRange.append( randNumExpr() );
}

void CSLfield::genEnum() {
  int flag;
  flag = rand()%3;
  switch( flag ) {
    case 0 : genSetEnum(getParent());     break;
    case 1 : genSetEnumItem(getParent()); break;
  }
}

void CSLfield::genUpperLower() {
  m_upper.append( randNumExpr() );
  m_lower.append( randNumExpr() );
}

void CSLfield::genCopyConstr(CSLbase* design ) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      flag = rand()%2;
      if( flag && !m_copyF ) {
        m_copy.append( (*it) -> getName() );
        m_copyF = true;
      }      
    }
  }
}

bool CSLfield::buildDecl() {
  int ranType;
  if( m_fieldType ) 
    ranType = rand()%(FIELD_TYPE_DECL_SIZE-1);
  else
    ranType = rand()%FIELD_TYPE_DECL_SIZE;
  int flag;
  bool ok = false;
  switch( ranType ) {
    case CSLfield::WIDTH        : genSetWidth(getParent());     genEnum(); break;
    case CSLfield::UPPER_LOWER  : genUpperLower();              genEnum(); break;
    case CSLfield::COPY_CONSTR  : genCopyConstr(getParent());   break;
    case CSLfield::CONSTR       : 

      for ( int j = 0; j < FIELDS_NO; ++j ) {
        int flag;
        string name( string("") );
        name.append( randString() );
        if (newNameIsValid( name ) == true ) {
          CSLfield* field = new CSLfield( this, name );
          field -> m_fieldType = true;
          if( field -> buildDecl() )
            addChild( field );
          else
            delete field;
        }
      }
      if( FIELDS_NO ) 
        m_hierarchicalF = true;
 
      int ranWidth = rand()%3;
      if( m_hierarchicalF ) {
      switch( ranWidth ) {
        case 0: genSetWidth(getParent()); m_used[CSLfield::SET_WIDTH] = 1; break;
        case 1: genSetRange(getParent()); m_used[CSLfield::SET_RANGE] = 1; break;
        case 2: genSetBitrange(getParent());  m_used[CSLfield::SET_BITRANGE] = 1; break;
      }
      }

      for(int i = 0; i < rand()%FIELD_CMD; ++i){
        int ran = rand()%(FIELD_USED_VECTOR_SIZE);
        if( !m_used[ran] ) {
          if( (ran == CSLfield::SET_ENUM || 
               ran == CSLfield::SET_ENUM_ITEM || 
               ran == CSLfield::SET_VALUE) && 
              !ok && !m_hierarchicalF ) {
            switch( ran ) {
              case CSLfield::SET_ENUM            : 
                genSetEnum(getParent());  
                m_used[CSLfield::SET_ENUM] = 1;
                break;
              case CSLfield::SET_ENUM_ITEM       : 
                genSetEnumItem(getParent()); 
                m_used[CSLfield::SET_ENUM_ITEM] = 1;           
                break;
              case CSLfield::SET_VALUE           : 
                genSetValue(getParent()); 
                m_used[CSLfield::SET_VALUE] = 1;
                break;
            }
            ok = true;
          }
          else
            if( ran == CSLfield::GET_ENUM || 
                ran == CSLfield::GET_ENUM_ITEM || 
                ran == CSLfield::GET_VALUE 
                && !m_hierarchicalF) {
              switch( ran ) {
                case CSLfield::GET_ENUM            :
                  if( m_used[CSLfield::SET_ENUM] )
                    m_used[CSLfield::GET_ENUM] = 1;
                  break;
                case CSLfield::GET_ENUM_ITEM       : 
                  if( m_used[CSLfield::SET_ENUM_ITEM] )
                    m_used[CSLfield::GET_ENUM_ITEM] = 1;
                  break;
                case CSLfield::GET_VALUE           : 
                  if( m_used[CSLfield::SET_VALUE] )
                    m_used[CSLfield::GET_VALUE] = 1;
                  break;
              }
            }
            else
              if( ran >= CSLfield::SET_FIELD_POS && 
                  ran <= CSLfield::SET_PREVIOUS ) {
                switch( ran ) {
                  case CSLfield::SET_FIELD_POS       : 
                    genSetFieldPos(); 
                    m_used[CSLfield::SET_FIELD_POS] = 1;
                    break;
                  case CSLfield::SET_NEXT            : 
                    genNext(); 
                    m_used[CSLfield::SET_NEXT] = 1;
                    break;
                  case CSLfield::SET_PREVIOUS        : 
                    genPrevious(); 
                    m_used[CSLfield::SET_PREVIOUS] = 1;
                    break;
                }
              }
              else {
                switch( ran ) {
                  //                   case CSLfield::SET_WIDTH           : 
                  //                     genSetWidth(getParent()); 
                  //                     m_used[CSLfield::SET_WIDTH] = 1;
                  //                     m_used[CSLfield::GET_WIDTH] = 1;
                  //                     break;
                  case CSLfield::GET_WIDTH           : 
                    m_used[CSLfield::GET_WIDTH] = 1;
                    break;
                    //                   case CSLfield::SET_BITRANGE        : 
                    //                     genSetBitrange(getParent()); 
                    //                     m_used[CSLfield::SET_BITRANGE] = 1;
                    //                     m_used[CSLfield::GET_BITRANGE] = 1;
                    //                     break;
                    //                   case CSLfield::GET_BITRANGE        : 
                    //                     if( m_used[CSLfield::SET_BITRANGE] )
                    //                       m_used[CSLfield::GET_BITRANGE] = 1;
                    //                     break;
                  case CSLfield::GET_UPPER           :
                    m_used[CSLfield::GET_UPPER] = 1;
                    break;
                  case CSLfield::GET_LOWER           :
                    m_used[CSLfield::GET_LOWER] = 1;
                    break;
                    //                   case CSLfield::SET_RANGE           : 
                    //                     genSetRange(getParent()); 
                    //                     m_used[CSLfield::SET_RANGE] = 1;
                    //                     m_used[CSLfield::GET_RANGE] = 1;
                    //                     break;
                    //                   case CSLfield::GET_RANGE           : 
                    //                     if( m_used[CSLfield::SET_RANGE] )
                    //                       m_used[CSLfield::GET_RANGE] = 1;
                    //                     break;
                  case CSLfield::SET_OFFSET          : 
                    genSetOffset(getParent()); 
                    m_used[CSLfield::SET_OFFSET] = 1;
                    m_used[CSLfield::GET_OFFSET] = 1;
                    break;
                  case CSLfield::GET_OFFSET          : 
                    if( m_used[CSLfield::SET_OFFSET] )
                      m_used[CSLfield::GET_OFFSET] = 1;
                    break;
                  case CSLfield::ADD_ALLOWED_RANGE   : 
                    genAllowedRange();
                    m_used[CSLfield::ADD_ALLOWED_RANGE] = 1;
                    break;
                }
              }
        }
      }
      break;
  }

  m_usedTypeDecl[ranType] = 1;

  if( m_usedTypeDecl[CSLfield::COPY_CONSTR] && !m_copyF ) { 
    //    (*m_out) << "am iesit pe FALSE " << m_usedTypeDecl[CSLfield::COPY_CONSTR] << " " << m_copyF << endl;
    return false;
  }
  else {
    //    (*m_out) << "am iesit pe TRUE " << m_usedTypeDecl[CSLfield::COPY_CONSTR] << " " << m_copyF << endl;
    return true;
  }
}

void CSLfield::print() {
  if( m_usedTypeDecl[CSLfield::COPY_CONSTR] && !m_copyF ) {}
  else {
    cslField( m_out );
    (*m_out) << getName();
  }
  int i = 0;
 //  while ( !m_usedTypeDecl[i] && i < CSLfield::CONSTR-1 ) {
//     ++i;
//   }

  for( ; i < FIELD_TYPE_DECL_SIZE-1; ++i) 
  if( m_usedTypeDecl[i] ) {
    switch( i ) {
      case CSLfield::WIDTH       :
        lParenthesis(m_out);
        (*m_out) << m_width;
        if( m_used[CSLfield::SET_ENUM] || m_used[CSLfield::SET_ENUM_ITEM] ) {
          comma(m_out);
        }
        break;
      case CSLfield::UPPER_LOWER :
        lParenthesis(m_out);
        (*m_out) << m_upper;
        comma(m_out);
        (*m_out) << m_lower;
        if( m_used[CSLfield::SET_ENUM] || m_used[CSLfield::SET_ENUM_ITEM] ) {
          comma(m_out);
        }
        break;
      case CSLfield::COPY_CONSTR    :
        if( m_copyF ) {
          lParenthesis(m_out);
          (*m_out) << m_copy;
          if( m_used[CSLfield::SET_ENUM] || m_used[CSLfield::SET_ENUM_ITEM] ) {
            comma(m_out);
          }
        }
        else {
          (*m_out) << "\n this was checked once!!! \n \n";
        }
        break;

        if ( m_used[CSLfield::SET_ENUM]) {
          (*m_out) << m_enum;
          rParenthesis(m_out);
        }
        else
          if( m_used[CSLfield::SET_ENUM_ITEM]) {
            (*m_out) << m_enumItem;
            rParenthesis(m_out);
          }   
        //           rParenthesis(m_out);
    }
    //     if( !ok )
 if( m_usedTypeDecl[CSLfield::COPY_CONSTR] && !m_copyF ) {}
 else {
    rParenthesis(m_out);
    semicolon((m_out));
 }
  }
  if ( m_usedTypeDecl[CSLfield::CONSTR] ) {
    lCbrace( (m_out) );
    CSLbaseVec ch = getChildren();
    vector<CSLbase*>::const_iterator it =  ch.begin();
    for (; it < ch.end(); it++) {
      // if ( (*it) -> getType() == CSL_INSTANCE ) {
      (*m_out) << "  ";
      (*it) -> print();
      //      }
    }
    (*m_out) << "    " << getName();
    lParenthesis((m_out));
    rParenthesis((m_out));
    lCbrace((m_out));   

    for( int i = 0; i < FIELD_USED_VECTOR_SIZE; ++i ) {
      if ( m_used[i] ) {
        switch( i ) {
          case CSLfield::SET_WIDTH          : funct1param( m_out, FIELD_FUNCTION[i], m_width); break;
          case CSLfield::SET_BITRANGE       : 
            if( m_bitrangeF )                 funct1param( m_out, FIELD_FUNCTION[i], m_bitrange); break;
          case CSLfield::SET_RANGE          : funct1param( m_out, FIELD_FUNCTION[i], m_range); break;

          case CSLfield::SET_ENUM           : 
            if( m_enumF )                     funct1param( m_out, FIELD_FUNCTION[i], m_enum); break;
          case CSLfield::SET_ENUM_ITEM      : 
            if( m_enumItemF )                 funct1param( m_out, FIELD_FUNCTION[i], m_enumItem); break;
          case CSLfield::SET_VALUE          : funct1param( m_out, FIELD_FUNCTION[i], m_value); break;
          case CSLfield::SET_FIELD_POS      : 
            if( m_posF ) {
              int it = 0;
              for(; it < m_posField.size(); ++it) {
                funct2param( m_out, FIELD_FUNCTION[i], m_posField.at(it), m_posNumExpr.at(it)); 
              }
            }
            break;
          case CSLfield::SET_NEXT           : 
            if( m_nextF ) {
              int it1 = 0;
              for(; it1 < m_nextLeft.size(); ++it1) {
                funct2param( m_out, FIELD_FUNCTION[i], m_nextLeft[it1], m_nextRight[it1] ); 
              }
            }
            break;
          case CSLfield::SET_PREVIOUS       : 
            if( m_prevF ) {
              int it2 = 0;
              for(; it2 < m_prevLeft.size(); ++it2) {
                funct2param( m_out, FIELD_FUNCTION[i], m_prevLeft[it2], m_prevRight[it2] ); 
              }
            }
            break;
//           case CSLfield::GET_WIDTH          : funct0param( m_out, FIELD_FUNCTION[i] ) ; break;
//           case CSLfield::GET_LOWER          : funct0param( m_out, FIELD_FUNCTION[i] ) ; break;
//           case CSLfield::GET_UPPER          : funct0param( m_out, FIELD_FUNCTION[i] ) ; break;
          case CSLfield::SET_OFFSET         : funct1param( m_out, FIELD_FUNCTION[i], m_offset); break;
          case CSLfield::ADD_ALLOWED_RANGE  : funct1param( m_out, FIELD_FUNCTION[i], m_allowedRange); break;
            
        } 
      } 
    }  
    (*m_out)<<"  ";
    rCbrace((m_out));
    rCbrace((m_out));
    semicolon((m_out));
  }
}

}
