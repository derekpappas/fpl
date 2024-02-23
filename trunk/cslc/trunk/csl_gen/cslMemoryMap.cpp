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

//#include "support.h"
#include "cslMemoryMap.h"

using namespace std;
namespace NSCSLinterconnect {

void CSLdesign::addMemMapPage() {
  int flag;
  string name( string("") );
  name.append( randString() );
  if (newNameIsValid( name ) == true ) {
    CSLmemMapPage* memMapPage = new CSLmemMapPage(this, name );
    flag = rand()%2;
    if ( flag ) 
      for ( int i = 0; i < MMP_INSTANCE_NO; ++i) {
        memMapPage -> addMemMapPageInstance(this);
      }
    memMapPage -> buildDecl();
    addChild( memMapPage );
  }
} 

void CSLmemMapPage::genAddAddrRange( CSLbase* design ) {
  bool ok = false;
  int flag;
  
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_MEM_MAP_PAGE ) {
      flag = rand()%2;
      if( flag && !ok
          && static_cast<CSLmemMapPage*>(*it) -> m_used[CSLmemMapPage::GET_LOWER_BOUND]
          && static_cast<CSLmemMapPage*>(*it) -> m_used[CSLmemMapPage::GET_UPPER_BOUND] ) {
        m_lowerBound.append( (*it) -> getName() );
        m_lowerBound.append(".");
        m_lowerBound.append( MMP_FUNCTION[CSLmemMapPage::GET_LOWER_BOUND]); 
        m_lowerBound.append( "()" );

        m_upperBound.append( (*it) -> getName() );
        m_upperBound.append(".");
        m_upperBound.append( MMP_FUNCTION[CSLmemMapPage::GET_UPPER_BOUND]); 
        m_upperBound.append( "()" );

        ok = true;
      }
    }
  }      
 
  if ( !ok ) {
    m_lowerBound.append( randNumExpr() );
    m_upperBound.append( randNumExpr() );
  }
}

void CSLmemMapPage::genSetAddrIncr(CSLbase* design) {
  bool ok = false;
  int flag;
  
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_MEM_MAP_PAGE ) {
      flag = rand()%2;
      if( flag && !ok
          && static_cast<CSLmemMapPage*>(*it) -> m_used[CSLmemMapPage::GET_ADDR_INCR] ) {
        m_setAddrIncr.append( (*it) -> getName() );
        m_setAddrIncr.append(".");
        m_setAddrIncr.append( MMP_FUNCTION[CSLmemMapPage::GET_ADDR_INCR]); 
        m_setAddrIncr.append( "()" );
        ok = true;
      }      
    }
  }
 
  if ( !ok ) {
    m_setAddrIncr.append( randNumExpr() );
  }
}

void CSLmemMapPage::genSetNextAddr(CSLbase* design) {
  bool ok = false;
  int flag;
  
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_MEM_MAP_PAGE ) {
      flag = rand()%2;
      if( flag && !ok
          && static_cast<CSLmemMapPage*>(*it) -> m_used[CSLmemMapPage::GET_NEXT_ADDR] ) {
        m_setNextAddr.append( (*it) -> getName() );
        m_setNextAddr.append(".");
        m_setNextAddr.append( MMP_FUNCTION[CSLmemMapPage::GET_NEXT_ADDR]); 
        m_setNextAddr.append( "()" );
        ok = true;
      }      
    }
  } 
  if ( !ok ) {
    m_setNextAddr.append( randNumExpr() );
  }
}

void CSLmemMapPage::genSetAddrRights(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ENUM ) {
      CSLbaseVec ch1 = (*it) -> getChildren();
      vector<CSLbase*>::const_iterator it1 = ch1.begin();
      for (; it1 < ch1.end(); it1++) {
        if( (*it1) -> getType() == CSL_ENUM_ITEM ) {
          flag = rand()%8;
          if( flag && !m_groupAccessF ) {
            m_groupAccess.append( (*it1) -> getName() );
            m_groupAccessF = true;
          }
        }
      }
    }
  }
  if ( m_groupAccessF ) {
    int ran;
    ran = rand()%MMP_ACCESS_RIGHTS_SIZE;
    m_accRight = MMP_ACCESS_RIGHTS[ran];
  }
}

