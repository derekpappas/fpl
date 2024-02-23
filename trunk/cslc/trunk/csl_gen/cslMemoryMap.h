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

#ifndef CSL_MEM_MAP_CODE_GEN_H
#define CSL_MEM_MAP_CODE_GEN_H

#include "cslInterconnectGen_TB.h"

using namespace std;
namespace NSCSLinterconnect{

const short MMP_INSTANCE_NO         = 3;
const short MM_INSTANCE_NO          = 3;
const short MMP_USED_VECTOR_SIZE    = 19;
const short MM_USED_VECTOR_SIZE     = 11;
const short MM_TYPE_SIZE            = 3;
const short MMP_ACCESS_RIGHTS_SIZE  = 4;
const short MMP_CMD                 = 100;
const short MM_CMD                  = 100;

const string ENDIANESS_TYPE[2]      = {"little_endian", "big_endian"};
const string MM_TYPE[MM_TYPE_SIZE]  = {"hierarchical", "page", "flat"};
const string MMP_ACCESS_RIGHTS[MMP_ACCESS_RIGHTS_SIZE]    = {"access_none", 
                                                             "access_read",  
                                                             "access_write", 
                                                             "access_read_write"};
const string MMP_FUNCTION[MMP_USED_VECTOR_SIZE] = {"add_address_range",
                                                   "set_address_increment",
                                                   "get_address_increment",
                                                   "set_next_address",
                                                   "get_next_address",
                                                   "set_access_rights",
                                                   "add_reserved_address_range",
                                                   "add",
                                                   "add",
                                                   "get_lower_bound",
                                                   "get_upper_bound",
                                                   "set_data_word_width",
                                                   "get_data_word_width",
                                                   "set_alignment",
                                                   "get_alignment",
                                                   "set_endianess",
                                                   "get_endianess",
                                                   "set_symbol_max_length",
                                                   "get_symbol_length"}; 

const string MM_FUNCTION[MM_USED_VECTOR_SIZE] = {"auto_gen_memory_map",
                                                 "set_top_unit",
                                                 "add_to_memory_map",
                                                 "set_type",
                                                 "set_access_rights_enum",
                                                 "set_data_word_width",
                                                 "get_data_word_width",
                                                 "set_prefix",
                                                 "get_prefix",
                                                 "set_suffix",
                                                 "get_suffix"};

class CSLmemMapPage: public CSLbase {
  public:
    string              m_inst;
    string              m_instName;
    string              m_lowerBound;
    string              m_upperBound;
    string              m_setAddrIncr;
    string              m_setNextAddr;
    string              m_groupAccess;   
    string              m_accRight;      
    string              m_resLowerBound; 
    string              m_resUpperBound; 
    string              m_addObj;   
    string              m_symbol;
    string              m_baseAddr;      
    string              m_memMapPageObj; 
    string              m_dataWordWidth; 
    string              m_setAlignment;   
    string              m_endianess;     
    string              m_symbolLenght;  

    bool                m_baseAddrF;
    bool                m_addAddrObjF;
    bool                m_memMapPageObjF;
    bool                m_groupAccessF;

    int                 m_used[MMP_USED_VECTOR_SIZE];

    enum EFlags {
      ADD_ADDR_RANGE       = 0,
      SET_ADDR_INCR        = 1,
      GET_ADDR_INCR        = 2,
      SET_NEXT_ADDR        = 3,
      GET_NEXT_ADDR        = 4,
      SET_ADDR_RIGHTS      = 5,
      ADD_RES_ADDR_RANGE   = 6,
      ADD_OBJ              = 7,
      ADD_MMP              = 8,
      GET_LOWER_BOUND      = 9,
      GET_UPPER_BOUND      = 10,
      SET_DATA_WORD_WIDTH  = 11,
      GET_DATA_WORD_WIDTH  = 12,
      SET_ALIGNMENT         = 13,
      GET_ALIGNMENT         = 14,
      SET_ENDIANESS        = 15,
      GET_ENDIANESS        = 16,
      SET_SYMB_LENGHT      = 17,
      GET_SYMB_LENGHT      = 18
    };

