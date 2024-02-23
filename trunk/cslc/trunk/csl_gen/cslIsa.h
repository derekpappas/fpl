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

const short RANDOMS_NO                         = 10;
//const short FIELDS_VECTOR_SIZE                 = 10;
const short ISA_FIELD_TYPE_DECL_SIZE           = 4;
const short ISA_FIELD_USED_VECTOR_SIZE         = 24;
const short ISA_FIELD_CMD                      = 100;
const short ISA_FIELD_TYPE_NO                  = 5;
const short ISA_FIELD_INSTANCE_NO              = 2;
const short ISA_FIELDS_NO                      = 2;

//const short ISA_ELEMENT_TYPE_DECL_SIZE           = 4;
const short ISA_ELEMENT_USED_VECTOR_SIZE         = 24;
const short ISA_ELEMENT_CMD                      = 100;
const short ISA_ELEMENT_TYPE_NO                  = 3;
const short ISA_ELEMENT_INSTANCE_NO              = 2;
const short ISA_ELEMENTS_NO                      = 2;


const string ISA_FIELD_FUNCTION[ISA_FIELD_USED_VECTOR_SIZE] = {"set_type",
                                                          "get_type",      
                                                          "set_width",       
                                                          "set_range",       
                                                          "set_bitrange",    
                                                          "set_enum",        
                                                          "get_enum",        
                                                          "set_enum_item",   
                                                          "get_enum_item",   
                                                          "set_value",       
                                                          "get_value",       
                                                          "set_position",    
                                                          "set_next",        
                                                          "set_previous",    
                                                          "get_width",       
                                                          "get_upper",       
                                                          "get_lower",       
                                                          "set_offset",      
                                                          "get_offset",      
                                                          "add_allowed_range",
                                                          "set_name",   
                                                          "get_name",   
                                                          "set_mnemonic",
                                                          "get_mnemonic"};

const string ISA_FIELD_TYPE[ISA_FIELD_TYPE_NO] = {"opcode",
                                                  "subopcode",
                                                  "address",
                                                  "selector", 
                                                  "constant"};

const string ISA_ELEMENT_FUNCTION[ISA_ELEMENT_USED_VECTOR_SIZE] = {"set_type",
                                                                   "get_type", 
                                                                   "set_width",
                                                                   "get_width",
                                                                   "set_position",    
                                                                   "set_next",        
                                                                   "set_previous"};

const string ISA_ELEMENT_TYPE[ISA_ELEMENT_TYPE_NO] = {"root_format",
                                                      "instr_format",
                                                      "instr"};

class CSLisaField: public CSLbase {
  public:
    string              m_typeDecl;
    string              m_enum;        
    string              m_enumItem;    
    string              m_value;       
    string              m_width;       
    string              m_bitrange;    
    string              m_range;       
    string              m_offset;      
    //     string              m_listBitrange;
    string              m_upper;
    string              m_lower;
    vector<string>      m_posField;  
    vector<string>      m_posNumExpr;
    vector<string>      m_nextLeft;  
    vector<string>      m_nextRight; 
    vector<string>      m_prevLeft;  
    vector<string>      m_prevRight; 
    string              m_allowedRange;
    string              m_copy;

    string              m_setName;    
    string              m_setType;    
    string              m_setMnemonic;

    int                 m_used[ISA_FIELD_USED_VECTOR_SIZE];
    int                 m_usedTypeDecl[ISA_FIELD_TYPE_DECL_SIZE];

    bool                m_copyF;
    bool                m_bitrangeF;
    bool                m_enumF;
    bool                m_enumItemF;
    bool                m_fieldTypeF;
    bool                m_elementTypeF;
    bool                m_printF;
    bool                m_posF;
    bool                m_nextF;
    bool                m_prevF;
    bool                m_hierarchicalF;


    enum EFlag {
      SET_TYPE             = 0,
      GET_TYPE             = 1,
      SET_WIDTH            = 2,
      SET_RANGE            = 3,
      SET_BITRANGE         = 4,
      SET_ENUM             = 5,      
      GET_ENUM             = 6,      
      SET_ENUM_ITEM        = 7,
      GET_ENUM_ITEM        = 8,
      SET_VALUE            = 9,
      GET_VALUE            = 10,
      SET_FIELD_POS        = 11,
      SET_NEXT             = 12,
      SET_PREVIOUS         = 13,
      GET_WIDTH            = 14,
      GET_UPPER            = 15,
      GET_LOWER            = 16,
      SET_OFFSET           = 17,
      GET_OFFSET           = 18,
      ADD_ALLOWED_RANGE    = 19,
      SET_NAME             = 20,
      GET_NAME             = 21,
      SET_MNEMONIC         = 22,
      GET_MNEMONIC         = 23      
    };

