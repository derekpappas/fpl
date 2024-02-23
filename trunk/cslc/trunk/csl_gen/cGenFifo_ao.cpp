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
//#include "support.h"
#include "cGenFifo_ao.h"
// #include <sstream>

namespace NSCSLinterconnect {

void CSLdesign::addFifo() {
  string name;
  name = randString();
  if (newNameIsValid(name) == true ) {
    CSLfifo* fifo = new CSLfifo(this, name);     
    fifo->buildDecl();
    addChild(fifo);
  }
}


void CSLunit::addFifoInst() {
  CSLbaseVec ch = getParent() -> getChildren();
  vector<CSLbase*>::const_iterator it = ch.begin();

  for (; it < ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIFO ) {
      string name(string(""));
      name.append(randString());
      if (newNameIsValid(name) == true ) {
        CSLinstance* fifoInstance = new CSLinstance(this, (*it), name);
        addChild(fifoInstance);
      }
    }

  }
}     

void CSLfifo::genSetDepth() {
  m_depth = randNumExpr();
}

void CSLfifo::genSetWidth() {
  m_width = randNumExpr();
}

void CSLfifo::genAddLogicProgrDepth(){
  m_defaultDepth = randNumExpr();
}

void CSLfifo::genSetPhysicalImplementation(){
  m_phImpl = FIFO_IMP_TYPE[rand()%2];
}

void CSLfifo::genSetPrefix(){
//   string name = randString();
//   if( newNameIsValid(name) ){
//     m_prefix = name;
//   }
//   if( m_prefix == "") 
//     m_prefix = randString();
  m_prefix.append("\"");
  m_prefix.append( randString() );
  m_prefix.append("\"");
}

void CSLfifo::genAddLogicSync(){
  m_sync = SYNC[rand()%2];
}

void CSLfifo::genAddLogicDepthExtend(){
  m_numExprDepthExt = randNumExpr();
}

void CSLfifo::genAddLogicWidthExtend(){
  m_numExprWidthExt = randNumExpr();
}

void CSLfifo::genAddLogicWrHold(){
  m_numExprWrHold = randNumExpr();
}

void CSLfifo::genAddLogicWrWords() {
  m_wrWordsAddr.append( randNumExpr() );
  m_wrWordsAddr.append( ", " );
  m_wrWordsAddr.append( randNumExpr() );
}

void CSLfifo::genAddLogicRdWords() {
  m_rdWordsAddr.append( randNumExpr() );
  m_rdWordsAddr.append( ", " );
  m_rdWordsAddr.append( randNumExpr() );
}

void CSLfifo::genAddLogicFlowThrough() {
  m_flowNumExpr = randNumExpr();
}

void CSLfifo::genAddLogicEmptyAddress() {
  m_emptyAddress = randNumExpr();
}

void CSLfifo::genAddLogicFullAddress() {
  m_fullAddress = randNumExpr();
}

bool CSLfifo::buildDecl() {
  genSetDepth();
  genSetWidth();
 used[ CSLfifo::SET_DEPTH ] = 1;
 used[ CSLfifo::SET_WIDTH ] = 1;
  for(int i = 0; i < rand()%10; ++i){
    int ran = rand()%FIFO_USED_VECTOR_SIZE;
    //int ran = 9;
    if( !used[ran] ) {
      switch(ran) {
        //        case  CSLfifo::DIM                :  genSetDim();                    break;
        case  CSLfifo::DEFAULT_DEPTH      :  genAddLogicProgrDepth();        break;
        case  CSLfifo::PH_IMPL            :  genSetPhysicalImplementation(); break;
        case  CSLfifo::SYNCR              :  genAddLogicSync();              break;
        case  CSLfifo::NUM_EXPR_DEPTH_EXT :  genAddLogicDepthExtend();       break;
        case  CSLfifo::NUM_EXPR_WIDTH_EXT :  genAddLogicWidthExtend();       break;
        case  CSLfifo::NUM_EXPR_WR_HOLD   :  genAddLogicWrHold();            break;
        case  CSLfifo::PREFIX             :  genSetPrefix();                 break;
        case  CSLfifo::RD_WORDS           :  genAddLogicRdWords();           break;
        case  CSLfifo::WR_WORDS           :  genAddLogicWrWords();           break;
        case  CSLfifo::FLOW_THROUGH       :  genAddLogicFlowThrough();       break;
        case  CSLfifo::EMPTY_ADDRESS      :  genAddLogicEmptyAddress();      break;
        case  CSLfifo::FULL_ADDRESS       :  genAddLogicFullAddress();       break;
      }
      used[ran] = 1;
    }
  }
}

