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

#include "cslRegister.h"

using namespace std;
namespace NSCSLinterconnect {

void CSLdesign::addRegister() {
  int flag;
  string name( string("") );
  name.append( randString() );
  if (newNameIsValid( name ) == true ) {
    CSLregister* reg = new CSLregister( this, name );
    reg -> buildDecl();
    flag = rand()%2;
//     if ( flag ) 
//       for ( int i = 0; i < R_INSTANCE_NO; ++i) {
//         reg -> addRegisterInstance(this);
//       }
    addChild( reg );
  }
} 

void CSLunit::addRegFileInst() {
  CSLbaseVec ch = getParent()->getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_REG_FILE ) {
      string name(string(""));
      name.append(randString());
      if (newNameIsValid(name) == true ) {
        CSLinstance* regFileInstance = new CSLinstance(this, (*it), name);
        addChild(regFileInstance);
      }
    }
  }
}   

void CSLregister::genRange() {
  //    m_range.append("(");
    m_range.append( randNumExpr() );
    m_range.append(",");
    m_range.append( randNumExpr() );
    //    m_range.append(")");
}

void CSLregister::genSetRange() {
  int flag = rand()%2;
  if ( flag ) {
    genRange();
  }
  else 
    {
      m_range.append("{");
      for ( int i = 0; i < rand()%10+1; ++i ) {
        m_range.append("(");
        genRange();
        m_range.append(")");
        m_range.append(", ");
      }
        m_range.append("(");
        genRange();
        m_range.append(")");
        m_range.append("}");
    }
} 

void CSLregister::genSetType() {
  int ran = rand()%R_TYPE_SIZE;
  m_regType.append( R_TYPE[ran] );
}
                
void CSLregister::genSetWidth() {
  m_width.append( randNumExpr() );
}            

void CSLregister::genSetAddress(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_MEM_MAP ) {
      flag = rand()%2;
      if( flag ) {
        m_mpSetAddr.append( (*it) -> getName() );
        m_mpSetAddrF = true;
      }
    }
  }
  if ( m_mpSetAddrF ) {
    flag = rand()%2;
    if ( flag ) {
      m_setAddr.append(randNumExpr());
      m_setAddrF = true;
    }
  }
}
            
void CSLregister::genIndexDataPair(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_MEM_MAP ) {
      flag = rand()%2;
      if( flag ) {
        m_mpIndexDataRange.append( (*it) -> getName() );
        m_mpIndexDataRangeF = true;
      }
    }
  }
  if ( m_mpIndexDataRangeF ) {
    flag = rand()%2;
    if ( flag ) {
      m_indexDataRange.append(randNumExpr());
      m_indexDataRangeF = true;
    }
  }
}
         
void CSLregister::genSetAtribute() {
  int ran = rand()%R_ATRIBUT_SIZE;
  m_attr.append( R_ATRIBUT[ran] );
}           

void CSLregister::genConstant() {
  m_const.append( randNumExpr() );
}
              
void CSLregister::genSeAtributes( CSLbase* design ) {
  int flag;
  m_attrObj = string("");
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_REG ) {
      flag = rand()%10;
      if( flag && !m_attrObjF ) {
        m_attrObj.append( (*it) -> getName() );
        m_attrObjF = true;

        if ( static_cast<CSLregister*>(*it) -> m_used[CSLregister::SET_ATRIBUTES] 
             && (*it) -> getName() != m_attrObj ) {
          m_attrList.append( (*it) -> getName() );
          m_attrList.append(".");
          m_attrList.append( R_FUNCTION[CSLregister::GET_ATRIBUTES] );
          m_attrList.append("()");
        }
        else {
          m_attrList.append("csl_list (");
        for ( int i = 0; i < rand()%R_ATRIBUT_SIZE; ++i ) {
          m_attrList.append(R_ATRIBUT[rand()%R_ATRIBUT_SIZE]);
          m_attrList.append(",");
        }
        m_attrList.append(R_ATRIBUT[rand()%R_ATRIBUT_SIZE]);
        m_attrList.append(" )");
      }
      }
    }
  }
}
           