void CSLmemMapPage::genAddResAddrRange() {
  m_resLowerBound.append( randNumExpr() );
  m_resUpperBound.append( randNumExpr() );
}

void CSLmemMapPage::genAddAddrObj(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIFO || (*it) -> getType() == CSL_REG_FILE || (*it) -> getType() == CSL_REG ) {//|| (*it) -> getType() == CSL_MEM) {
      flag = rand()%2;
      if( flag && !m_addAddrObjF ) {
        m_addObj.append( (*it) -> getName() );
        m_addAddrObjF = true;
      }
    }
  }

  if( m_addAddrObjF ) {
    m_symbol.append( string("\"") );
    m_symbol.append( randString() );
    m_symbol.append( string("\"") );

    flag = rand()%2;
    if ( !flag ) {
      m_baseAddr.append( randNumExpr() );
      m_baseAddrF = true;
    }
  }
}

void CSLmemMapPage::genAddMMP(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_MEM_MAP_PAGE ) {
      flag = rand()%2;
      if( flag && !m_memMapPageObjF ) {
        m_memMapPageObj.append( (*it) -> getName() );
        m_memMapPageObjF = true;
      }
    }
  }
}

void CSLmemMapPage::genSetDataWordWidth(CSLbase* design) {
  bool ok = false;
  int flag;
  
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_MEM_MAP_PAGE ) {
      flag = rand()%2;
      if( flag && !ok
          && static_cast<CSLmemMapPage*>(*it) -> m_used[CSLmemMapPage::GET_DATA_WORD_WIDTH] ) {
        m_dataWordWidth.append( (*it) -> getName() );
        m_dataWordWidth.append(".");
        m_dataWordWidth.append( MMP_FUNCTION[CSLmemMapPage::GET_DATA_WORD_WIDTH]); 
        m_dataWordWidth.append( "()" );
        ok = true;
      }      
    }
  } 
  if ( !ok ) {
    m_dataWordWidth.append( randNumExpr() );
  }
}

void CSLmemMapPage::genSetAlignment(CSLbase* design) {
  bool ok = false;
  int flag;
  
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_MEM_MAP_PAGE ) {
      flag = rand()%2;
      if( flag && !ok
          && static_cast<CSLmemMapPage*>(*it) -> m_used[CSLmemMapPage::GET_ALIGNMENT] ) {
        m_setAlignment.append( (*it) -> getName() );
        m_setAlignment.append(".");
        m_setAlignment.append( MMP_FUNCTION[CSLmemMapPage::GET_ALIGNMENT]); 
        m_setAlignment.append( "()" );
        ok = true;
      }      
    }
  } 
  if ( !ok ) {
    m_setAlignment.append( randNumExpr() );
  }
}

void CSLmemMapPage::genSetEndianess(CSLbase* design) {
  bool ok = false;
  int flag;
  
  //   CSLbaseVec ch = design -> getChildren();
  //   vector<CSLbase*>::const_iterator it = ch.begin();
  //   for (; it < ch.end(); it++) {
  //     if( (*it) -> getType() == CSL_MEM_MAP_PAGE && (*it) != this ) {
  //       flag = rand()%2;
  //       if( flag && !ok
  //           && static_cast<CSLmemMapPage*>(*it) -> m_used[CSLmemMapPage::GET_ENDIANESS] ) {
  //         m_endianess.append( (*it) -> getName() );
  //         m_endianess.append(".");
  //         m_endianess.append( MMP_FUNCTION[CSLmemMapPage::GET_ENDIANESS]); 
  //         m_endianess.append( "()" );
  //         ok = true;
  //       }      
  //     }
  //   } 

  CSLbaseVec ch = getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_INSTANCE && (*it) != this ) {
      flag = rand()%2;
      if( flag && !ok
          && static_cast<CSLmemMapPage*>(*it) -> m_used[CSLmemMapPage::GET_ENDIANESS] ) {
        m_endianess.append( (*it) -> getName() );
        m_endianess.append(".");
        m_endianess.append( MMP_FUNCTION[CSLmemMapPage::GET_ENDIANESS]); 
        m_endianess.append( "()" );
        ok = true;
      }      
    }
  } 

  if ( !ok ) {
    int ran = rand()%2;
    m_endianess.append( ENDIANESS_TYPE[ran] );
  }
}

