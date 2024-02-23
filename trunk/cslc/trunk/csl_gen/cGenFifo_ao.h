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

//AO
#ifndef CSL_CODE_GEN_H
#define CSL_CODE_GEN_H

// #include <map>
// #include <stack>
// #include <vector>
// #include <fstream>
// #include <iostream>
// #include <algorithm>
// #include <sstream>

#include "cslInterconnectGen_TB.h"

using namespace std;

namespace NSCSLinterconnect {

const string FIFO_IMP_TYPE[2]       = {"SRAM", "FFA"};
//const short RANDOMS_NO              = 10;
const short FIFO_VECTOR_SIZE        = 2;
const string SYNC[2]                = {"sync_fifo","async_fifo"};
const string UNARY_PREFIXED_OP[6]   = {"+", "-", "!", "~", "++", "--"};
const string BRACES_OP[2]           = {"(", ")"};
const short  FIFO_USED_VECTOR_SIZE       = 28;

const string FIFO_FUNCTION[FIFO_USED_VECTOR_SIZE] = {"set_depth", 
                                           "set_width", 
                                           "add_logic", 
                                           "set_physical_implementation", 
                                           "add_logic", 
                                           "add_logic",
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "set_prefix", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic", 
                                           "add_logic",
                                           "add_logic"};

class CSLfifo: public CSLbase {
  public:

   string               m_width;           
   string               m_depth;           
   string               m_phImpl;          
   string               m_prefix;          
   string               m_defaultDepth;    
   string               m_sync;            
   string               m_numExprDepthExt; 
   string               m_numExprWidthExt; 
   string               m_numExprWrHold;   
   string               m_rdWordsAddr;     
   string               m_wrWordsAddr;     
   string               m_flowNumExpr;     
   string               m_emptyAddress;    
   string               m_fullAddress;     
    //  int                  m_progrDepth;
    //   int                  m_priorityBypass;
    //   string               m_numericExpr;
 //   int                  m_parallelInput;
//    int                  m_parallelOutput;

   int                  used[FIFO_USED_VECTOR_SIZE];

    enum EFlags {
      SET_DEPTH          = 0,
      SET_WIDTH          = 1,
      DEFAULT_DEPTH      = 2,
      PH_IMPL            = 3,
      PRIORITY_BYPASS    = 4,
      SYNCR              = 5,
      NUM_EXPR_DEPTH_EXT = 6,
      NUM_EXPR_WIDTH_EXT = 7,
      NUM_EXPR_WR_HOLD   = 8,
      PREFIX             = 9,
      PARALLEL_OUTPUT    = 10,
      PARALLEL_INPUT     = 11,
      RD_WORDS           = 12,
      WR_WORDS           = 13,
      PUSH_BACK          = 14,
      FLOW_THROUGH       = 15, 
      STALL              = 16,
      STALL_RD_SIDE      = 17, 
      STALL_WR_SIDE      = 18,
      WR_RELEASE         = 19, 
      EMPTY_ADDRESS      = 20,
      FULL_ADDRESS       = 21,
      OUTPUT_WR_ADDR     = 22,
      OUTPUT_RD_ADDR     = 23,
      CREDIT             = 24,
      RD_CREDIT          = 25,
      WR_CREDIT          = 26,
      FLOW               = 27
    };

    CSLfifo(CSLbase* parent, string name):
      CSLbase(CSL_FIFO, parent, name),
      m_width           (string("")),           
      m_depth           (string("")),           
      m_phImpl          (string("")),          
      m_prefix          (string("")),          
      m_defaultDepth    (string("")),    
      m_sync            (string("")),            
      m_numExprDepthExt (string("")), 
      m_numExprWidthExt (string("")), 
      m_numExprWrHold   (string("")),   
      m_rdWordsAddr     (string("")),     
      m_wrWordsAddr     (string("")),     
      m_flowNumExpr     (string("")),     
      m_emptyAddress    (string("")),    
      m_fullAddress     (string("")) {
      
        for( int i = 0; i< FIFO_USED_VECTOR_SIZE; ++i ) {
          used[i] = 0;      
        }
    }

    ~CSLfifo() {}

    bool buildDecl();
    void print();

    void genSetDepth();
    void genSetWidth();
    void genSetPhysicalImplementation();
    void genSetPrefix();

    void genAddLogicProgrDepth();
    void genAddLogicPriorityBypass();
    void genAddLogicSync();
    void genAddLogicDepthExtend(); 
    void genAddLogicWidthExtend();
    void genAddLogicWrHold(); 

    void genAddLogicParallelOutput();
    void genAddLogicParallelInput();
    void genAddLogicWrWords();
    void genAddLogicRdWords();
    void genAddLogicSramRead();
    void genAddLogicSramWrite();
    void genAddLogicFlowThrough();
    void genAddLogicEmptyAddress();
    void genAddLogicFullAddress();

    void buildFifo();
};
}
#endif //CSL_CODE_GEN_H