void CSLregister::genAddLogicConnectInput(CSLbase* design) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_REG ) {
      flag = rand()%2;
      if( flag && !ok &&
          static_cast<CSLregister*>(*it) -> m_used[CSLregister::GET_INPUT_FILE]) {
        m_conInputField.append( (*it) -> getName() );
        m_conInputField.append(".");
        m_conInputField.append( R_FUNCTION[CSLregister::GET_INPUT_FILE]); 
        m_conInputField.append( "()" );
        ok = true;
        m_conInputFieldF = true;
      }      
    }
  }
  if ( !ok ) {
   it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      flag = rand()%2;
      if( flag && !m_conInputFieldF ) {
        m_conInputField.append( (*it) -> getName() );
        m_conInputFieldF = true;
      }
    }
  }
  }
}
  
void CSLregister::genAddLogicConnectOutput( CSLbase* design ) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_REG ) {
      flag = rand()%2;
      if( flag && !ok &&
          static_cast<CSLregister*>(*it) -> m_used[CSLregister::GET_OUTPUT_FILE]) {
        m_conOutputField.append( (*it) -> getName() );
        m_conOutputField.append(".");
        m_conOutputField.append( R_FUNCTION[CSLregister::GET_OUTPUT_FILE]); 
        m_conOutputField.append( "()" );
        ok = true;
        m_conOutputFieldF = true;
      }      
    }
  }
  if ( !ok ) {
    it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      flag = rand()%2;
      if( flag && !m_conOutputFieldF ) {
        m_conOutputField.append( (*it) -> getName() );
        m_conOutputFieldF = true;
      }
    }
  }
  }
} 
void CSLregister::genInitValue() {
  m_initVal.append( randNumExpr() );
}             

void CSLregister::genSetValue() {
  m_setVal.append( randNumExpr() );
}
              
void CSLregister::genResetValue() {
  m_resetVal.append( randNumExpr() );
}
            
void CSLregister::genClearValue() {
  m_clearVal.append( randNumExpr() );
}            

void CSLregister::genSetLockEnableBit(CSLbase* design) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_REG ) {
      flag = rand()%2;
      if( flag && !ok &&
          static_cast<CSLregister*>(*it) -> m_used[CSLregister::GET_LOCK_ENABLE_BIT]) {
        m_lockEnBit.append( (*it) -> getName() );
        m_lockEnBit.append(".");
        m_lockEnBit.append( R_FUNCTION[CSLregister::GET_LOCK_ENABLE_BIT]); 
        m_lockEnBit.append( "()" );
        ok = true;
      }      
    }
  }
  if ( !ok ) {
    m_lockEnBit.append( randNumExpr() );
  }
}
      
void CSLregister::genSetCountAmount() {
  m_countAmount.append( randNumExpr() );
}        

void CSLregister::genSetCountDirection() {
  m_countDir.append( R_COUNT_DIR[rand()%2] );
}     

void CSLregister::genSetEndValue() {
  m_endVal.append( randNumExpr() );
}           

void CSLregister::genSetStartValue() {
  m_startVal.append( randNumExpr() );
}
         
void CSLregister::genStopEndValue() {
  m_startVal.append( randNumExpr() ); 
}          

void CSLregister::genAddLogicCntDirSgn(CSLbase* design) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_REG ) {
      flag = rand()%2;
      if( flag && !ok &&
          static_cast<CSLregister*>(*it) -> m_used[CSLregister::CNT_DIR_SGN]) {
        m_cntDirSgn.append( (*it) -> getName() );
        m_cntDirSgn.append(".");
        m_cntDirSgn.append( R_FUNCTION[CSLregister::CNT_DIR_SGN]); 
        m_cntDirSgn.append( "();\n" );
        m_cntDirSgnF = true;
        ok = true;
      }      
    }
  }

  if( !ok ) {
    m_cntDirSgn.append( R_ADD_LOGIC_FCT[8] );
  }
}

