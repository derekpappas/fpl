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

#include "cGenIsa_ao.h"

using namespace std;
namespace NSCSLinterconnect {

void CSLdesign::addIsaInstrFormat() {
  string name(string(""));
  name.append(randString());
  if (newNameIsValid(name) == true ) {
    CSLisaInstrFormat* isaInstrFormat = new CSLisaInstrFormat(this, name);
    isaInstrFormat->buildDecl();
    addChild(isaInstrFormat);
  }
}

void CSLdesign::addIsaInstr() {
  int flag;
  CSLbaseVec ch = getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); ++it) {
    if( (*it) -> getType() == CSL_ISA_INSTR_FORMAT ) {
      flag = rand()%2;
      if( flag ) {
        string name(string(""));
        name.append(randString());
        if (newNameIsValid(name) == true ) {
          CSLisaInstr* isaInstr = new CSLisaInstr(this, name);
          isaInstr -> buildDecl();
          isaInstr -> m_inst.append((*it) -> getName());
          addChild(isaInstr);
          it = getChildren().begin();
          break;
        }
      }
    }
  }
}

void CSLisa::addIsaInstance(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_ISA_INSTR ) {
      flag = rand()%2;
      if( flag ) {
        string name(string(""));
        name.append(randString());
        if (newNameIsValid(name) == true ) {
          CSLinstance* isaInstance = new CSLinstance(this, (*it), name);
          addChild(isaInstance);
        }
      }

    }
  }     
}

void CSLdesign::addIsa() {
  int flag;
  string name(string(""));
  name.append(randString());
  if (newNameIsValid(name) == true ) {
    CSLisa* isa = new CSLisa(this, name);
    isa->buildDecl();
    flag = rand()%2;
    if ( flag ) 
      for ( int i = 0; i < ISA_INSTANCE_NO; ++i) {
        isa -> addIsaInstance(this);
      }
    addChild(isa);
  } 
}


void CSLisaInstrFormat::genSetWidth() {
  m_widthNumExpr = randNumExpr();
}

// void CSLisaInstrFormat::genFormatName() {
//   m_isaInstrFormatName = randString();
// }

void CSLisaInstrFormat::genSetFieldName(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      flag = rand()%2;
      if( flag && !m_fieldNameF ) {
        m_fieldName.append( (*it) -> getName() );
        m_fieldNameF = true;
      }
    }
  }
}

void CSLisaInstrFormat::genSetFieldNumExpr() {
  m_fieldPosNumExpr.append(randNumExpr());
}

void CSLisaInstrFormat::genSetNextFieldLeft(CSLbase* design) {
  //  m_nLeftFieldName.append(randString());
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      flag = rand()%2;
      if( flag && !m_nLeftFieldNameF ) {
        m_nLeftFieldName.append( (*it) -> getName() );
        m_nLeftFieldNameF = true;
      }
    }
  }
}

void CSLisaInstrFormat::genSetNextFieldRight(CSLbase* design) {
  //  m_nRightFieldName.append(randString());
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      flag = rand()%2;
      if( flag && !m_nRightFieldNameF ) {
        m_nRightFieldName.append( (*it) -> getName() );
        m_nRightFieldNameF = true;
      }
    }
  }
}

void CSLisaInstrFormat::genSetPreviousFieldLeft(CSLbase* design) {
  //  m_pLeftFieldName.append(randString());
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      flag = rand()%2;
      if( flag && !m_pLeftFieldNameF ) {
        m_pLeftFieldName.append( (*it) -> getName() );
        m_pLeftFieldNameF = true;
      }
    }
  }
}

void CSLisaInstrFormat::genSetPreviousFieldRight(CSLbase* design) {
  //  m_pRightFieldName.append(randString());
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      flag = rand()%2;
      if( flag && !m_pRightFieldNameF ) {
        m_pRightFieldName.append( (*it) -> getName() );
        m_pRightFieldNameF = true;
      }
    }
  }

}

void CSLisaInstrFormat::genDecoder(CSLbase* design) {
  //  m_decoderUnitName.append(randString());
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_UNIT ) {
      flag = rand()%2;
      if( flag && !m_decoderUnitNameF ) {
        m_decoderUnitName.append( (*it) -> getName() );
        m_decoderUnitNameF = true;
      }
    }
  }
}