    CSLmemMapPage(CSLbase* parent, string name) : 
      m_inst           ( string("") ),
      m_instName       ( string("") ),
      m_lowerBound     (string("")), 
      m_upperBound     (string("")),
      m_setAddrIncr    (string("")),
      m_setNextAddr    (string("")),
      m_groupAccess    (string("")),
      m_accRight       (string("")),
      m_resLowerBound  (string("")),
      m_resUpperBound  (string("")),
      m_addObj         (string("")),
      m_baseAddr       (string("")),
      m_memMapPageObj  (string("")),
      m_dataWordWidth  (string("")),
      m_setAlignment    (string("")),
      m_endianess      (string("")),
      m_symbolLenght   (string("")),
      CSLbase(CSL_MEM_MAP_PAGE, parent, name) {
      m_groupAccessF   = false;
      m_addAddrObjF    = false;
      m_memMapPageObjF = false;
      m_baseAddrF      = false;
      for( int i = 0; i < MMP_USED_VECTOR_SIZE; ++i ) {
        m_used[i] = 0;      
      }
    }

    ~CSLmemMapPage() {}

    bool buildDecl();
    void print();

    void genAddAddrRange(CSLbase* design);
    void genSetAddrIncr(CSLbase* design);
    void genSetNextAddr(CSLbase* design);
    void genSetAddrRights(CSLbase* design);
    void genAddResAddrRange(); 
    void genAddAddrObj(CSLbase* design);
    void genAddMMP(CSLbase* design);
    void genSetDataWordWidth(CSLbase* design);
    void genSetAlignment(CSLbase* design);
    void genSetEndianess(CSLbase* design); 
    void genSetSymbolLenght(CSLbase* design);
    void addMemMapPageInstance(CSLbase* design);
};

// class CSLmemMapPageInstance: public CSLbase {
//   public:
//     string m_mmpInstrName;

//     CSLmemMapPageInstance(string name): 
//       CSLbase(CSL_DESIGN, 0, name),
//       m_mmpInstrName (string("")) {
//       m_type = CSL_MEM_MAP_PAGE_INSTANCE;
//       m_name = name;
//     }

//     bool buildDecl(){}
//     void print(ostream&);
// };

class CSLmemMap: public CSLbase {
  public: 
    string              m_inst;
    string              m_instName;
    string              m_topUnit;     
    string              m_addToMemObj;
    string              m_addToMemAddr;    
    string              m_addToMemAccRight;
    string              m_addToMemGroupAcc;
    string              m_mmType;      
    vector<string>      m_mmpName;
    vector<string>      m_enumName;        
    string              m_dataWordWidth;   
    string              m_prefix;          
    string              m_suffix;      

    bool                m_topUnitF;      
    bool                m_addToMemObjF;   
    bool                m_addToMemAddrF; 
    bool                m_addToMemRightF;
    bool                m_mmpNameF;
    vector<bool>        m_enumNameF; 

    int                 m_used[MM_USED_VECTOR_SIZE];

    enum EFlags {
      AUTO_GEN            = 0,
      SET_TOP_UNIT        = 1,
      ADD_TO_MM           = 2,
      SET_TYPE            = 3,
      SET_ACC_RIGHT       = 4,
      SET_DATA_WORD_WIDTH = 5,
      GET_DATA_WORD_WIDTH = 6, 
      SET_PREFIX          = 7,
      GET_PREFIX          = 8,
      SET_SUFFIX          = 9,
      GET_SUFFIX          = 10
    };

    CSLmemMap(CSLbase* parent, string name): 
      m_inst              ( string("") ),
      m_instName          ( string("") ),
      m_topUnit           ( string("") ),
      m_addToMemObj       ( string("") ),
      m_addToMemAddr      ( string("") ),
      m_addToMemAccRight  ( string("") ),
      m_addToMemGroupAcc  ( string("") ),
      m_mmType            ( string("") ),
//       m_mmpName           ( string("") ),
//       m_enumName          ( string("") ),
      m_dataWordWidth     ( string("") ),
      m_prefix            ( string("") ),
      m_suffix            ( string("") ),
      CSLbase(CSL_MEM_MAP, parent, name) {
      m_topUnitF       = false;
      m_addToMemObjF   = false;   
      m_addToMemAddrF  = false; 
      m_addToMemRightF = false;
      m_mmpNameF        = false;
      //      m_enumNameF      = false;     
      for( int i = 0; i< MM_USED_VECTOR_SIZE; ++i ) {
        m_used[i] = 0;      
      }
    }

    ~CSLmemMap() {}

    bool buildDecl();
    void print();

    bool isValidInst(int i);
    void genSetTopUnit(CSLbase*);
    void genAddToMemMap(CSLbase*);
    void genSetType();
    void genSetAccessRight(CSLbase*, string);
    void genSetDataWordWidth(CSLbase*);
    void genSetPrefix(CSLbase*);
    void genSetSuffix(CSLbase*);
    void addMemMapPageInstance(CSLbase* design);
};


}

#endif