bool CSLregister::buildDecl(){
  for(int i = 0; i < rand()%REG_CMD; ++i){
     int ran = rand()%(R_USED_VECTOR_SIZE);
    //int    ran =  CSLregister::SET_TYPE ;
    if( !m_used[ran] ) {
      switch( ran ) {
        case CSLregister::SET_RANGE             : genSetRange();                      break;
        case CSLregister::SET_TYPE              : genSetType();                        break;
        case CSLregister::SET_WIDTH             : genSetWidth();                      break;
        case CSLregister::SET_ADDRESS           : genSetAddress(getParent());            break;
        case CSLregister::INDEX_DATA_PAIR       : genIndexDataPair(getParent());         break;
        case CSLregister::SET_ATRIBUTE          : genSetAtribute();                   break;
        case CSLregister::CONSTANT              : genConstant();                      break;
        case CSLregister::SET_ATRIBUTES         : genSeAtributes(getParent());           break;
        case CSLregister::CONNECT_INPUT         : genAddLogicConnectInput(getParent());  break;
        case CSLregister::CONNECT_OUTPUT        : genAddLogicConnectOutput(getParent()); break;
        case CSLregister::INIT_VALUE            : genInitValue();                     break;
        case CSLregister::SET_VALUE             : genSetValue();                      break;
        case CSLregister::RESET_VALUE           : genResetValue();                    break;
        case CSLregister::CLEAR_VALUE           : genClearValue();                    break;
        case CSLregister::SET_LOCK_ENABLE_BIT   : genSetLockEnableBit(getParent());              break;
        case CSLregister::SET_COUNT_AMOUNT      : genSetCountAmount();                break;
        case CSLregister::SET_COUNT_DIRECTION   : genSetCountDirection();             break;
        case CSLregister::SET_END_VALUE         : genSetEndValue();                   break;
        case CSLregister::SET_START_VALUE       : genSetStartValue();                 break;
        case CSLregister::STOP_AT_END_VALUE     : genStopEndValue();                  break; 
        case CSLregister::GET_CNT_DIR_SIGNAL    : genAddLogicCntDirSgn(getParent());  break;
      }
      if ( ran != CSLregister::GET_ATRIBUTES      && 
           ran != CSLregister::GET_INPUT_FILE     &&
           ran != CSLregister::GET_OUTPUT_FILE    &&
           ran != CSLregister::GET_LOCK_ENABLE_BIT &&
           ran != CSLregister::GET_CNT_DIR_SIGNAL )
      m_used[ran] = 1;
      else 
        if ( m_used[CSLregister::SET_ATRIBUTES] )
          m_used[CSLregister::GET_ATRIBUTES] = 1;
        else
          if ( m_used[CSLregister::CONNECT_INPUT] )
            m_used[CSLregister::GET_INPUT_FILE] = 1;
          else 
            if ( m_used[CSLregister::CONNECT_OUTPUT] )
              m_used[CSLregister::GET_OUTPUT_FILE] = 1;
            else
              if (  m_used[CSLregister::SET_LOCK_ENABLE_BIT] )
                m_used[CSLregister::GET_LOCK_ENABLE_BIT] = 1;
              else
                if ( m_used[CSLregister::SET_COUNT_DIRECTION] )
                  m_used[CSLregister::GET_CNT_DIR_SIGNAL] = 1;
    }
  }
}