void CSLmemMapPage::genSetSymbolLenght(CSLbase* design) {
  bool ok = false;
  int flag;
  
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_MEM_MAP_PAGE ) {
      flag = rand()%2;
      if( flag && !ok
          && static_cast<CSLmemMapPage*>(*it) -> m_used[CSLmemMapPage::GET_SYMB_LENGHT] ) {
        m_symbolLenght.append( (*it) -> getName() );
        m_symbolLenght.append(".");
        m_symbolLenght.append( MMP_FUNCTION[CSLmemMapPage::GET_SYMB_LENGHT]); 
        m_symbolLenght.append( "()" );
        ok = true;
      }      
    }
  } 
  if ( !ok ) {
    m_symbolLenght.append( randNumExpr() );
  }
}

bool CSLmemMapPage::buildDecl() {
  for(int i = 0; i < rand()%MMP_CMD; ++i){
    int ran = rand()%(MMP_USED_VECTOR_SIZE);    
    if( !m_used[ran] ) {
      switch( ran ) {
        case CSLmemMapPage::ADD_ADDR_RANGE      : genAddAddrRange(getParent());             break;
        case CSLmemMapPage::SET_ADDR_INCR       : genSetAddrIncr(getParent());              break;
        case CSLmemMapPage::SET_NEXT_ADDR       : genSetNextAddr(getParent());              break;
        case CSLmemMapPage::SET_ADDR_RIGHTS     : genSetAddrRights(getParent());            break;
        case CSLmemMapPage::ADD_RES_ADDR_RANGE  : genAddResAddrRange();                     break;
        case CSLmemMapPage::ADD_OBJ             : genAddAddrObj(getParent());               break;
        case CSLmemMapPage::ADD_MMP             : genAddMMP(getParent());                   break;
        case CSLmemMapPage::SET_DATA_WORD_WIDTH : genSetDataWordWidth(getParent());         break;
        case CSLmemMapPage::SET_ALIGNMENT       : genSetAlignment(getParent());             break;
        case CSLmemMapPage::SET_ENDIANESS       : genSetEndianess(getParent());             break;
        case CSLmemMapPage::SET_SYMB_LENGHT     : genSetSymbolLenght(getParent());          break;
      }
      m_used[ran] = 1;
    }
  }
} 