void CSLisaInstr::genSetAsmMnemonic( CSLbase* design ) {
  m_setAsmMnemonicOption = rand()%2;
  //  m_setAsmMnemonicOption = 1;
  if( !m_setAsmMnemonicOption ) {
    m_setAsmMnemonicString.append("\"");
    m_setAsmMnemonicString.append(randString());
    m_setAsmMnemonicString.append("\"");

    bool ok = false;
    CSLbaseVec ch = design -> getChildren();
    vector<CSLbase*>::const_iterator it = ch.begin();
    for (; it < ch.end(); it++) {
      if( (*it) -> getType() == CSL_ISA_INSTR ) {
        int flag = rand()%2;
        if( flag && !ok &&
            static_cast<CSLisaInstr*>(*it) -> m_used[CSLisaInstr::SET_ASM_MNEMONIC] ) {
          m_genAsmMnemonicString.append( (*it) -> getName() );
          m_setAsmMnemonicStringF = true;
          ok = true;
        }
      }
    }


  }
  else {
    int flag;
    bool ok = false;
    CSLbaseVec ch = design -> getChildren();
    vector<CSLbase*>::const_iterator it = ch.begin();
    for (; it < ch.end(); it++) {
      if( (*it) -> getType() == CSL_FIELD ) {
        flag = rand()%2;
        if( flag && !ok ) {
          m_setAsmMnemonicField.push_back( (*it) -> getName() );
          m_setAsmMnemonicFieldF = true;
          ok = true;
        }
      }
    }
  }
}


void CSLisa::genSetDecoderName() {
  m_setDecoderName.append(string("\""));
  m_setDecoderName.append(randString());
  m_setDecoderName.append(string("\""));
}

void CSLisa::genSetDecoderPrefix() {
  m_setDecoderPrefix.append(string("\""));
  m_setDecoderPrefix.append(randString());
  m_setDecoderPrefix.append(string("\""));
}

void CSLisa::genSetDecoderSuffix() {
  m_setDecoderSuffix.append(string("\""));
  m_setDecoderSuffix.append(randString());
  m_setDecoderSuffix.append(string("\""));
}

void CSLisa::genGenerateDecoder(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_UNIT ) {
      flag = rand()%2;
      if( flag && !m_generateDecoderF ) {
        m_generateDecoder.append( (*it) -> getName() );
        m_generateDecoderF = true;
      }
    }
  }
  //   m_generateDecoder.append(randString());
}

void CSLisa::printFile() {
  m_printFileName.append(string("\"isa.txt\""));
}

bool CSLisaInstrFormat::buildDecl() {
  for(int i = 0; i < rand()%ISA_INSTR_FORMAT_CMD; ++i){
    int ran = rand()%ISA_INSTR_FORMAT_USED_VECTOR_SIZE;
    //  int ran = 1;
    if( !m_used[ran] ) {
      switch( ran ) {
        case CSLisaInstrFormat::WIDTH     :     genSetWidth();                                                                          break;
        case CSLisaInstrFormat::FIELD_POS :     genSetFieldName(getParent());         genSetFieldNumExpr();                                break;
        case CSLisaInstrFormat::NEXT_FIELD:     genSetNextFieldLeft(getParent());     genSetNextFieldRight(getParent());                      break;
        case CSLisaInstrFormat::PREVIOUS_FIELD: genSetPreviousFieldLeft(getParent()); genSetPreviousFieldRight(getParent());                  break;
        case CSLisaInstrFormat::GEN_DECODER:    genDecoder(getParent());                                                                   break;
      }
      m_used[ran] = 1;
      //  }
    }
  }
  return true;
}

bool CSLisaInstr::buildDecl() {
  for(int i = 0; i < rand()%ISA_INSTR_CMD; ++i){
    int ran = rand()%ISA_INSTR_USED_VECTOR_SIZE;
    if( ! m_used[ran] ) {
      switch( ran ) {
        case CSLisaInstr::SET_ASM_MNEMONIC : genSetAsmMnemonic(getParent());           break;
          //          case CSLisaInstr::GET_ASM_MNEMONIC :  genGetAsmMnemonic();           break;
      }
      m_used[ran] = 1;
    }
  }
}



bool CSLisa::buildDecl() {
  for(int i = 0; i < rand()%ISA_CMD; ++i){
    int ran = rand()%(ISA_USED_VECTOR_SIZE);
    if( !m_used[ran] ) {
      switch( ran ) {
        case CSLisa::DECODER_NAME   : genSetDecoderName();          break;
        case CSLisa::DECODER_PREFIX : genSetDecoderPrefix();        break;
        case CSLisa::DECODER_SUFFIX : genSetDecoderSuffix();        break;
        case CSLisa::GEN_DECODER    : genGenerateDecoder(getParent()); break;  
        case CSLisa::PRINT          : printFile();                  break;
      }
      m_used[ran] = 1;
    }
  }
}
 
