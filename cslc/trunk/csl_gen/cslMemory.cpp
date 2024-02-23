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

#include "cslMemory.h"

using namespace std;
namespace NSCSLinterconnect {

void CSLdesign::addMemory() {
  int flag;
  string name( string("") );
  name.append( randString() );
  if (newNameIsValid( name ) == true ) {
    CSLmemory* mem = new CSLmemory(this, name );
    mem -> buildDecl();
    addChild( mem );
  }
}

void CSLmemory::genSetDepth() {
  m_depth.append( randNumExpr() );
}

void CSLmemory::genSetWidth() {
  m_width.append( randNumExpr() );
}

bool CSLmemory::buildDecl() {
  genSetDepth();
  genSetWidth();

  m_used[CSLmemory::SET_DEPTH] = 1;
  m_used[CSLmemory::SET_WIDTH] = 1;

  //   for(int i = 0; i < rand()%M_CMD; ++i){
  //     int ran = rand()%(MMP_USED_VECTOR_SIZE);    
  //     if( !m_used[ran] ) {
  //       switch( ran ) {
  //       }
  //     }
  //   }
}

void CSLmemory::print() {
  cslMemory( m_out );
  (*m_out) << getName();
  lCbrace((m_out));

  (*m_out) << "    " << getName();
  lParenthesis((m_out));
  rParenthesis((m_out));
  lCbrace((m_out));   

  for(int i = 0; i < M_USED_VECTOR_SIZE; ++i){
    if ( m_used[i] ) {
      switch( i ) {
        case CSLmemory::SET_DEPTH   : funct1param( m_out, M_FUNCTION[i], m_depth ); break;
        case CSLmemory::GET_DEPTH   : funct0param( m_out, M_FUNCTION[i] ); break;
        case CSLmemory::SET_WIDTH   : funct1param( m_out, M_FUNCTION[i], m_width ); break;
        case CSLmemory::GET_WIDTH   : funct0param( m_out, M_FUNCTION[i] ); break;
      }
    }
  }

  (*m_out)<<"  ";
  rCbrace((m_out));
  rCbrace((m_out));
  semicolon((m_out));
}

}