void CSLmemMapPage::print() {
  cslMemoryMapPage( (m_out) );
  (*m_out) << getName();
  lCbrace((m_out));

  CSLbaseVec ch = getChildren();
  vector<CSLbase*>::const_iterator it =  ch.begin();
  for (; it < ch.end(); it++) {
    if ( (*it) -> getType() == CSL_INSTANCE ) {
      (*it) -> print();
    }
  }

  (*m_out) << "    " << getName();
  lParenthesis((m_out));
  rParenthesis((m_out));
  lCbrace((m_out));   

  for( int i = 0; i < MMP_USED_VECTOR_SIZE; ++i ) {
    if ( m_used[i] ) {
      switch( i ) {
        case CSLmemMapPage::ADD_ADDR_RANGE      :  funct2param( (m_out), MMP_FUNCTION[i], m_lowerBound, m_upperBound);       break;      
        case CSLmemMapPage::SET_ADDR_INCR       :  funct1param( (m_out), MMP_FUNCTION[i], m_setAddrIncr);                    break;
          //        case CSLmemMapPage::GET_ADDR_INCR       :  funct0param( (m_out), MMP_FUNCTION[i]);                                   break;
        case CSLmemMapPage::SET_NEXT_ADDR       :  funct1param( (m_out), MMP_FUNCTION[i], m_setNextAddr);                    break;
          //        case CSLmemMapPage::GET_NEXT_ADDR       :  funct0param( (m_out), MMP_FUNCTION[i]);                                   break;
        case CSLmemMapPage::SET_ADDR_RIGHTS     :  funct2param( (m_out), MMP_FUNCTION[i], m_groupAccess, m_accRight);        break;
        case CSLmemMapPage::ADD_RES_ADDR_RANGE  :  funct2param( (m_out), MMP_FUNCTION[i], m_resUpperBound, m_resLowerBound); break;
        case CSLmemMapPage::ADD_OBJ             :  
          if ( m_addAddrObjF ) {
            if ( m_baseAddrF )
              funct3param( (m_out), MMP_FUNCTION[i], m_addObj, m_symbol, m_baseAddr);                                         
            else
              funct2param( (m_out), MMP_FUNCTION[i], m_addObj, m_symbol);                                                      
          }                                                                                                                  break;
        case CSLmemMapPage::ADD_MMP             :  
          if ( m_memMapPageObjF )
            funct1param( (m_out), MMP_FUNCTION[i], m_memMapPageObj);                                                         break;
          //         case CSLmemMapPage::GET_LOWER_BOUND     :  funct0param( (m_out), MMP_FUNCTION[i]);                                   break;
          //         case CSLmemMapPage::GET_UPPER_BOUND     :  funct0param( (m_out), MMP_FUNCTION[i]);                                   break;
        case CSLmemMapPage::SET_DATA_WORD_WIDTH :  funct1param( (m_out), MMP_FUNCTION[i], m_dataWordWidth);                  break;
          //        case CSLmemMapPage::GET_DATA_WORD_WIDTH :  funct0param( (m_out), MMP_FUNCTION[i]);                                   break;
        case CSLmemMapPage::SET_ALIGNMENT        :  funct1param( (m_out), MMP_FUNCTION[i], m_setAlignment);                  break;
          //        case CSLmemMapPage::GET_ALIGNMENT        :  funct0param( (m_out), MMP_FUNCTION[i]);                                   break;
        case CSLmemMapPage::SET_ENDIANESS       :  funct1param( (m_out), MMP_FUNCTION[i], m_endianess);                      break;
          //        case CSLmemMapPage::GET_ENDIANESS       :  funct0param( (m_out), MMP_FUNCTION[i]);                                   break;
        case CSLmemMapPage::SET_SYMB_LENGHT     :  funct1param( (m_out), MMP_FUNCTION[i], m_symbolLenght);                   break;
          //        case CSLmemMapPage::GET_SYMB_LENGHT     :  funct0param( (m_out), MMP_FUNCTION[i]);                                   break;

      }
    }
  }
  (*m_out)<<"  ";
  rCbrace((m_out));
  rCbrace((m_out));
  semicolon((m_out));
}


void CSLmemMapPage::addMemMapPageInstance(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_MEM_MAP_PAGE ) {
      flag = rand()%2;
      if( flag ) {
        string name(string(""));
        name.append(randString());
        if (newNameIsValid(name) == true ) {
          CSLinstance* mmpInstance = new CSLinstance(this, (*it), name);
          addChild(mmpInstance);
        }
      }

    }
  }     
}


void CSLdesign::addMemMap() {
  int flag;
  string name( string("") );
  name.append( randString() );
  if (newNameIsValid( name ) == true ) {
    CSLmemMap* memMap = new CSLmemMap(this, name );
    //    flag = rand()%2;
    flag = 1;
    if ( flag ) 
      for ( int i = 0; i < MM_INSTANCE_NO; ++i) {
        memMap -> addMemMapPageInstance(this);
      }
    memMap -> buildDecl();
    addChild( memMap );
  }
}

void CSLmemMap::genSetTopUnit(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_UNIT ) {
      flag = rand()%2;
      if( flag &&  !m_topUnitF) {
        m_topUnit.append( (*it) -> getName() );
        m_topUnitF = true;
      }
    }
  }
}

