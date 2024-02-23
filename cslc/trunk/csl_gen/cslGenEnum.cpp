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

#include "cslInterconnectGen_TB.h"
#include "cslGenEnum.h"

using namespace std;
namespace NSCSLinterconnect{


//=============//
//Class CSLenum//
//=============//

void CSLdesign::addEnum() {
  string enumName = randString();
  if (newNameIsValid(enumName)) {
    CSLenumPoint newEnum = new CSLenum(this, enumName);
    newEnum->buildDecl();
    addChild(newEnum);
  }
}

CSLenum::CSLenum (CSLbase* parent, string name) :
  CSLbase(CSL_ENUM, parent,name) {
}

CSLenum::~CSLenum() {}

bool CSLenum :: buildDecl() {
  int c =  rand() % 2;
  
  for(int i = 1;i <= rand() % 50 + 1 ;i++){
    if(!c){
      string name = randString();
      if(newNameIsValid(name)) {
        CSLenumItemPoint newItem = new CSLenumItem (this, name);
        newItem->buildDecl();
        addChild(newItem);
      }
    }
    else if(c==1){
      string name = randString();
      if(newNameIsValid(name)) {
        CSLenumItemPoint newItem = new CSLenumItem (this, name);
        addChild(newItem);
      }
    }
  }
  return true;
}

void CSLenum :: print(){
  (*m_out) << "csl_enum " << getName() << " {\n";
 CSLbaseVec ch = getChildren();
  CSLbaseVec_cIter it = ch.begin();
  for( ; it < ch.end();it++ ){
    if ((*it) -> getType() == CSL_ENUM_ITEM){
      if(it < ch.end()-1){
        (*it)-> print();(*m_out)<<",\n";
      }
      else{
        (*it)-> print();(*m_out)<<"\n";
      }
    }
  }
  (*m_out) << "};\n"; 
}



//=================//
//Class CSLenumItem//
//=================//

CSLenumItem::CSLenumItem(CSLbase* parent, string name):
  m_valueF(false),
  CSLbase (CSL_ENUM_ITEM, parent, name) {    
}

CSLenumItem::~CSLenumItem() {}

bool CSLenumItem :: buildDecl() {
  m_value = rand() % 100;
  m_valueF = true;
}

void CSLenumItem :: print() {
  (*m_out) <<"\t" <<  getName();
  if ( m_valueF )
    (*m_out) << " = " << m_value ;
}
}
