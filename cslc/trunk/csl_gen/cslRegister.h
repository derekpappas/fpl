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

#ifndef CSL_REGISTER_CODE_GEN_H
#define CSL_REGISTER_CODE_GEN_H

#include "cslInterconnectGen_TB.h"

using namespace std;
namespace NSCSLinterconnect{

const short R_INSTANCE_NO        = 3;
const short RF_INSTANCE_NO       = 3;
const short R_USED_VECTOR_SIZE   = 34;
const short RF_USED_VECTOR_SIZE  = 14;
const short R_TYPE_SIZE          = 10;
const short R_ATRIBUT_SIZE       = 4;
const short REG_FILE_CMD         = 100;
const short REG_CMD              = 100;

const string R_COUNT_DIR[2]      = {"up", "down"};
const string R_ATRIBUT[R_ATRIBUT_SIZE] = {"read",     
                                          "write",
                                          "shadow",
                                          "read_write"};
const string R_TYPE[R_TYPE_SIZE] = {"atom",
                                   "cnt",
                                   "ctl",
                                   "dff",
                                   "evnt",
                                   "int",
                                   "lfsr",
                                   "sema",
                                   "statistic",
                                   "status"};
const string R_FUNCTION[R_USED_VECTOR_SIZE] = {"set_range",
                                               "set_type",
                                               "set_width",
                                               "set_address",
                                               "index_data_pair",
                                               "set_attribute",
                                               "constant",
                                               "set_attributes",
                                               "get_attributes",
                                               "add_logic",
                                               "add_logic",
                                               "add_logic",
                                               "add_logic",
                                               "add_logic",
                                               "add_logic",
                                               "get_input_field",
                                               "add_logic",
                                               "get_output_field",
                                               "init_value",
                                               "set_value",
                                               "reset_value",
                                               "clear_value",
                                               "set_lock_enable_bit",
                                               "get_lock_enable_bit",
                                               "add_logic",
                                               "set_count_amount",
                                               "set_count_direction",
                                               "set_end_value",
                                               "set_start_value",
                                               "stop_at_end_value",
                                               "add_logic",
                                               "get_cnt_dir_signal",
                                               "add_logic",
                                               "add_logic"};
const string R_ADD_LOGIC_FCT[11] = {"neg_output",
                                  "serial_input",
                                  "serial_output",
                                  "rd_en",
                                  "wr_en",
                                  "connect_input_to_field",
                                  "connect_output_to_field",
                                  "gray_output",
                                  "cnt_dir_signal",
                                  "inc_signal",
                                  "dec_signal"};

const string RF_FUNCTION[RF_USED_VECTOR_SIZE] = {"set_width",
                                                 "get_width",
                                                 "set_depth",
                                                 "get_depth",
                                                 "add_logic",
                                                 "create_rtl_module",
                                                 "set_const_value",
                                                 "set_field",
                                                 "set_external",
                                                 "add_logic",
                                                 "set_prefix",
                                                 "directive",
                                                 "directive",
                                                 "directive"};
 
const string RF_ADD_LOGIC_FCT[2] = {"read_valid","bypass"};
const string RF_IOPUT[2]         = {"input", "output"};
const string RF_DIR_CONNECT [3]  = {"inputs", "outputs", "inouts"};
const string RF_DIRECTIVE[3]     = {"register_group", 
                                    "disconnect_register_fields_from_ios",
                                    "connect_register_fields_to_ios"};

class CSLregister: public CSLbase {
  public:
    string              m_inst;            
    string              m_instName;        
    string              m_range;           
    string              m_concatRanges;    
    string              m_regType;            
    string              m_width;           
    string              m_setAddr;         
    string              m_mpSetAddr;       
    string              m_mpIndexDataRange;
    string              m_indexDataRange;  
    string              m_attr;            
    string              m_const;           
    string              m_attrObj;         
    string              m_attrList;        
    string              m_conInputField;   
    string              m_conOutputField;  
    string              m_initVal;         
    string              m_setVal;          
    string              m_resetVal;        
    string              m_clearVal;        
    string              m_lockEnBit;       
    string              m_countAmount;     
    string              m_countDir;        
    string              m_endVal;          
    string              m_startVal;   
    string              m_cntDirSgn;     

    int                 m_used[R_USED_VECTOR_SIZE];

    bool                m_mpSetAddrF;       
    bool                m_setAddrF;         
    bool                m_mpIndexDataRangeF;
    bool                m_indexDataRangeF;  
    bool                m_attrObjF;         
    bool                m_conInputFieldF;   
    bool                m_conOutputFieldF;  
    bool                m_cntDirSgnF;

    enum EFlag {
      SET_RANGE             = 0 ,
      SET_TYPE              = 1 ,
      SET_WIDTH             = 2 ,
      SET_ADDRESS           = 3 ,
      INDEX_DATA_PAIR       = 4 ,
      SET_ATRIBUTE          = 5 ,
      CONSTANT              = 6 ,
      SET_ATRIBUTES         = 7 ,
      GET_ATRIBUTES         = 8 ,
      NEG_OUTPUT            = 9 ,
      SERIAL_INPUT          = 10,
      SERIAL_OUTPUT         = 11,
      RD_EN                 = 12,
      WR_EN                 = 13,
      CONNECT_INPUT         = 14,
      GET_INPUT_FILE        = 15,
      CONNECT_OUTPUT        = 16,
      GET_OUTPUT_FILE       = 17,
      INIT_VALUE            = 18,
      SET_VALUE             = 19,
      RESET_VALUE           = 20,
      CLEAR_VALUE           = 21,
      SET_LOCK_ENABLE_BIT   = 22,
      GET_LOCK_ENABLE_BIT   = 23,
      GRAY_OUTPUT           = 24,
      SET_COUNT_AMOUNT      = 25,
      SET_COUNT_DIRECTION   = 26,
      SET_END_VALUE         = 27,
      SET_START_VALUE       = 28,
      STOP_AT_END_VALUE     = 29,
      CNT_DIR_SGN           = 30,
      GET_CNT_DIR_SIGNAL    = 31,
      INC_SGN               = 32,
      DEC_SGN               = 33
    };
    