void CSLregister::print() {
  cslRegister( (m_out) );
  (*m_out) << getName(); 
  lCbrace( (m_out) );

  (*m_out) << "    " << getName();
  lParenthesis((m_out));
  rParenthesis((m_out));
  lCbrace((m_out));   

  for( int i = 0; i < R_USED_VECTOR_SIZE; ++i ) {
    if ( m_used[i] ) {
      switch( i ) {
        case CSLregister::SET_RANGE             : funct1param( (m_out), R_FUNCTION[i], m_range); break;
        case CSLregister::SET_TYPE              : funct1param( (m_out), R_FUNCTION[i], m_regType); break;
        case CSLregister::SET_WIDTH             : funct1param( (m_out), R_FUNCTION[i], m_width); break;
        case CSLregister::SET_ADDRESS           : 
          if ( m_mpSetAddrF ) {
            if ( m_setAddrF ) funct2param( (m_out), R_FUNCTION[i], m_mpSetAddr, m_setAddr); 
            else              funct2param( (m_out), R_FUNCTION[i], m_mpSetAddr, m_setAddr);  }    break;
        case CSLregister::INDEX_DATA_PAIR       : 
          if ( m_mpIndexDataRangeF ) {
            if ( m_indexDataRangeF ) funct2param( (m_out), R_FUNCTION[i], m_mpIndexDataRange, m_indexDataRange); 
            else                     funct1param( (m_out), R_FUNCTION[i], m_mpIndexDataRange); }   break;
        case CSLregister::SET_ATRIBUTE          : funct1param( (m_out), R_FUNCTION[i], m_attr); break;
        case CSLregister::CONSTANT              : funct1param( (m_out), R_FUNCTION[i], m_const); break;
        case CSLregister::SET_ATRIBUTES         : 
          if ( m_attrObjF ) { (*m_out) << m_attrObj << "." << R_FUNCTION[i] << "( " << m_attrList << ");\n"; }    break;
          //  funct0param( (m_out), R_FUNCTION[i]); }  break;
          //        case CSLregister::GET_ATRIBUTES         : funct0param( (m_out), R_FUNCTION[i]); break;
        case CSLregister::NEG_OUTPUT            : funct1param( (m_out), R_FUNCTION[i], R_ADD_LOGIC_FCT[0]); break;
        case CSLregister::SERIAL_INPUT          : funct1param( (m_out), R_FUNCTION[i], R_ADD_LOGIC_FCT[1]); break;
        case CSLregister::SERIAL_OUTPUT         : funct1param( (m_out), R_FUNCTION[i], R_ADD_LOGIC_FCT[2]); break;
        case CSLregister::RD_EN                 : funct1param( (m_out), R_FUNCTION[i], R_ADD_LOGIC_FCT[3]); break;
        case CSLregister::WR_EN                 : funct1param( (m_out), R_FUNCTION[i], R_ADD_LOGIC_FCT[4]); break;
        case CSLregister::CONNECT_INPUT         : 
          if ( m_conInputFieldF )                 funct2param( (m_out), R_FUNCTION[i], R_ADD_LOGIC_FCT[5], m_conInputField); break;
//         case CSLregister::GET_INPUT_FILE        : 
//           if ( m_conInputFieldF )                 funct0param( (m_out), R_FUNCTION[i]); break;
        case CSLregister::CONNECT_OUTPUT        : 
          if ( m_conOutputFieldF )                 funct2param( (m_out), R_FUNCTION[i], R_ADD_LOGIC_FCT[6], m_conOutputField); break;
//         case CSLregister::GET_OUTPUT_FILE       : 
//           if ( m_conOutputFieldF )                 funct0param( (m_out), R_FUNCTION[i]); break;
        case CSLregister::INIT_VALUE            : funct1param( (m_out), R_FUNCTION[i], m_initVal); break;
        case CSLregister::SET_VALUE             : funct1param( (m_out), R_FUNCTION[i], m_setVal); break;
        case CSLregister::RESET_VALUE           : funct1param( (m_out), R_FUNCTION[i], m_resetVal); break;
        case CSLregister::CLEAR_VALUE           : funct1param( (m_out), R_FUNCTION[i], m_clearVal); break;
        case CSLregister::SET_LOCK_ENABLE_BIT   : funct1param( (m_out), R_FUNCTION[i], m_lockEnBit); break;
          //        case CSLregister::GET_LOCK_ENABLE_BIT   : funct0param( (m_out), R_FUNCTION[i]); break;
        case CSLregister::GRAY_OUTPUT           : funct1param( (m_out), R_FUNCTION[i], R_ADD_LOGIC_FCT[7]); break;
        case CSLregister::SET_COUNT_AMOUNT      : funct1param( (m_out), R_FUNCTION[i], m_countAmount); break;
        case CSLregister::SET_COUNT_DIRECTION   : funct1param( (m_out), R_FUNCTION[i], m_countDir); break;
        case CSLregister::SET_END_VALUE         : funct1param( (m_out), R_FUNCTION[i], m_endVal); break;
        case CSLregister::SET_START_VALUE       : funct1param( (m_out), R_FUNCTION[i], m_startVal); break;
        case CSLregister::STOP_AT_END_VALUE     : funct0param( (m_out), R_FUNCTION[i]); break;
        case CSLregister::CNT_DIR_SGN           : 
          if( m_cntDirSgnF ) funct1param( (m_out), R_FUNCTION[i], m_cntDirSgn); break;
//         case CSLregister::GET_CNT_DIR_SIGNAL    : 
//           if ( m_cntDirSgnF )                     (*m_out) << m_cntDirSgn;                                  break;
        case CSLregister::INC_SGN               : funct1param( (m_out), R_FUNCTION[i], R_ADD_LOGIC_FCT[9]); break;
        case CSLregister::DEC_SGN               : funct1param( (m_out), R_FUNCTION[i], R_ADD_LOGIC_FCT[10]); break;

      }
    }
  }
  (*m_out)<<"  ";
  rCbrace((m_out));
  rCbrace((m_out));
  semicolon((m_out));
}