void CSLmemMap::genAddToMemMap(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIFO  || (*it) -> getType() == CSL_REG_FILE || (*it) -> getType() == CSL_REG  || (*it) -> getType() == CSL_MEMORY) {
      flag = rand()%2;
      if( flag && !m_addToMemObjF ) {
        m_addToMemObj.append( (*it) -> getName() );
        m_addToMemObjF = true;
      }
    }
  }
  if ( m_addToMemObjF ) {
    flag = rand()%2;
    if ( flag ) {
      m_addToMemAddr.append( randNumExpr() );
      m_addToMemAddrF = true;
    }
    flag = rand()%2;
    if( flag ) {

      vector<CSLbase*>::const_iterator it = ch.begin();
      for (; it < ch.end(); it++) {
        if( (*it) -> getType() == CSL_ENUM ) {
          flag = rand()%2;
          if( flag && !m_addToMemRightF ) {
            m_addToMemGroupAcc.append( (*it) -> getName() );
            int ran = rand()%MMP_ACCESS_RIGHTS_SIZE;
            m_addToMemAccRight.append( MMP_ACCESS_RIGHTS[ran] );
            m_addToMemRightF = true;
          }
        }
      }
    }
  }
}

void CSLmemMap::genSetType() {
  int ran = rand()%MM_TYPE_SIZE;
  m_mmType.append( MM_TYPE[ran] );
}

void CSLmemMap::genSetAccessRight(CSLbase* design, string name) {
  int flag;
  CSLbaseVec ch = design -> getChildren(); 
  vector<CSLbase*>::const_iterator it = ch.begin();
  bool ok = false;
  for ( ; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ENUM ) {
      flag = rand()%10;
      if( flag && !ok) {
        m_mmpName.push_back(name);
        m_enumName.push_back( (*it) -> getName() );
        m_enumNameF.push_back( true);
        ok = true;
      }
    }
  }
} 

void CSLmemMap::genSetDataWordWidth(CSLbase* design) {
  bool ok = false;
  int flag;
  
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_MEM_MAP ) {
      flag = rand()%2;
      if( flag && !ok
          && static_cast<CSLmemMap*>(*it) -> m_used[CSLmemMap::GET_DATA_WORD_WIDTH] ) {
        m_dataWordWidth.append( (*it) -> getName() );
        m_dataWordWidth.append(".");
        m_dataWordWidth.append( MM_FUNCTION[CSLmemMap::GET_DATA_WORD_WIDTH]); 
        m_dataWordWidth.append( "()" );
        ok = true;
      }      
    }
  }
 
  if ( !ok ) {
    m_dataWordWidth = randNumExpr();
  }
}
void CSLmemMap::genSetPrefix(CSLbase* design) {
  bool ok = false;
  int flag;
  
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_MEM_MAP ) {
      flag = rand()%2;
      if( flag && !ok
          && static_cast<CSLmemMap*>(*it) -> m_used[CSLmemMap::GET_PREFIX] ) {
        m_prefix.append( (*it) -> getName() );
        m_prefix.append(".");
        m_prefix.append( MM_FUNCTION[CSLmemMap::GET_PREFIX]); 
        m_prefix.append( "()" );
        ok = true;
      }      
    }
  }
 
  if ( !ok ) {
    m_prefix.append("\"");
    m_prefix.append( randString() );
    m_prefix.append("\"");
  }
}
void CSLmemMap::genSetSuffix(CSLbase* design) {
  bool ok = false;
  int flag;
  
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_MEM_MAP ) {
      flag = rand()%2;
      if( flag && !ok
          && static_cast<CSLmemMap*>(*it) -> m_used[CSLmemMap::GET_SUFFIX] ) {
        m_suffix.append( (*it) -> getName() );
        m_suffix.append(".");
        m_suffix.append( MM_FUNCTION[CSLmemMap::GET_SUFFIX]); 
        m_suffix.append( "()" );
        ok = true;
      }      
    }
  }
 
  if ( !ok ) {
    m_suffix.append("\"");
    m_suffix.append( randString() );
    m_suffix.append("\"");
  }
}

