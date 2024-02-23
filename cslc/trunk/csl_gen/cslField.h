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

#ifndef CSL_FIELD_CODE_GEN_H
#define CSL_FIELD_CODE_GEN_H

#include "cslInterconnectGen_TB.h"

using namespace std;
namespace NSCSLinterconnect{

const short FIELD_INSTANCE_NO        = 3;
const short FIELD_USED_VECTOR_SIZE   = 18;
const short FIELD_CMD                = 200;
const short FIELD_TYPE_DECL_SIZE     = 4;
const short FIELDS_NO                = 3;

const string FIELD_FUNCTION[FIELD_USED_VECTOR_SIZE] = {"set_width",        
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
                                                       "add_allowed_range"};

class CSLfield: public CSLbase {
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

    int                 m_used[FIELD_USED_VECTOR_SIZE];
    int                 m_usedTypeDecl[FIELD_TYPE_DECL_SIZE];

    bool                m_copyF;
    bool                m_bitrangeF;
    bool                m_enumF;
    bool                m_enumItemF;
    bool                m_fieldType;
    bool                m_posF;
    bool                m_nextF;
    bool                m_prevF;
    bool                m_hierarchicalF;

    enum EFlag {
      SET_WIDTH            = 0,
      SET_RANGE            = 1,
      SET_BITRANGE         = 2,
      SET_ENUM             = 3,      
      GET_ENUM             = 4,      
      SET_ENUM_ITEM        = 5,
      GET_ENUM_ITEM        = 6,
      SET_VALUE            = 7,
      GET_VALUE            = 8,
      SET_FIELD_POS        = 9,
      SET_NEXT             = 10,
      SET_PREVIOUS         = 11,
      GET_WIDTH            = 12,
      GET_UPPER            = 13,
      GET_LOWER            = 14,
      SET_OFFSET           = 15,
      GET_OFFSET           = 16,
      ADD_ALLOWED_RANGE    = 17
    };

    enum EFieldTypeDecl {
      WIDTH                = 0,
      UPPER_LOWER          = 1,
      COPY_CONSTR          = 2,
      CONSTR               = 3
    };

    CSLfield(CSLbase* parent, string name) : 
      m_typeDecl       ( string ("") ),   
      m_enum           ( string ("") ),
      m_enumItem       ( string ("") ),
      m_value          ( string ("") ),
      m_width          ( string ("") ),
      m_bitrange       ( string ("") ),
       m_range          ( string ("") ),
      m_offset         ( string ("") ),
//      m_listBitrange   ( string ("") ),
      m_allowedRange   ( string ("") ),
//       m_posField       ( string ("") ),   
//       m_posNumExpr     ( string ("") ),
//       m_nextLeft       ( string ("") ),  
//       m_nextRight      ( string ("") ), 
//       m_prevLeft       ( string ("") ),  
//       m_prevRight      ( string ("") ), 
      CSLbase(CSL_FIELD, parent, name) {
      m_enumF         = false;
      m_enumItemF     = false;
      m_fieldType     = false;
      m_posF          = false;
      m_nextF         = false;
      m_prevF         = false;
      m_bitrangeF     = false;
      m_copyF         = false;
      m_hierarchicalF = false;
      for( int i = 0; i < FIELD_USED_VECTOR_SIZE; ++i ) {
        m_used[i] = 0;      
      }

      for( int i = 0; i < FIELD_TYPE_DECL_SIZE; ++i ) {
        m_usedTypeDecl[i] = 0;      
      }
    }

    ~CSLfield() {}
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

    void genSetFieldPos( );
    void genNext( );
    void genPrevious( );

    void genAllowedRange();
};
}
#endif