void CSLdesign::addRegisterFile() {
  int flag;
  string name( string("") );
  name.append( randString() );
  if (newNameIsValid( name ) == true ) {
    CSLregisterFile* regFile = new CSLregisterFile(this, name );
    regFile -> buildDecl();
//     flag = rand()%2;
//      if ( flag ) 
//        for ( int i = 0; i < R_INSTANCE_NO; ++i) {
//          reg -> addRegisterInstance(this);
//        }
    addChild( regFile );
  }
} 

void CSLregisterFile::genSetWidth( CSLbase* design ) {
  bool ok = false;
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_REG_FILE ) {
      flag = rand()%2;
      if( flag && !ok &&
          static_cast<CSLregisterFile*>(*it) -> m_used[CSLregisterFile::GET_WIDTH]) {
        m_width.append( (*it) -> getName() );
        m_width.append(".");
        m_width.append( RF_FUNCTION[CSLregisterFile::GET_WIDTH]); 
        m_width.append( "()" );
        ok = true;
      }      
    }
  }
  if ( !ok )
    m_width.append( randNumExpr() );
}

void CSLregisterFile::genSetDepth(CSLbase* design ) {
  bool ok = false;
  int flag;
  
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_REG_FILE ) {
      flag = rand()%2;
      if( flag && !ok &&
          static_cast<CSLregisterFile*>(*it) -> m_used[CSLregisterFile::GET_DEPTH]) {
        m_depth.append( (*it) -> getName() );
        m_depth.append(".");
        m_depth.append( RF_FUNCTION[CSLregisterFile::GET_DEPTH]); 
        m_depth.append( "()" );
        ok = true;
      }      
    }
  }
  if ( !ok )
    m_depth.append( randNumExpr() );
}

void CSLregisterFile::genSetConstValue() {
  m_constVal.append( randNumExpr() );
}

void CSLregisterFile::genSetField(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren(); 
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      flag = rand()%2;
      if( flag && !m_fieldNameF) {
        m_fieldName.append( (*it) -> getName() );
        m_fieldNameF = true;
      }
    }
  }
  if ( m_fieldNameF ) { 
    m_fieldNumExpr.append( randNumExpr() );
  }
}

void CSLregisterFile::genSetExternal(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_PORT ) {
      flag = rand()%2;
      if( flag && !m_extPortF) {
        m_extPort.append( (*it) -> getName() );
        m_extPortF = true;
      }
    }
  }
  if ( m_extPortF ) { 
    m_extNumExpr.append( randNumExpr() );
  }
}

void CSLregisterFile::genSetPrefix(CSLbase* design) {
  int ran;
  string prefix = randString();
  if ( newNameIsValid( prefix ) ) {
    m_prefix.append("\"");
    m_prefix.append( randString() );
    m_prefix.append("\"");
    ran = rand()%2;
    m_ioput.append(RF_IOPUT[ran]);
    ran = rand()%2;
    if ( ran ) {
      m_prefixAll.append( "all" );
      m_prefixAllF = true;
    }
    else {
      int flag;
  CSLbaseVec ch = design -> getChildren();
      vector<CSLbase*>::const_iterator it = ch.begin();
      for (; it < ch.end(); it++) {
        if( (*it) -> getType() == CSL_REG ) {
  CSLbaseVec ch1 = (*it) -> getChildren();
          vector<CSLbase*>::const_iterator it1 = ch1.begin();
          for (; it1 < ch1.end(); it1++) {
            if( (*it1) -> getType() == CSL_FIELD ) {
              flag = rand()%2;
              if( flag && !m_prefixAllF ) {
                m_prefixAll.append( (*it) -> getName() );
                m_prefixAll.append( "." );
                m_prefixAll.append( (*it1) -> getName() );
                m_prefixAllF = true;
              }
            }
          }
        }  
      }
    } 
  }
}