bool CSLmemMap::isValidInst(int i) {
  for ( int j =0 ; j < i; j++) {
    if ( static_cast <CSLinstance*>(getChildAt(j)) -> m_instObj -> getName() == 
         static_cast <CSLinstance*>(getChildAt(i)) -> m_instObj -> getName() ) {
      return false;
    }
  }
  return true;
}

bool CSLmemMap::buildDecl() {
  for(int i = 0; i < rand()%MM_CMD; ++i){
    //    int ran = rand()%(MM_USED_VECTOR_SIZE);
    int ran = CSLmemMap::ADD_TO_MM;
    if( !m_used[ran] ) {
      switch( ran ) {
        case CSLmemMap::SET_TOP_UNIT        : genSetTopUnit(getParent());             break;
        case CSLmemMap::ADD_TO_MM           : genAddToMemMap(getParent());            break;
        case CSLmemMap::SET_TYPE            : genSetType();                           break;
          //      case CSLmemMap::SET_ACC_RIGHT       : genSetAccessRight(getParent()); break;
        case CSLmemMap::SET_DATA_WORD_WIDTH : genSetDataWordWidth(getParent());       break;
        case CSLmemMap::SET_PREFIX          : genSetPrefix(getParent());              break;
        case CSLmemMap::SET_SUFFIX          : genSetSuffix(getParent());              break;
      }
    }
    if ( ran != CSLmemMap::GET_DATA_WORD_WIDTH &&
         ran != CSLmemMap::GET_PREFIX          &&
         ran != CSLmemMap::GET_SUFFIX )
      m_used[ran] = 1;
    else
      if ( m_used[CSLmemMap::SET_DATA_WORD_WIDTH] )
        m_used[CSLmemMap::GET_DATA_WORD_WIDTH] = 1;
      else
        if ( m_used[CSLmemMap::SET_PREFIX] )
          m_used[CSLmemMap::GET_PREFIX] = 1;
        else
          if ( m_used[CSLmemMap::SET_SUFFIX] )
            m_used[CSLmemMap::GET_SUFFIX] = 1;
  }
  CSLbaseVec ch = getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  int i = 0;
  for (; it < ch.end(); it++, i++) {
    if ( (*it) -> getType() == CSL_INSTANCE && 
         static_cast<CSLmemMapPage*>(static_cast<CSLinstance*>(*it) -> m_instObj) -> getType() == CSL_MEM_MAP_PAGE ) {
      if ( isValidInst(i)) {
        if ( static_cast<CSLmemMapPage*>(static_cast<CSLinstance*>(*it) -> m_instObj) -> m_used[CSLmemMapPage::SET_ADDR_RIGHTS] ) {
          genSetAccessRight(this -> getParent(), (static_cast<CSLinstance*>(*it) -> getInstantiatedObj()) -> getName() );
          m_used[CSLmemMap::SET_ACC_RIGHT ] = 1;
        }
      }   
    }
  }
}