void CSLisaInstrFormat::print() {
  cslIsaInstructionFormat((m_out));//     csl_isa_instruction_format
  (*m_out) << getName();//  isa_name
  lCbrace((m_out));//   

  (*m_out) << "    " << getName();
  lParenthesis((m_out));
  rParenthesis((m_out));
  lCbrace((m_out));   


  for( int i = 0; i < ISA_INSTR_FORMAT_USED_VECTOR_SIZE; ++i ) {
    if( m_used[i] ) {
      switch( i ) {
        case CSLisaInstrFormat::WIDTH          : 
          funct1param( (m_out), ISA_INSTR_FORMAT_FUNCTION[i], m_widthNumExpr);                               break;
        case CSLisaInstrFormat::FIELD_POS      : 
          if ( m_fieldNameF ) 
            funct2param( (m_out), ISA_INSTR_FORMAT_FUNCTION[i], m_fieldName,      m_fieldPosNumExpr); break;
        case CSLisaInstrFormat::NEXT_FIELD     : 
          if ( m_nLeftFieldNameF && m_nRightFieldNameF )
            funct2param( (m_out), ISA_INSTR_FORMAT_FUNCTION[i], m_nLeftFieldName, m_nRightFieldName); break;
        case CSLisaInstrFormat::PREVIOUS_FIELD : 
          if ( m_pLeftFieldNameF && m_pRightFieldNameF )
            funct2param( (m_out), ISA_INSTR_FORMAT_FUNCTION[i], m_pLeftFieldName, m_pRightFieldName); break;
        case CSLisaInstrFormat::GEN_DECODER    : 
          if ( m_decoderUnitNameF )
            funct1param( (m_out), ISA_INSTR_FORMAT_FUNCTION[i], m_decoderUnitName);                            break;
      }
    }
  }
  (*m_out)<<"  ";
  rCbrace((m_out));
  rCbrace((m_out));
  semicolon((m_out));    
}


void CSLisaInstr::print() {
  int flag;
  cslIsaInstruction((m_out));//     csl_isa_instruction_format
  (*m_out) << getName();//  isa_name
  //     if( m_instF )
  (*m_out) << " : " << m_inst;
  lCbrace((m_out));//   

  (*m_out) << "    " << getName();
  lParenthesis((m_out));
  rParenthesis((m_out));
  lCbrace((m_out));   

  if( m_used[CSLisaInstr:: SET_ASM_MNEMONIC] == true ) {
    if( m_setAsmMnemonicStringF )
      {
        (*m_out) << "    " << ISA_INSTR_FUNCTION[0] << "( " ;
        (*m_out) << m_genAsmMnemonicString; 
        rParenthesis((m_out));//      )
        semicolon((m_out));//         ;
      }
    else
      if( m_setAsmMnemonicFieldF ) {
        (*m_out) << "    " << ISA_INSTR_FUNCTION[0] << "( " ;
        (*m_out) << "csl_list ( ";
        vector<string>::const_iterator it1 = m_setAsmMnemonicField.begin();
        for(; it1 < m_setAsmMnemonicField.end()-1; ++it1) {
          //       (*m_out) << " fieldName ";
          (*m_out) << (*it1);//                        field
          //        (*m_out) << "comma ";
          // comma((*m_out));//                           ,
          (*m_out) << ", ";
        }
        (*m_out) << (*it1);
        (*m_out) << ") ";
        rParenthesis((m_out));//      )
        semicolon((m_out));//         ;

      }
      else
        if( !m_setAsmMnemonicOption )
          {
            (*m_out) << "    " << ISA_INSTR_FUNCTION[0] << "( " ;
            (*m_out) << m_setAsmMnemonicString;//"mnemonic" 
            rParenthesis((m_out));//      )
            semicolon((m_out));//         ;
          }

  }

  (*m_out)<<"  ";
  rCbrace((m_out));
  rCbrace((m_out));
  semicolon((m_out));    
}
 

void CSLisa::print() {
  int flag; 

  cslIsa((m_out));//     csl_isa
  (*m_out) << getName();//  isa_name
  lCbrace((m_out));//   

  CSLbaseVec ch = getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();
  for (; it < ch.end(); it++) {
    if ( (*it) -> getType() == CSL_INSTANCE ) {
      (*it) -> print();
    }
  }
 
  (*m_out) << "    " << getName();
  lParenthesis((m_out));
  rParenthesis((m_out));
  lCbrace((m_out));   


  for( int i = 0; i < ISA_USED_VECTOR_SIZE; ++i ) {
    if( m_used[i] ) {
      switch( i ) {
        case CSLisa::DECODER_NAME   : funct1param( (m_out), ISA_FUNCTION[i], m_setDecoderName  ); break;
        case CSLisa::DECODER_PREFIX : funct1param( (m_out), ISA_FUNCTION[i], m_setDecoderPrefix); break;
        case CSLisa::DECODER_SUFFIX : funct1param( (m_out), ISA_FUNCTION[i], m_setDecoderSuffix); break;
        case CSLisa::GEN_DECODER    : 
          if ( m_generateDecoderF )
            funct1param( (m_out), ISA_FUNCTION[i], m_generateDecoder ); break;
        case CSLisa::PRINT          : funct1param( (m_out), ISA_FUNCTION[i], m_printFileName   ); break;
      }
    }
  }
  (*m_out)<<"  ";
  rCbrace((m_out));
  rCbrace((m_out));
  semicolon((m_out));
}
}