void CSLregisterFile::genDirReg(CSLbase* design) {
  int flag;
  bool ok = false;
    flag = rand()%2;
    if ( flag ) {
      m_regAll.append( "all" );
      m_regAllF = true;
    }
    else {
      CSLbaseVec ch = design -> getChildren();
      vector<CSLbase*>::const_iterator it = ch.begin();
      for (; it < ch.end(); it++) {
        if( (*it) -> getType() == CSL_REG ) {
          CSLbaseVec ch1 = (*it) -> getChildren();
          vector<CSLbase*>::const_iterator it1 = ch1.begin();
          for (; it1 < ch1.end(); it1++) {
            if( (*it1) -> getType() == CSL_FIELD ) {
              flag = rand()%2;
              if( flag && !m_regAllF && !ok) {
                m_regAll.append( (*it) -> getName() );
                m_regAll.append( "." );
                m_regAll.append( (*it1) -> getName() );
                m_regAllF = true;
                ok = true;
              }
            }
          }
        }
      }
    }
    ok = false;
    if( m_regAllF ) {
      string name;
      do {
        name = randString();
        if ( newNameIsValid(name)) {
          m_groupName.append( randString() );
          ok = true;
        }
      }
      while( !ok );
    }
}

void CSLregisterFile::genDirDisconnect(CSLbase* design) {
  int flag;
    flag = rand()%2;
    if ( flag ) {
      m_discAll.append( "all" );
      m_discAllF = true;
    }
    else {
      CSLbaseVec ch = design -> getChildren();
      vector<CSLbase*>::const_iterator it = ch.begin();
      for (; it < ch.end(); it++) {
        if( (*it) -> getType() == CSL_REG ) {
          CSLbaseVec ch1 = (*it) -> getChildren();
          vector<CSLbase*>::const_iterator it1 = ch1.begin();
          for (; it1 < ch1.end(); it1++) {
            if( (*it1) -> getType() == CSL_FIELD ) {
              flag = rand()%2;
              if( flag && m_discAllF ) {
                m_discAll.append( (*it1) -> getName() );
                m_discAllF = true;
              }
            }
          }
        }
      }
    }
}

void CSLregisterFile::genDirConnect(CSLbase* design) {
  int flag;
  flag = rand()%3;
  m_conIOput.append( RF_DIR_CONNECT[ flag ] );

    flag = rand()%2;
    if ( flag ) {
      m_conAll.append( "all " );
      m_conAllF = true;
    }
    else {
      CSLbaseVec ch = design -> getChildren();
      vector<CSLbase*>::const_iterator it = ch.begin();
      for (; it < ch.end(); it++) {
        if( (*it) -> getType() == CSL_REG ) {
          CSLbaseVec ch1 = (*it) -> getChildren();
          vector<CSLbase*>::const_iterator it1 = ch1.begin();
          for (; it1 < ch1.end(); it1++) {
            if( (*it1) -> getType() == CSL_FIELD ) {
              flag = rand()%2;
              if( flag && m_conAllF) {
                flag = rand()%3;
                switch( flag ) {
                  case 0: m_conAll.append( (*it) -> getName() );                                                               break;
                  case 1: m_conAll.append( "." );  m_conAll.append( (*it1) -> getName() );                                     break;
                  case 2: m_conAll.append( (*it) -> getName() ); m_conAll.append( "." );  m_conAll.append( (*it1) -> getName() ); break;
                }
              }
                m_conAllF = true;
            }
          }
        }
      }
    }
}