void CSLmemMap::print() {
  cslMemoryMap( (m_out) );
  (*m_out) << getName();
  lCbrace((m_out));

  CSLbaseVec ch = getChildren();
  vector<CSLbase*>::const_iterator it =  ch.begin();
  for (; it < ch.end(); it++) {
    if ( (*it) -> getType() == CSL_INSTANCE ) {
      (*it) -> print();
    }
  }

  (*m_out) << "    " << getName();
  lParenthesis((m_out));
  rParenthesis((m_out));
  lCbrace((m_out));   

  for( int i = 0; i < MM_USED_VECTOR_SIZE; ++i ) {
    if ( m_used[i] ) {
      switch( i ) {
        case CSLmemMap::AUTO_GEN             : funct0param( (m_out), MM_FUNCTION[i]); break; 
        case CSLmemMap::SET_TOP_UNIT         : 
          if ( m_topUnitF )
            funct1param( (m_out), MM_FUNCTION[i], m_topUnit); break;
        case CSLmemMap::ADD_TO_MM            :
          if( m_addToMemObjF ) {// && ( m_addToMemAddrF || m_addToMemRightF ) ) {
            (*m_out) << "    " << m_addToMemObj << ".";
              (*m_out) << MM_FUNCTION[i];
              lParenthesis(m_out);

            if( m_addToMemAddrF ) {            
              (*m_out) << m_addToMemAddr ;
              if( m_addToMemRightF ) {
                comma(m_out);
                (*m_out) << m_addToMemGroupAcc ;
                comma(m_out);
                (*m_out) << m_addToMemAccRight;
              }
            }
            else
              if( m_addToMemRightF ) {
                (*m_out) << m_addToMemGroupAcc ;
                comma(m_out);
                (*m_out) << m_addToMemAccRight;
              }
              rParenthesis(m_out);
              semicolon(m_out);
          }
 
//           if ( m_addToMemObjF &&  ( m_addToMemAddrF &&  m_addToMemRightF ) ) {
//             (*m_out) << "    " << m_addToMemObj << ".";
//             if ( m_addToMemAddrF &&  m_addToMemRightF )
//               (*m_out) << MM_FUNCTION[i] << "( " << m_addToMemAddr << "," << m_addToMemAccRight << "); \n";
            //              funct2param( (m_out), MM_FUNCTION[i], m_addToMemAddr, m_addToMemAccRight); 
            //             else
            //               if ( m_addToMemAddrF )
            //                 (*m_out) << MM_FUNCTION[i] << "( " << m_addToMemAddr << "); \n";
            //             //                funct1param( (m_out), MM_FUNCTION[i], m_addToMemAddr); 
            //               else
            //                 if ( m_addToMemRightF )
            //                   (*m_out) << MM_FUNCTION[i] << "( " << m_addToMemAccRight << "); \n";
            //                funct1param( (m_out), MM_FUNCTION[i], m_addToMemAccRight); 
          break;
        case CSLmemMap::SET_TYPE             : funct1param( (m_out), MM_FUNCTION[i], m_mmType); break;
        case CSLmemMap::SET_ACC_RIGHT        : 
          for (int it1 = 0 ; it1 < m_enumNameF.size(); ++it1 ){
            if ( m_enumNameF.at( it1 ) ) {
              //            (*m_out) << "    " << m_mmpName.at( it1 ) << "."; 
              (*m_out) << MM_FUNCTION[i] << "( " << m_enumName.at( it1) << "); \n";
            }
          }     
          break;
        case CSLmemMap::SET_DATA_WORD_WIDTH  : funct1param( (m_out), MM_FUNCTION[i], m_dataWordWidth); break;
          //       case CSLmemMap::GET_DATA_WORD_WIDTH  : funct0param( (m_out), MM_FUNCTION[i]); break;
        case CSLmemMap::SET_PREFIX           : funct1param( (m_out), MM_FUNCTION[i], m_prefix); break;
          //        case CSLmemMap::GET_PREFIX           : funct0param( (m_out), MM_FUNCTION[i]); break;
        case CSLmemMap::SET_SUFFIX           : funct1param( (m_out), MM_FUNCTION[i], m_suffix); break;
          //        case CSLmemMap::GET_SUFFIX           : funct0param( (m_out), MM_FUNCTION[i]); break;
      }
    }
  }
  (*m_out)<<"  ";
  rCbrace((m_out));
  rCbrace((m_out));
  semicolon((m_out));
}


void CSLmemMap::addMemMapPageInstance(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_MEM_MAP_PAGE ) {
      //      flag = rand()%2;
      flag = 1;
      if( flag ) {
        string name(string(""));
        name.append(randString());
        if (newNameIsValid(name) == true ) {
          CSLinstance* mmpInstance = new CSLinstance(this, (*it), name);
          addChild(mmpInstance);
        }
      }

    }
  }     
}

}