    CSLregister(CSLbase* parent, string name) : 
      m_inst            ( string ("") ),
      m_instName        ( string ("") ),
      m_range           ( string ("") ),
      m_concatRanges    ( string ("") ),
      m_regType         ( string ("") ),
      m_width           ( string ("") ),
      m_setAddr         ( string ("") ),
      m_mpSetAddr       ( string ("") ),
      m_mpIndexDataRange( string ("") ),
      m_indexDataRange  ( string ("") ),
      m_attr            ( string ("") ),
      m_const           ( string ("") ),
      m_attrObj         ( string ("") ),
      m_attrList        ( string ("") ),
      m_conInputField   ( string ("") ),
      m_conOutputField  ( string ("") ),
      m_initVal         ( string ("") ),
      m_setVal          ( string ("") ),
      m_resetVal        ( string ("") ),
      m_clearVal        ( string ("") ),
      m_lockEnBit       ( string ("") ),
      m_countAmount     ( string ("") ),
      m_countDir        ( string ("") ),
      m_endVal          ( string ("") ),
      m_startVal        ( string ("") ),
      m_cntDirSgn       ( string ("") ),
    CSLbase(CSL_REG, parent, name) {
      m_mpSetAddrF          = false;     
      m_setAddrF            = false;        
      m_mpIndexDataRangeF   = false;
      m_indexDataRangeF     = false; 
      m_attrObjF            = false;        
      m_conInputFieldF      = false;  
      m_conOutputFieldF     = false; 
      m_cntDirSgnF          = false;
      for( int i = 0; i< R_USED_VECTOR_SIZE; ++i ) {
        m_used[i] = 0;      
      }
    }

    ~CSLregister() {}
    bool buildDecl();
    void print();

    void genRange();
    void genSetRange();
    void genSetType(); 
    void genSetWidth();
    void genSetAddress(CSLbase* design);
    void genIndexDataPair(CSLbase* design);
    void genSetAtribute();
    void genConstant();
    void genSeAtributes( CSLbase* design );
    void genAddLogicConnectInput( CSLbase* design );
    void genAddLogicConnectOutput( CSLbase* design );
    void genInitValue();
    void genSetValue();
    void genResetValue();
    void genClearValue();
    void genSetLockEnableBit(CSLbase*);
    void genSetCountAmount();
    void genSetCountDirection();
    void genSetEndValue();
    void genSetStartValue();
    void genStopEndValue();
    void genAddLogicCntDirSgn(CSLbase* design);

     };


class CSLregisterFile: public CSLbase {
  public: 
    string              m_inst;        
    string              m_instName;    
    string              m_width;       
    string              m_depth;       
    string              m_constVal;    
    string              m_fieldName;   
    string              m_fieldNumExpr;
    string              m_extNumExpr;  
    string              m_extPort;     
    string              m_prefix;      
    string              m_ioput;     
    string              m_prefixAll;
    string              m_groupName;
    string              m_regAll;
    string              m_discAll;
    string              m_conAll;
    string              m_conIOput;

    int                 m_used[RF_USED_VECTOR_SIZE];

    bool                m_fieldNameF;
    bool                m_extPortF;
    bool                m_prefixAllF;
    bool                m_regAllF;
    bool                m_discAllF;
    bool                m_conAllF;

    enum EFlag {
      SET_WIDTH           = 0,
      GET_WIDTH           = 1,
      SET_DEPTH           = 2,
      GET_DEPTH           = 3,
      READ_VALID          = 4,
      CREATE_RTL_MODELE   = 5,
      SET_CONST_VALUE     = 6,
      SET_FIELD           = 7,
      SET_EXTERNAL        = 8,
      BYPASS              = 9,
      SET_PREFIX          = 10,
      DIR_REG             = 11,
      DIR_DISC            = 12,
      DIR_CON             = 13
    };

    CSLregisterFile(CSLbase* parent, string name) :
      m_inst         ( string("") ),        
      m_instName     ( string("") ),    
      m_width        ( string("") ),       
      m_depth        ( string("") ),       
      m_constVal     ( string("") ),    
      m_fieldName    ( string("") ),   
      m_fieldNumExpr ( string("") ),
      m_extNumExpr   ( string("") ),  
      m_extPort      ( string("") ),     
      m_prefix       ( string("") ),      
      m_ioput        ( string("") ),
      m_prefixAll    ( string("") ),
      m_regAll       ( string("") ),
      m_discAll      ( string("") ),
      m_conAll       ( string("") ),
      m_conIOput     ( string("") ),
      CSLbase(CSL_REG_FILE, parent, name) {
      m_fieldNameF = false;
      m_extPortF   = false;
      m_prefixAllF = false;
      m_regAllF    = false;
      m_discAllF   = false;
      m_conAllF    = false;
      for( int i = 0; i< RF_USED_VECTOR_SIZE; ++i ) {
        m_used[i] = 0;      
      }
    }

    ~CSLregisterFile() {}

    bool buildDecl();
    void print();

    void genSetWidth(CSLbase*);     
    void genSetDepth(CSLbase*);     
    void genSetConstValue();
    void genSetField(CSLbase* design);     
    void genSetExternal(CSLbase* design);  
    void genSetPrefix(CSLbase* design);    
    void genDirReg(CSLbase* design);
    void genDirDisconnect(CSLbase* design);
    void genDirConnect(CSLbase* design);

};
}
#endif