bool CSLregisterFile::buildDecl() {
  genSetWidth(getParent());                
  genSetDepth(getParent());
//   m_used[CSLregisterFile::SET_WIDTH ] = 1;
//   m_used[CSLregisterFile::SET_DEPTH ] = 1;

  for(int i = 0; i < rand()%REG_FILE_CMD; ++i){
    int ran = rand()%(RF_USED_VECTOR_SIZE);
    //int ran = CSLregisterFile::DIR_REG;
    if( !m_used[ran] ) {
      switch( ran ) {
//         case CSLregisterFile::SET_WIDTH        : genSetWidth();                break;
//         case CSLregisterFile::SET_DEPTH        : genSetDepth();                break;
        case CSLregisterFile::SET_CONST_VALUE  : genSetConstValue();           break;
        case CSLregisterFile::SET_FIELD        : genSetField(getParent());        break;
        case CSLregisterFile::SET_EXTERNAL     : genSetExternal(getParent());     break;
        case CSLregisterFile::SET_PREFIX       : genSetPrefix(getParent());       break;
        case CSLregisterFile::DIR_REG          : genDirReg(getParent());          break;
        case CSLregisterFile::DIR_DISC         : genDirDisconnect(getParent());   break;
        case CSLregisterFile::DIR_CON          : genDirConnect(getParent());      break;
      }

      if ( ran != CSLregisterFile::GET_WIDTH && ran != CSLregisterFile::GET_DEPTH )
        m_used[ran] = 1;
        else
          if ( m_used[CSLregisterFile::SET_WIDTH] )
            m_used[CSLregisterFile::GET_WIDTH] = 1; 
          else
            if ( m_used[CSLregisterFile::SET_DEPTH] )
              m_used[CSLregisterFile::GET_DEPTH] = 1;
    }
  }
}
void CSLregisterFile::print() {
  cslRegisterFile( (m_out) );
  (*m_out) << getName(); 
  lCbrace( (m_out) );

  (*m_out) << "    " << getName();
  lParenthesis((m_out));
  rParenthesis((m_out));
  lCbrace((m_out));   

  for( int i = 0; i < RF_USED_VECTOR_SIZE; ++i ) {
    if ( m_used[i] ) {
      switch( i ) {
        case CSLregisterFile::SET_WIDTH         : funct1param( (m_out), RF_FUNCTION[i], m_width);                                break; 
          //        case CSLregisterFile::GET_WIDTH         : funct0param( (m_out), RF_FUNCTION[i]);                                         break;
        case CSLregisterFile::SET_DEPTH         : funct1param( (m_out), RF_FUNCTION[i], m_depth);                                break;
          //        case CSLregisterFile::GET_DEPTH         : funct0param( (m_out), RF_FUNCTION[i]);                                         break;
        case CSLregisterFile::READ_VALID        : funct1param( (m_out), RF_FUNCTION[i], RF_ADD_LOGIC_FCT[0]);                    break;
        case CSLregisterFile::CREATE_RTL_MODELE : funct0param( (m_out), RF_FUNCTION[i]);                                         break;
        case CSLregisterFile::SET_CONST_VALUE   : funct1param( (m_out), RF_FUNCTION[i], m_constVal);                             break;
        case CSLregisterFile::SET_FIELD         : 
          if ( m_fieldNameF )                     funct2param( (m_out), RF_FUNCTION[i], m_fieldName, m_fieldNumExpr);            break;
        case CSLregisterFile::SET_EXTERNAL      : 
          if ( m_extPortF )                       funct2param( (m_out), RF_FUNCTION[i], m_extNumExpr, m_extPort);                break;
        case CSLregisterFile::BYPASS            : funct1param( (m_out), RF_FUNCTION[i], RF_ADD_LOGIC_FCT[1]);                    break;
        case CSLregisterFile::SET_PREFIX        : 
          if (m_prefixAllF)                       funct3param( (m_out), RF_FUNCTION[i], m_prefix, m_ioput, m_prefixAll);         break;
        case CSLregisterFile::DIR_REG           : 
          if ( m_regAllF )                        funct3param( (m_out), RF_FUNCTION[i], RF_DIRECTIVE[0], m_groupName, m_regAll); break;
        case CSLregisterFile::DIR_DISC          : 
          if ( m_discAllF)                        funct2param( (m_out), RF_FUNCTION[i], RF_DIRECTIVE[1], m_discAll);             break;
        case CSLregisterFile::DIR_CON           : 
          if ( m_conAllF )                        funct3param( (m_out), RF_FUNCTION[i], RF_DIRECTIVE[2], m_conIOput, m_conAll);  break;
      }
    }
  }
  (*m_out)<<"  ";
  rCbrace((m_out));
  rCbrace((m_out));
  semicolon((m_out));
}

}

