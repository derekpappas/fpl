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

#ifndef CSL_ISA_CODE_GEN_H
#define CSL_ISA_CODE_GEN_H

#include "cslInterconnectGen_TB.h"

using namespace std;
namespace NSCSLinterconnect{

//vector<string> names;
//const short NAME_STRING_SIZE                   = 2;
const short RANDOMS_NO                         = 10;
const short ISA_VECTOR_SIZE                    = 3;
const short FIELDS_VECTOR_SIZE                 = 10;
const short ISA_INSTR_FORMAT_USED_VECTOR_SIZE  = 5;
const short ISA_INSTR_USED_VECTOR_SIZE         = 2;
const short ISA_USED_VECTOR_SIZE               = 5;
const short ISA_INSTANCE_NO                    = 25;
const short ISA_INSTR_FORMAT_CMD               = 100;
const short ISA_INSTR_CMD                      = 100;
const short ISA_CMD                            = 100;

const string ISA_INSTR_FORMAT_FUNCTION[ISA_INSTR_FORMAT_USED_VECTOR_SIZE] = {"set_width", 
                                                                             "set_position",
                                                                             "set_next",
                                                                             "set_previous",
                                                                             "gen_decoder"};
const string ISA_INSTR_FUNCTION[ISA_INSTR_USED_VECTOR_SIZE]     = {"set_asm_mnemonic",
                                                                "get_asm_mnemonic"};

const string ISA_FUNCTION[ISA_USED_VECTOR_SIZE]              = {"set_decoder_name", 
                                                                "set_decoder_out_name_prefix",
                                                                "set_decoder_out_name_suffix",
                                                                "gen_decoder",
                                                                "print"};
  

class CSLisaInstrFormat: public CSLbase {
  public:

    //  string      m_isaInstrFormatName;
    string     m_formatName;       
    string     m_widthNumExpr;    
    string     m_fieldName;       
    string     m_fieldPosNumExpr; 
    string     m_nLeftFieldName;  
    string     m_nRightFieldName; 
    string     m_pLeftFieldName;  
    string     m_pRightFieldName; 
    string     m_decoderUnitName; 
    int        m_used[ISA_INSTR_FORMAT_USED_VECTOR_SIZE];

    bool       m_fieldNameF;      
    bool       m_nLeftFieldNameF; 
    bool       m_nRightFieldNameF;
    bool       m_pLeftFieldNameF; 
    bool       m_pRightFieldNameF;
    bool       m_decoderUnitNameF;

    enum EFlags {         
      WIDTH           = 0,
      FIELD_POS       = 1,
      NEXT_FIELD      = 2,
      PREVIOUS_FIELD  = 3,
      GEN_DECODER     = 4
    };

    CSLisaInstrFormat(CSLbase* parent, string name) :
      m_formatName         (string("")),     
      m_widthNumExpr       (string("")),   
      m_fieldName          (string("")),      
      m_fieldPosNumExpr    (string("")),
      m_nLeftFieldName     (string("")), 
      m_nRightFieldName    (string("")),
      m_pLeftFieldName     (string("")), 
      m_pRightFieldName    (string("")),
      m_decoderUnitName    (string("")),
      CSLbase(CSL_ISA_INSTR_FORMAT, parent, name) {
      m_fieldNameF          = false;      
      m_nLeftFieldNameF     = false; 
      m_nRightFieldNameF    = false;
      m_pLeftFieldNameF     = false; 
      m_pRightFieldNameF    = false;
      m_decoderUnitNameF    = false;




      for( int i = 0; i< ISA_INSTR_FORMAT_USED_VECTOR_SIZE; ++i ) {
        m_used[i] = 0;      
      }
    }

    ~CSLisaInstrFormat() {}

    bool buildDecl();
    void print();

    void genSetWidth();
    void genFormatName(CSLbase* design);
    void genSetFieldName(CSLbase* design);
    void genSetFieldNumExpr();

    void genSetNextFieldLeft(CSLbase* design);
    void genSetNextFieldRight(CSLbase* design);
    void genSetPreviousFieldLeft(CSLbase* design);
    void genSetPreviousFieldRight(CSLbase* design);
    void genDecoder(CSLbase* design);
};

 class CSLisaInstr: public CSLbase {
   public: 
 
     //   string         m_isaInstrName;
     string         m_inst;                
     //     int            m_instF; 
     int            m_setAsmMnemonicOption; // 0 = string "mnemonic", 1= csl_list (list_of_fields)
     string         m_setAsmMnemonicString;
     vector<string> m_setAsmMnemonicField; 
     string         m_genAsmMnemonicString;
     int            m_used[ISA_INSTR_USED_VECTOR_SIZE];

     bool           m_setAsmMnemonicFieldF;
     bool           m_setAsmMnemonicStringF;

     enum EFlags {
       SET_ASM_MNEMONIC = 0,
       GET_ASM_MNEMONIC = 1
     };

     CSLisaInstr(CSLbase* parent, string name):
       CSLbase(CSL_ISA_INSTR, parent, name),
       m_inst                     (string("")),
       m_setAsmMnemonicOption     (0),
       m_setAsmMnemonicString     (string("")),
       m_genAsmMnemonicString     (string("")) {
       m_setAsmMnemonicFieldF   = false;
       m_setAsmMnemonicStringF  = false;
       for( int i = 0; i< ISA_INSTR_USED_VECTOR_SIZE; ++i ) {
         m_used[i] = 0;      
       }
     }

     ~CSLisaInstr() {}


      void genSetAsmMnemonic(CSLbase*);

     bool buildDecl();
     void print();
     //    void genGetAsmMnemonic();
 };

 class CSLisa: public CSLbase {
   public:
     string      m_inst;
     string      m_instName;
     string      m_setDecoderName;  
     string      m_setDecoderPrefix;
     string      m_setDecoderSuffix;
     string      m_generateDecoder; 
     string      m_printFileName;   

     int         m_used[ISA_USED_VECTOR_SIZE];

     bool        m_generateDecoderF;

     enum EFlags {
       DECODER_NAME   = 0,
       DECODER_PREFIX = 1,
       DECODER_SUFFIX = 2,
       GEN_DECODER    = 3,
       PRINT          = 4
     };

     CSLisa(CSLbase* parent, string name) :
       CSLbase(CSL_ISA, parent, name),
       m_inst             (string("")),
       m_instName         (string("")),
       m_setDecoderName   (string("")),
       m_setDecoderPrefix (string("")),
       m_setDecoderSuffix (string("")),
       m_generateDecoder  (string("")), 
       m_printFileName    (string("")) { 
       m_generateDecoderF = false;
       for( int i = 0; i< ISA_USED_VECTOR_SIZE; ++i ) {
         m_used[i] = 0;      
       }
     }

    ~CSLisa() {}

     void genSetDecoderName();
     void genSetDecoderPrefix();
     void genSetDecoderSuffix();
     void genGenerateDecoder(CSLbase*);
     void printFile();
     void addIsaInstance(CSLbase* design);
  
     bool buildDecl();
     void print();
 };

// class CSLisaInstance: public CSLbase {
//   public:
//     string m_isaInstrName;

//     CSLisaInstance(string name): 
//       CSLbase(CSL_ISA_INSTANCE, 0, name),
//       m_isaInstrName (string("")) {
//       m_type = CSL_ISA_INSTANCE;
//       m_name = name;
//     }

//     bool buildDecl(){}
//     void print(ostream&);
// };

}
#endif //CSL_ISA_CODE_GEN_H