    enum EFieldTypeDecl {
      WIDTH                = 0,
      UPPER_LOWER          = 1,
      COPY_CONSTR          = 2,
      CONSTR               = 3
    };


    CSLisaField(CSLbase* parent, string name) : 
      m_typeDecl       ( string ("") ),   
      m_enum           ( string ("") ),
      m_enumItem       ( string ("") ),
      m_value          ( string ("") ),
      m_width          ( string ("") ),
      m_bitrange       ( string ("") ),
      m_range          ( string ("") ),
      m_offset         ( string ("") ),
      m_allowedRange   ( string ("") ),
      m_setName        ( string ("") ),    
      m_setType        ( string ("") ),    
      m_setMnemonic    ( string ("") ),
      CSLbase(CSL_ISA_FIELD, parent, name) {
      m_enumF         = false;
      m_enumItemF     = false;
      m_fieldTypeF    = false;
      m_elementTypeF  = false;
      m_printF        = false;
      m_posF          = false;
      m_nextF         = false;
      m_prevF         = false;
      m_bitrangeF     = false;
      m_copyF         = false;
      m_hierarchicalF = false;
      for( int i = 0; i< ISA_FIELD_USED_VECTOR_SIZE; ++i ) {
        m_used[i] = 0;      
      }

      for( int i = 0; i< ISA_FIELD_TYPE_DECL_SIZE; ++i ) {
        m_usedTypeDecl[i] = 0;      
      }
    }

    ~CSLisaField() {}
    bool buildDecl();
    void print();
      
    void addFieldInstance( CSLbase* );

    void genEnum();
    void genUpperLower();
    void genCopyConstr(CSLbase* );
    //   void genBitrange();

    void genSetWidth( CSLbase* );
    void genSetBitrange( CSLbase* );
    void genSetRange( CSLbase* );
    void genSetOffset( CSLbase* );

    void genSetEnum( CSLbase* );
    void genSetEnumItem( CSLbase* );
    void genSetValue( CSLbase* );

    void genSetPosition();
    void genSetNext();
    void genSetPrevious();

    void genAllowedRange();

    void genSetType( CSLbase* );
    void genSetName( CSLbase* );
    void genSetMnemonic( CSLbase* );
};

class CSLisaElement: public CSLbase {
  public:
    string              m_deriv;                
    string              m_setType; 
    string              m_width;
    vector<string>      m_posField;  
    vector<string>      m_posNumExpr;
    vector<string>      m_nextLeft;  
    vector<string>      m_nextRight; 
    vector<string>      m_prevLeft;  
    vector<string>      m_prevRight; 

    int                 m_used[ISA_ELEMENT_USED_VECTOR_SIZE];

    bool                m_derivF;
    bool                m_posF;
    bool                m_nextF;
    bool                m_prevF;


    enum EFlags {
      SET_TYPE             = 0,
      GET_TYPE             = 1,     
      SET_WIDTH            = 2,
      GET_WIDTH            = 3,
      SET_FIELD_POS        = 4,
      SET_NEXT             = 5,
      SET_PREVIOUS         = 6
    };

    CSLisaElement(CSLbase* parent, string name) :
      m_deriv      ( string ("") ),    
      m_setType    ( string ("") ), 
      m_width      ( string ("") ),
      CSLbase(CSL_ISA_ELEMENT, parent, name) {
      m_derivF    = false;
      m_posF      = false;
      m_nextF     = false;
      m_prevF     = false;
      for( int i = 0; i < ISA_ELEMENT_USED_VECTOR_SIZE; ++i ) {
        m_used[i] = 0;
      }
    }

    ~CSLisaElement(){}

    bool buildDecl();
    void print();

    void addIsaElementInstance( CSLbase* );
    void genDeriv( CSLbase* );

    void genSetType( CSLbase* );
    void genSetWidth( CSLbase* );

    void genSetPosition();
    void genSetNext();
    void genSetPrevious();
};

}
#endif