void CSLfifo::print(){
  CslFifo(m_out);//             csl_fifo
  (*m_out) << getName();//  fifo_name
  lCbrace((m_out));//            {

  (*m_out)<<"   "<< getName();
  lParenthesis((m_out));//       (
  rParenthesis((m_out));//       )
  lCbrace((m_out));//            {

  for( int i = 0; i < FIFO_USED_VECTOR_SIZE; ++i ) {
    if( used[i] ) {
      switch( i ) {
        case CSLfifo::SET_DEPTH         :   funct1param((m_out), FIFO_FUNCTION[i], m_depth); break;
        case CSLfifo::SET_WIDTH         :   funct1param((m_out), FIFO_FUNCTION[i], m_width); break;
        //   case CSLfifo::DIM               :   funct2param((m_out), FIFO_FUNCTION[i], m_width    , m_depth           ); break;
        case CSLfifo::DEFAULT_DEPTH     :   funct2param((m_out), FIFO_FUNCTION[i], "programmable_depth" , m_defaultDepth    ); break;
        case CSLfifo::PH_IMPL           :   funct1param((m_out), FIFO_FUNCTION[i], m_phImpl  );                               break;
        case CSLfifo::PRIORITY_BYPASS   :   funct1param((m_out), FIFO_FUNCTION[i], "priority_bypass"  );                               break;
        case CSLfifo::SYNCR             :   funct1param((m_out), FIFO_FUNCTION[i], m_sync    );                               break;
        case CSLfifo::NUM_EXPR_DEPTH_EXT:   funct2param((m_out), FIFO_FUNCTION[i], "depth_extend"      , m_numExprDepthExt ); break;
        case CSLfifo::NUM_EXPR_WIDTH_EXT:   funct2param((m_out), FIFO_FUNCTION[i], "width_extend"      , m_numExprWidthExt ); break;
        case CSLfifo::NUM_EXPR_WR_HOLD  :   funct2param((m_out), FIFO_FUNCTION[i], "wr_hold"           , m_numExprWrHold   ); break;
        case CSLfifo::PREFIX            :   funct1param((m_out), FIFO_FUNCTION[i], m_prefix  );                               break;
        case CSLfifo::PARALLEL_OUTPUT   :   funct2param((m_out), FIFO_FUNCTION[i], "parallel_output"   , "all"                      ); break;
        case CSLfifo::PARALLEL_INPUT    :   funct2param((m_out), FIFO_FUNCTION[i], "parallel_input"    , "all"                      ); break;
        case CSLfifo::RD_WORDS          :   funct2param((m_out), FIFO_FUNCTION[i], "rd_words"          , m_rdWordsAddr     ); break;
        case CSLfifo::WR_WORDS          :   funct2param((m_out), FIFO_FUNCTION[i], "wr_words"          , m_wrWordsAddr     ); break;
        case CSLfifo::PUSH_BACK         :   funct1param((m_out), FIFO_FUNCTION[i], "pushback"         );                               break;
        case CSLfifo::FLOW_THROUGH      :   funct2param((m_out), FIFO_FUNCTION[i], "flow_through"    , m_flowNumExpr     ); break;
        case CSLfifo::STALL             :   funct1param((m_out), FIFO_FUNCTION[i], "stall"            );                               break;
        case CSLfifo::STALL_RD_SIDE     :   funct1param((m_out), FIFO_FUNCTION[i], "stall_rd_side"    );                               break;
        case CSLfifo::STALL_WR_SIDE     :   funct1param((m_out), FIFO_FUNCTION[i], "stall_wr_side"    );                               break;
        case CSLfifo::WR_RELEASE        :   funct1param((m_out), FIFO_FUNCTION[i], "wr_release"       );                               break;
        case CSLfifo::EMPTY_ADDRESS     :   funct2param((m_out), FIFO_FUNCTION[i], "almost_empty"      , m_emptyAddress    ); break;
        case CSLfifo::FULL_ADDRESS      :   funct2param((m_out), FIFO_FUNCTION[i], "almost_full"       , m_fullAddress     ); break;
        case CSLfifo::OUTPUT_WR_ADDR    :   funct1param((m_out), FIFO_FUNCTION[i], "output_wr_addr"   );                               break;
        case CSLfifo::OUTPUT_RD_ADDR    :   funct1param((m_out), FIFO_FUNCTION[i], "output_rd_addr"   );                               break;
        case CSLfifo::CREDIT            :   funct1param((m_out), FIFO_FUNCTION[i], "credit"           );                               break;
        case CSLfifo::RD_CREDIT         :   funct1param((m_out), FIFO_FUNCTION[i], "rd_credit"        );                               break;
        case CSLfifo::WR_CREDIT         :   funct1param((m_out), FIFO_FUNCTION[i], "wr_credit"        );                               break;
        case CSLfifo::FLOW              :   funct1param((m_out), FIFO_FUNCTION[i], "flow"             );                               break;
      }
    }
  }

  (*m_out)<<"  ";
  rCbrace((m_out));//   }
  rCbrace((m_out));//   }
  semicolon((m_out));// ;
    
}
}
