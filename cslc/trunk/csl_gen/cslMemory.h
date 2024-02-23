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

#ifndef CSL_MEM_CODE_GEN_H
#define CSL_MEM_CODE_GEN_H

#include "cslInterconnectGen_TB.h"

using namespace std;
namespace NSCSLinterconnect{

const short M_USED_VECTOR_SIZE    = 4;
const short M_CMD                 = 5;
const string M_FUNCTION[M_USED_VECTOR_SIZE] = {"set_depth",
                                               "get_depth",
                                               "set_width",
                                               "get_width"};

class CSLmemory: public CSLbase {
  public:
    string         m_depth;
    string         m_width;

    int            m_used[M_USED_VECTOR_SIZE];

    enum EFlags {
      SET_DEPTH  = 0,
      GET_DEPTH  = 1,
      SET_WIDTH  = 2,
      GET_WIDTH  = 3
    };

    CSLmemory(CSLbase* parent, string name) :
      m_depth ( string("") ),
      m_width ( string("") ),
      CSLbase(CSL_MEMORY, parent, name) {
      for ( int i = 0; i < M_USED_VECTOR_SIZE; ++i ) {
        m_used[i] = 0;
      }
    }
    ~CSLmemory() {}

    bool buildDecl();
    void print();

    void genSetDepth();
    void genSetWidth();
};

}
#endif
